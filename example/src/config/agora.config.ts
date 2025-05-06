let localAppId = '028d3ae5541045d0804d54930ad44f26';
try {
  localAppId = require('./appID').default;
  console.log('appID', localAppId);
} catch (error) {
  console.warn(error);
}

const config = {
  // Get your own App ID at https://dashboard.agora.io/
  appId: localAppId,
  // Please refer to https://docs.agora.io/en/Agora%20Platform/token
  token: '007eJxTYOj9+3K3vIH4zv+dgV03tofMVIuJWes+++HnG93z7dRldrQpMBgYWaQYJ6aampoYGpiYphhYGJikmJpYGhskppiYpBmZPVwjntEQyMiweYs6KyMDBIL4PAw5mWWp8ckZiXl5qTkMDADObCOd',
  channelId: 'live_channel',
  uid: 0,
  logFilePath: '',
};

export default config;
