function fn() {
  karate.log('>>>> karate-config.js loaded');
  karate.log('>>>> browser property passed in:', karate.properties['browser']);

  const browser = karate.properties['browser'] || 'chrome';

  const config = {
    baseUrl: 'https://www.saucedemo.com/v1/',
    browser: browser
  };

  if (browser === 'chrome') {
    karate.configure('driver', {
    type: 'chrome',
    headless: false,
    showDriverLog: true,
    timeout: 30000,
    addOptions: ['--incognito', '--start-maximized']
  })
  } else if (browser === 'firefox') {
    karate.configure('driver', {
    type: 'geckodriver',
    executable: 'C:/geckodriver/geckodriver.exe',
    binary: 'C:/Program Files/Mozilla Firefox/firefox.exe',
    headless: false,
    showDriverLog: true
  });
  }

  karate.log('=========== Running UI tests on browser:', browser);
  return config;
}