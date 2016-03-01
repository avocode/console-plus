LogLevels = require './log-levels'


class Logger
  constructor: (transport, options = {}) ->
    @_transport = transport
    @_levelLimit = options.logLevel or LogLevels.SILLY
    @_untouchedLevels = options.untouchedLogLevels or []

  setLevelLimit: (logLevel) ->
    @_levelLimit = logLevel

  extendConsole: (console) ->
    # NOTE: Always start with the native/initial console.
    if console.$__consolePlus
      console = Object.getProtytypeOf(console)

    nextConsole = Object.create(console)
    nextConsole.$__consolePlus = true

    if LogLevels.SILLY not in @_untouchedLevels
      nextConsole.silly = @_logMessage.bind(this, LogLevels.SILLY)
    else
      nextConsole.silly = console.silly?.bind(console)

    if LogLevels.TRACE not in @_untouchedLevels
      nextConsole.trace = @_logMessage.bind(this, LogLevels.TRACE)
    else
      nextConsole.trace = console.trace?.bind(console)

    if LogLevels.DEBUG not in @_untouchedLevels
      nextConsole.debug = @_logMessage.bind(this, LogLevels.DEBUG)
    else
      nextConsole.debug = console.debug?.bind(console)

    if LogLevels.INFO not in @_untouchedLevels
      nextConsole.info = @_logMessage.bind(this, LogLevels.INFO)
    else
      nextConsole.info = console.info?.bind(console)

    if LogLevels.WARN not in @_untouchedLevels
      nextConsole.warn = @_logMessage.bind(this, LogLevels.WARN)
    else
      nextConsole.warn = console.warn?.bind(console)

    if LogLevels.ERROR not in @_untouchedLevels
      nextConsole.error = @_logMessage.bind(this, LogLevels.ERROR)
    else
      nextConsole.error = console.error?.bind(console)

    if LogLevels.FATAL not in @_untouchedLevels
      nextConsole.fatal = @_logMessage.bind(this, LogLevels.FATAL)
    else
      nextConsole.fatal = console.fatal?.bind(console)

    return nextConsole

  _logMessage: (logLevel, args...) ->
    if logLevel > @_levelLimit
      return

    @_transport.logMessage(logLevel, args...)


module.exports = Logger
