[![docker stars](https://img.shields.io/docker/stars/jegbertmanh/nvm-chromium.svg)](https://hub.docker.com/r/jegbertmanh/nvm-chromium/)
[![docker pulls](https://img.shields.io/docker/pulls/jegbertmanh/nvm-chromium.svg)](https://hub.docker.com/r/jegbertmanh/nvm-chromium/)
[![docker build](https://img.shields.io/docker/build/jegbertmanh/nvm-chromium.svg)](https://hub.docker.com/r/jegbertmanh/nvm-chromium/)
[![automated build](https://img.shields.io/docker/automated/jegbertmanh/nvm-chromium.svg)](https://hub.docker.com/r/jegbertmanh/nvm-chromium/)
[![travis  build](https://travis-ci.org/sylvaindumont/docker-node-karma-protractor-chrome.svg?branch=master)](https://travis-ci.org/sylvaindumont/docker-node-karma-protractor-chrome)


# A docker container with nvm and chromium

This image allows to run javascript tests in a headless machine like a CI server.

This image support karma and protractor test under chromium.

Unfortunately, chromium doesn't support container (https://github.com/travis-ci/travis-ci/issues/938), you need to start chromium with --no-sandbox argument to avoid this.

## usage
### in a shell

```bash
docker run --rm -v $(pwd):/app -w /app -it jegbertmanh/nvm-chromium:alpine sh
```

### in gitlab ci
```yaml
job name:
  image: jegbertmanh/nvm-chromium:alpine
```


## configuration
To configure karma and protractor, use this snippets:

### karma

```javascript
browsers: ['Chromium_no_sandbox'],
customLaunchers: {
  Chromium_no_sandbox: {
    base: 'ChromiumHeadless',
    flags: ['--no-sandbox']
  }
},
```

ChromiumHeadless is available since karma-chrome-launcher@2.2.0, on previous versions use:

```javascript
base: 'Chromium',
flags: ['--no-sandbox', '--headless', '--disable-gpu', '--remote-debugging-port=9222']
```

### protractor

```javascript
capabilities: {
  'browserName': 'chrome',
  'chromeOptions': {
    'args': ['no-sandbox', 'headless', 'disable-gpu']
  }
},
```

### maybe still needed?

Add this to protractor config :

```
chromeDriver: '/usr/bin/chromedriver',
```

