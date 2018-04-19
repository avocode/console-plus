colors = require './colors'
LogLevels = require './log-levels'
prefixes = require './prefixes'

BrowserTransport = require './transports/browser-transport'
CliTransport = require './transports/cli-transport'
Logger = require './logger'

{ getGlobalScope, isBrowser } = require './utils'

createBrowserTransport = ->
  globalScope = getGlobalScope()
  transport = new BrowserTransport(globalScope.console)
  transport.setLogLevelPrefixes(prefixes.browser)
  transport.setLogLevelStyles(colors.browser)

  return transport

createCliTransport = ->
  globalScope = getGlobalScope()
  transport = new CliTransport(globalScope.process.stderr)
  transport.setLogLevelPrefixes(prefixes.cli)
  transport.setLogLevelColors(colors.cli)

  return transport

createTransport = ->
  globalScope = getGlobalScope()
  browser = isBrowser(globalScope)

  if browser
    return createBrowserTransport()

  return createCliTransport()


module.exports =
  LogLevels: LogLevels
  
  Logger: Logger

  transports:
    BrowserTransport: BrowserTransport
    CliTransport: CliTransport

  createTransport: createTransport
  createBrowserTransport: createBrowserTransport
  createCliTransport: createCliTransport

  create: (options = {}) ->
    globalScope = getGlobalScope()
    transport = options.transport or createTransport() 

    logger = new Logger(transport, options)
    nextConsole = logger.extendConsole(globalScope.console)

    return nextConsole

  install: (options = {}) ->
    nextConsole = @create(options)
    globalScope = getGlobalScope()
    Object.defineProperties globalScope,
      console:
        value: nextConsole

    if globalScope.console != nextConsole
      throw new Error('Wtf')

    return nextConsole 

  test: ->
    globalScope = getGlobalScope()

    globalScope.console.silly('silly message')
    globalScope.console.trace('trace message')
    globalScope.console.debug('debug message')
    globalScope.console.info('info message')
    globalScope.console.warn('warn message')
    globalScope.console.error('error message')
    globalScope.console.fatal('fatal message')
