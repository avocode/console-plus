colorize = require 'colorize-str'
util = require 'util'


class CliTransport
  constructor: (outputStream) ->
    @_outputStream = outputStream

    @_prefixColor = '#2D2D2D'
    @_prefixes = {}
    @_defaultPrefix = ''

    @_colors = {}
    @_defaultColor = '#FFF'

  setLogLevelPrefixes: (prefixes) ->
    @_prefixes = prefixes or {}

  setDefaultPrefix: (defaultPrefix) ->
    @_defaultPrefix = defaultPrefix or ''

  setLogLevelColors: (colors) ->
    @_colors = colors or {}

  setDefaultColor: (defaultColor) ->
    @_defaultColor = defaultColor or ''

  logMessage: (logLevel, args...) ->
    message = util.format(args...)
    prefix = @_getLogLevelPrefix(logLevel)
    color = @_getMessageColor(logLevel)

    colorizedMessage = colorize("#{prefix}{#{color}}#{message}\n")
    @_outputStream.write(colorizedMessage)

  _getLogLevelPrefix: (logLevel) ->
    color = @_prefixColor
    prefix = @_prefixes[logLevel] or @_defaultPrefix

    return "{#{color}}#{prefix}"

  _getMessageColor: (logLevel) ->
    color = @_colors[logLevel] or @_defaultColor
    return color


module.exports = CliTransport
