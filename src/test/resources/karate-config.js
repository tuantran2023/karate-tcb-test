function fn() {
  karate.log('>>>> karate-config.js loaded');
  karate.log('>>>> browser property passed in:', karate.properties['browser']);

  const browser = karate.properties['browser'] || 'chrome';
  const isCI = karate.env === 'ci'; // Assume Jenkins uses `karate.env=ci`

  const config = {
    baseUrl: 'https://www.saucedemo.com/v1/',
    browser: browser
  };

  if (browser === 'chrome') {
    karate.configure('driver', {
      type: 'chrome',
      headless: isCI,
      showDriverLog: true,
      timeout: 30000,
      addOptions: ['--incognito', '--start-maximized']
    });
  } else if (browser === 'firefox') {
    // Determine dynamic paths

    const geckoExecutable = isCI
      ? '/usr/local/bin/geckodriver'     // Jenkins/Linux
      : 'C:/geckodriver/geckodriver.exe'; // Local

    const firefoxBinary = isCI
      ? '/usr/bin/firefox'               // Jenkins/Linux
      : 'C:/Program Files/Mozilla Firefox/firefox.exe'; // Local

    karate.configure('driver', {
      type: 'geckodriver',
      executable: geckoExecutable,
      binary: firefoxBinary,
      headless: isCI,
      showDriverLog: true
    });
  }

  karate.log('=========== Running UI tests on browser:', browser);
  return config;
}
