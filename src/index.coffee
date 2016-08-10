colors = require './colors'
LogLevels = require './log-levels'
prefixes = require './prefixes'

BrowserTransport = require './transports/browser-transport'
CliTransport = require './transports/cli-transport'
Logger = require './logger'


getGlobalScope = ->
  if typeof global != 'undefined'
    return global

  return window


isBrowser = (globalScope) ->
  return (
    globalScope.window?.document?.createElement and
    globalScope.window?.name != 'nodejs'
  )


module.exports =
  LogLevels: LogLevels
  
  Logger: Logger

  create: (options = {}) ->
    globalScope = getGlobalScope()
    browser = isBrowser(globalScope)

    if browser
      transport = new BrowserTransport(globalScope.console)
      transport.setLogLevelPrefixes(prefixes.browser)
      transport.setLogLevelStyles(colors.browser)
    else
      transport = new CliTransport(globalScope.process.stderr)
      transport.setLogLevelPrefixes(prefixes.cli)
      transport.setLogLevelColors(colors.cli)

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

  test: ->
    globalScope = getGlobalScope()

    globalScope.console.silly('silly message')
    globalScope.console.trace('trace message')
    globalScope.console.debug('debug message')
    globalScope.console.info('info message')
    globalScope.console.warn('warn message')
    globalScope.console.error('error message')
    globalScope.console.fatal('fatal message')
