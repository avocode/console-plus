EventEmitter = require 'eventemitter3'

LogLevels = require './log-levels'


class Logger extends EventEmitter
  constructor: (transport = null, options = {}) ->
    @_transport = transport
    @_untouchedLevels = options.untouchedLogLevels or []

  extendConsole: (console) ->
    # NOTE: Always start with the native/initial console.
    if console.$__consolePlus
      console = Object.getPrototypeOf(console)

    nextConsole = Object.create(console)
    nextConsole.$__consolePlus = true
    nextConsole.logger = this

    for key, method of console
      if typeof method == 'function'
        nextConsole[key] = method.bind(console)

    if LogLevels.SILLY not in @_untouchedLevels
      nextConsole.silly = @_logMessage.bind(this, LogLevels.SILLY)

    if LogLevels.TRACE not in @_untouchedLevels
      nextConsole.trace = @_logMessage.bind(this, LogLevels.TRACE)

    if LogLevels.DEBUG not in @_untouchedLevels
      nextConsole.debug = @_logMessage.bind(this, LogLevels.DEBUG)

    if LogLevels.INFO not in @_untouchedLevels
      nextConsole.info = @_logMessage.bind(this, LogLevels.INFO)

    if LogLevels.WARN not in @_untouchedLevels
      nextConsole.warn = @_logMessage.bind(this, LogLevels.WARN)

    if LogLevels.ERROR not in @_untouchedLevels
      nextConsole.error = @_logMessage.bind(this, LogLevels.ERROR)

    if LogLevels.FATAL not in @_untouchedLevels
      nextConsole.fatal = @_logMessage.bind(this, LogLevels.FATAL)

    return nextConsole

  setTransport: (transportInstance) ->
    @_transport = transportInstance 

  _logMessage: (logLevel, args...) ->
    @emit('message', {
      logLevel,
      args
    })

    @_transport?.logMessage(logLevel, args...)


module.exports = Logger
