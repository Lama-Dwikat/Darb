const fs = require('fs');
const path = require('path');

const SITES_PATH = path.join(__dirname, '..', 'data', 'sites.json');

let cachedSites = null;

function loadSites() {
  if (cachedSites) return cachedSites;
  const raw = fs.readFileSync(SITES_PATH, 'utf-8');
  const parsed = JSON.parse(raw);
  if (!Array.isArray(parsed) || parsed.length === 0) {
    throw new Error('Site dataset is empty or invalid.');
  }
  cachedSites = parsed;
  return cachedSites;
}

function parseDurationToMinutes(duration) {
  if (typeof duration === 'number' && duration > 0) return duration;
  if (!duration || typeof duration !== 'string') return 120;

  let total = 0;
  const hours = duration.match(/(\d+)\s*h/i);
  const minutes = duration.match(/(\d+)\s*m/i);
  if (hours) total += parseInt(hours[1], 10) * 60;
  if (minutes) total += parseInt(minutes[1], 10);

  if (!hours && !minutes) {
    const numeric = parseInt(duration, 10);
    if (!Number.isNaN(numeric)) total = numeric;
  }

  return total > 0 ? total : 120;
}

function formatMinutes(mins) {
  const h = Math.floor(mins / 60);
  const m = mins % 60;
  if (h > 0 && m > 0) return `${h}h ${m}m`;
  if (h > 0) return `${h}h 0m`;
  return `${m}m`;
}

function scoreLocation(site, interestsLower) {
  let matchCount = 0;
  if (interestsLower.includes(String(site.category).toLowerCase())) {
    matchCount += 1;
  }
  const tags = Array.isArray(site.tags) ? site.tags.map((t) => String(t).toLowerCase()) : [];
  for (const interest of interestsLower) {
    if (tags.includes(interest)) matchCount += 1;
  }
  return matchCount;
}

function buildTitle(interestLabels, cities) {
  const interestPart = interestLabels.length > 0 ? interestLabels.join(' & ') : 'Curated';
  const cityPart = cities.length > 0 ? cities.slice(0, 2).join(' & ') : 'Palestine';
  return `${interestPart} Journey through ${cityPart}`;
}

/**
 * Generate a trip itinerary from the local dataset using a rule-based engine.
 *
 * This service intentionally mirrors the shape an AI provider (Gemini / Azure
 * OpenAI) would return so it can be swapped in later with minimal changes:
 * same input ({ language, interests, duration }) and same output
 * ({ title, totalDuration, locations: [...] }).
 */
function recommendItinerary({ interests = [], duration = '2h 0m' } = {}) {
  const sites = loadSites();

  const interestLabels = (Array.isArray(interests) ? interests : []).map(String);
  const interestsLower = interestLabels.map((i) => i.toLowerCase());
  const budget = parseDurationToMinutes(duration);

  const MIN_LOCATIONS = 3;
  const MAX_LOCATIONS = 8;

  // Score every site by how well it matches the user's interests.
  const scored = sites.map((site) => ({
    site,
    matchCount: scoreLocation(site, interestsLower),
  }));

  // Rank: more interest matches first, then by popularity.
  scored.sort((a, b) => {
    if (b.matchCount !== a.matchCount) return b.matchCount - a.matchCount;
    return (b.site.popularityScore || 0) - (a.site.popularityScore || 0);
  });

  // Prefer matched sites; if nothing matches, fall back to most popular.
  const matched = scored.filter((entry) => entry.matchCount > 0);
  const poolEntries = matched.length > 0 ? matched : scored;
  const poolSites = poolEntries.map((entry) => entry.site);

  // Sum of the N shortest durations among a list of sites (used to reserve
  // enough of the budget to still reach the minimum number of stops).
  const sumShortest = (candidates, n) => {
    if (n <= 0) return 0;
    return candidates
      .map((s) => s.duration_min)
      .sort((a, b) => a - b)
      .slice(0, n)
      .reduce((acc, d) => acc + d, 0);
  };

  const selected = [];
  let used = 0;

  // Greedily fill by relevance, but treat the requested duration as a hard cap.
  // Before taking a site, reserve enough budget for the shortest remaining
  // sites so we can still reach the 3-stop minimum without overrunning.
  for (const entry of poolEntries) {
    if (selected.length >= MAX_LOCATIONS) break;

    const candidate = entry.site;
    const newUsed = used + candidate.duration_min;
    if (newUsed > budget) continue;

    const stillNeeded = MIN_LOCATIONS - (selected.length + 1);
    if (stillNeeded > 0) {
      const remaining = poolSites.filter(
        (s) => s !== candidate && !selected.includes(s),
      );
      if (remaining.length >= stillNeeded) {
        const reserve = sumShortest(remaining, stillNeeded);
        if (newUsed + reserve > budget) continue; // skip to leave room for the minimum
      }
    }

    selected.push(candidate);
    used = newUsed;
  }

  // If the budget is physically too small to fit the minimum within the cap,
  // add the shortest remaining sites to reach the minimum (smallest possible overrun).
  if (selected.length < MIN_LOCATIONS) {
    const remaining = poolSites
      .filter((s) => !selected.includes(s))
      .sort((a, b) => a.duration_min - b.duration_min);
    for (const site of remaining) {
      if (selected.length >= MIN_LOCATIONS) break;
      selected.push(site);
      used += site.duration_min;
    }
  }

  // Map internal records to the response contract the frontend expects.
  const locations = selected.map((site) => ({
    name: site.name,
    duration: `${site.duration_min} min`,
    description: site.description,
    category: site.category,
    imageUrl: site.image || null,
  }));

  const cities = [...new Set(selected.map((s) => s.city))];

  return {
    title: buildTitle(interestLabels, cities),
    totalDuration: formatMinutes(used),
    locations,
  };
}

module.exports = {
  recommendItinerary,
  parseDurationToMinutes,
  formatMinutes,
  loadSites,
};
