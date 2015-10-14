_ = require 'lodash'


if window?.document?.createElement # browser
  writeConsoleError = console.error.bind(console)
  writeConsoleWarn = console.warn.bind(console)
  writeConsoleInfo = console.info.bind(console)
  writeConsoleDebug = (console.debug or console.log).bind(console)

  logFatalMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleError('%c[!] %cFATAL', 'color: #C0C0C0', 'color: #FFF; background-color: #E00; padding: 0 3px', args...)
    else
      writeConsoleError('%c[!] %c' + message, 'color: #C0C0C0', 'color: #FFF; background-color: #E00; padding: 0 3px', args...)

  logErrorMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleError('%c[!] %cERROR', 'color: #C0C0C0', 'color: #E00; background-color: #FDD; padding: 0 3px', args...)
    else
      writeConsoleError('%c[!] %c' + message, 'color: #C0C0C0', 'color: #E00; background-color: #FDD; padding: 0 3px', args...)

  logWarnMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleWarn('%c [warn]', 'color: #C0C0C0', args...)
    else
      writeConsoleWarn('%c [warn] %c' + message, 'color: #C0C0C0', 'color: #C63; background-color: #FFA; padding: 0 3px; margin: 0 -3px', args...)

  logInfoMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleInfo('%c [info]', 'color: #C0C0C0', args...)
    else
      writeConsoleInfo('%c [info] %c' + message, 'color: #C0C0C0', 'color: #5A5; font-weight: bold', args...)

  logDebugMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleDebug('%c[debug]', 'color: #C0C0C0', args...)
    else
      writeConsoleDebug('%c[debug] %c' + message, 'color: #C0C0C0', 'color: #999', args...)

  logTraceMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleDebug('%c[trace]', 'color: #C0C0C0', args...)
    else
      writeConsoleDebug('%c[trace] %c' + message, 'color: #C0C0C0', 'color: #AAA', args...)

  logSillyMessage = (message, args...) ->
    if typeof message == 'object' and message != null
      args.unshift(message)
      writeConsoleDebug('%c[silly]', 'color: #C0C0C0', args...)
    else
      writeConsoleDebug('%c[silly] %c' + message, 'color: #C0C0C0', 'color: #BBB', args...)

else # terminal
  colorize = require 'colorize-str'
  { inspect } = require 'util'

  inspectValue = (value) ->
    if typeof value == 'object' and value != null
      return inspect(value)
    return String(value)

  logFatalMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D}[fatal] ') +
      `'\033[41m'` + args.map(inspectValue).join(' ') + `'\033[0m'` +
      '\n'
    )

  logErrorMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D}[error] ') +
      colorize('{#A00}' + args.map(inspectValue).join(' ')) +
      '\n'
    )

  logWarnMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D} [warn] ') +
      colorize('{#CB3}' + args.map(inspectValue).join(' ')) +
      '\n'
    )

  logInfoMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D} [info] ') +
      colorize('{#5A5}' + args.map(inspectValue).join(' ')) +
      '\n'
    )

  logDebugMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D}[debug] ') +
      colorize('{#555}' + args.map(inspectValue).join(' ')) +
      '\n'
    )

  logTraceMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D}[trace] ') +
      colorize('{#444}' + args.map(inspectValue).join(' ')) +
      '\n'
    )

  logSillyMessage = (args...) ->
    process.stderr.write(
      colorize('{#2D2D2D}[silly] ') +
      colorize('{#333}' + args.map(inspectValue).join(' ')) +
      '\n'
    )


module.exports =
  install: ->
    console.silly = _.partial(logSillyMessage)
    console.trace = _.partial(logTraceMessage)
    console.debug = _.partial(logDebugMessage)
    console.info = _.partial(logInfoMessage)
    console.warn = _.partial(logWarnMessage)
    console.error = _.partial(logErrorMessage)
    console.fatal = _.partial(logFatalMessage)

  test: ->
    console.silly('silly message')
    console.trace('trace message')
    console.debug('debug message')
    console.info('info message')
    console.warn('warn message')
    console.error('error message')
    console.fatal('fatal message')
