colorize = require 'colorize-str'
util = require 'util'
LogLevels = require '../log-levels'


class CliTransport
  constructor: (outputStream, options = {}) ->
    @_outputStream = outputStream

    @_prefixColor = '#2D2D2D'
    @_prefixes = {}
    @_defaultPrefix = ''

    @_colors = {}
    @_defaultColor = '#FFF'

    @_levelLimit = options.logLevel or LogLevels.SILLY

  setLogLevelPrefixes: (prefixes) ->
    @_prefixes = prefixes or {}

  setDefaultPrefix: (defaultPrefix) ->
    @_defaultPrefix = defaultPrefix or ''

  setLogLevelColors: (colors) ->
    @_colors = colors or {}

  setDefaultColor: (defaultColor) ->
    @_defaultColor = defaultColor or ''

  setLevelLimit: (logLevel) ->
    @_levelLimit = logLevel

  logMessage: (logLevel, args...) ->
    if logLevel > @_levelLimit
      return

    rawPrefix = @_prefixes[logLevel] or @_defaultPrefix
    colorizedPrefix = "{#{@_prefixColor}}#{rawPrefix}"

    emptyPrefix = Array.from(rawPrefix).fill(' ').join('')
    messageColor = @_getMessageColor(logLevel)
    message = util.format(args...).replace(/\n/g, "\n#{emptyPrefix}")

    colorizedMessage = colorize("#{colorizedPrefix}{#{messageColor}}#{message}\n")
    @_outputStream.write(colorizedMessage)

  _getLogLevelPrefix: (logLevel) ->
    color = @_prefixColor
    prefix = @_prefixes[logLevel] or @_defaultPrefix

    return "{#{color}}#{prefix}"

  _getMessageColor: (logLevel) ->
    color = @_colors[logLevel] or @_defaultColor
    return color


module.exports = CliTransport
