module.exports = {
  app: {
    environment: process.env.NODE_ENV || 'development',
  },
  openai: {
    endpoint: process.env.AZURE_OPENAI_ENDPOINT || '',
    apiKey: process.env.AZURE_OPENAI_API_KEY || '',
    deploymentName: process.env.AZURE_OPENAI_DEPLOYMENT_NAME || '',
  },
  search: {
    endpoint: process.env.AZURE_SEARCH_ENDPOINT || '',
    apiKey: process.env.AZURE_SEARCH_API_KEY || '',
    indexName: process.env.AZURE_SEARCH_INDEX_NAME || '',
  },
  speech: {
    endpoint: process.env.AZURE_SPEECH_ENDPOINT || '',
    apiKey: process.env.AZURE_SPEECH_API_KEY || '',
    region: process.env.AZURE_SPEECH_REGION || '',
  },
};
