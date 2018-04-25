# Console Plus

```
npm install cplus
```

[![Build Status](https://travis-ci.org/avocode/console-plus.svg?branch=master)](https://travis-ci.org/avocode/console-plus)

- Adds more `console` log levels: `fatal`, `error`, `warn`, `info`, `log`, `debug`, `trace`, `silly`.
- Makes the console output pretty, styled and prefixed by the log level:

    ![Console Output](docs/images/console-output.png)

- Allows log level limit (option: `logLevel`). NOTE: This will only work with
  built-in transports. So if you override it with your own transport (using `transport` option),
  you have to handle the logic in there.

   ```javascript
   // Only display log levels `warn` and more severe (`error`, `fatal`).
   cplus.install({
     logLevel: cplus.LogLevels.WARN
   })
   ```

- Certain log levels can optionally be left untouched (option: `untouchedLogLevels`).

   ```javascript
   // Do not touch console.error() to keep clickable stack traces.
   cplus.install({
     untouchedLogLevels: [ cplus.LogLevels.ERROR ]
   })
   ```

- You can also pass your own custom transport (option: `transport`).

  ```javascript
  const myCustomTransportInstance = new CustomTransport()

  cplus.install({
    transport: myCustomTransportInstance
  })
  ```

- If you want to get built-in transport that is already set-up with default configuration
  you can use factories `createBrowserTransport` or `createCliTransport` to get transport
  instance (this factory does not take any arguments).
  This is useful if you still want to use `cplus` logging but you may wish
  to capture or modify the incoming data:

  ```javascript
  import { createCliTransport } from 'cplus'


  // ...

  class CustomTransport {
    constructor() {
      this._cliTransport = createCliTransport() 
    }

    logMessage(logLevel, ...args) {
      // do my own stuff here
      const cleanData = convertData(args)

      this._cliTransport.logMessage(logLevel, cleanData)
    }
  }

  ```

- If you want to access built-in transports directly, you can do that. Just import `transports` object
  that contains `BrowserTransport` and `CliTransport` constructors.

- If you need to switch from built-in transport for `Logger` (perhaps after initialization or right after installing `cplus`), you can do so by calling `setTransport`:

```javascript
  import cplus from 'cplus'

  cplus.install({
    untouchedLogLevels: [ cplus.LogLevels.ERROR, cplus.LogLevels.TRACE ],
  })

  // after the installation phase, instance of logger will be avaible in browser
  // like this
  const logger = window.console.logger

  // create your own instance of custom transport
  const customTransport = new CustomTransport()

  // switch from built-in transport to your custom one
  logger.setTransport(customTransport)
```

## Usage

```javascript
import cplus from 'cplus'

// Plain/default installation:
cplus.install()

// Custom installation:
cplus.install({ /* options */ })
```


## Licence

MIT
