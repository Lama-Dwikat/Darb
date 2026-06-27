'use strict';

const { PLACES } = require('../data/dataset');

const INTEREST_CATEGORY_MAP = {
  religious:    ['Religious'],
  religion:     ['Religious'],
  historical:   ['Historical'],
  history:      ['Historical', 'Culture'],
  nature:       ['Nature'],
  outdoors:     ['Nature', 'Family'],
  food:         ['Food'],
  dining:       ['Food'],
  shopping:     ['Shopping'],
  market:       ['Shopping'],
  family:       ['Family', 'Nature', 'Food'],
  kids:         ['Family', 'Nature'],
  culture:      ['Culture', 'Historical'],
  cultural:     ['Culture', 'Historical'],
  art:          ['Culture'],
  heritage:     ['Historical', 'Religious'],
  architecture: ['Historical', 'Religious', 'Culture'],
  adventure:    ['Nature', 'Family'],
  spiritual:    ['Religious'],
};

function resolveCategories(interests) {
  const resolved = new Set();
  for (const interest of interests) {
    const categories = INTEREST_CATEGORY_MAP[interest.toLowerCase().trim()];
    if (categories) {
      categories.forEach(c => resolved.add(c));
    }
  }
  return resolved.size > 0
    ? Array.from(resolved)
    : ['Religious', 'Historical', 'Culture', 'Nature', 'Food', 'Shopping', 'Family'];
}

function filterByCategories(places, categories) {
  const matched = places.filter(p => categories.includes(p.category));
  return matched.length >= 2 ? matched : [...places];
}

function applyVariation(places) {
  const pool = [...places];
  for (let i = 0; i < pool.length - 1; i++) {
    if (Math.random() < 0.4) {
      const j = i + 1;
      [pool[i], pool[j]] = [pool[j], pool[i]];
    }
  }
  return pool;
}

function selectByDuration(places, maxDuration) {
  const selected = [];
  let accumulated = 0;

  for (const place of places) {
    if (selected.length >= 6) break;
    if (accumulated + place.estimated_duration_min <= maxDuration) {
      selected.push(place);
      accumulated += place.estimated_duration_min;
    }
  }

  return selected;
}

function assignAiScores(selected) {
  const startScore = 97 + Math.floor(Math.random() * 2);
  return selected.map((place, index) => {
    const step = index === 0 ? 0 : 2 + (Math.random() < 0.4 ? 1 : 0);
    const score = Math.max(85, startScore - (index * 2) - (index > 0 ? step - 2 : 0));
    return { ...place, score };
  });
}

function recommend(request) {
  const { interests, duration_min } = request;

  const categories = resolveCategories(interests);
  const filtered   = filterByCategories(PLACES, categories);

  const sorted = [...filtered].sort((a, b) => b.score - a.score);
  const varied = applyVariation(sorted);
  const selected = selectByDuration(varied, duration_min);

  return assignAiScores(selected);
}

module.exports = { recommend };
