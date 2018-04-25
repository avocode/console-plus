LogLevels = require '../log-levels'


class BrowserTransport
  constructor: (console, options = {}) ->
    @_console = console

    @_prefixStyle = 'color: #C0C0C0; border-right: 1px solid #D0D0D0; padding-left: 3px'
    @_prefixes = {}
    @_defaultPrefix = ''

    @_styles = {}
    @_defaultStyle = 'color: #000'
    @_levelLimit = options.logLevel or LogLevels.SILLY

  setLogLevelPrefixes: (prefixes) ->
    @_prefixes = prefixes or {}

  setDefaultPrefix: (defaultPrefix) ->
    @_defaultPrefix = defaultPrefix or ''

  setLogLevelStyles: (styles) ->
    @_styles = styles or {}

  setDefaultStyle: (defaultStyle) ->
    @_defaultStyle = defaultStyle or ''

  setLevelLimit: (logLevel) ->
    @_levelLimit = logLevel

  logMessage: (logLevel, args...) ->
    if logLevel > @_levelLimit
      return

    if typeof args[0] != 'object'
      message = args[0]
      args = args.slice(1)
    else
      message = ''

    prefix = @_getLogLevelPrefix(logLevel)
    prefixStyle = @_prefixStyle
    messageStyle = @_getMessageStyle(logLevel)

    log = @_getConsoleMethod(logLevel)
    log.apply(@_console, [
      "%c#{prefix}%c %c#{message}"
      prefixStyle
      'color: #FFF'
      messageStyle
      args...
    ])

  _getLogLevelPrefix: (logLevel) ->
    prefix = @_prefixes[logLevel] or @_defaultPrefix
    return prefix

  _getMessageStyle: (logLevel) ->
    style = @_styles[logLevel] or @_defaultStyle
    return style

  _getConsoleMethod: (logLevel) ->
    switch logLevel
      when LogLevels.SILLY
        return @_console.debug
      when LogLevels.TRACE
        return @_console.trace
      when LogLevels.DEBUG
        return @_console.debug
      when LogLevels.INFO
        return @_console.info
      when LogLevels.WARN
        return @_console.warn
      when LogLevels.ERROR
        return @_console.error
      when LogLevels.FATAL
        return @_console.error
      else
        return @_console.log


module.exports = BrowserTransport
