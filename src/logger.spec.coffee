it = require 'ava'

Logger = require './logger'


it 'should return an extended console object', (test) ->
  logger = new Logger()
  extendedConsole = logger.extendConsole(console)
  test.ok(extendedConsole)


it 'should keep console.log()', (test) ->
  logger = new Logger()
  extendedConsole = logger.extendConsole(console)
  test.notThrows ->
    extendedConsole.log('Testing console.log()')


it 'should keep arbitrary console methods', (test) ->
  originalConsole =
    x: ->
    y: ->
    whatever: ->

  logger = new Logger()
  extendedConsole = logger.extendConsole(originalConsole)
  test.is(typeof extendedConsole.x, 'function')
  test.is(typeof extendedConsole.y, 'function')
  test.is(typeof extendedConsole.whatever, 'function')


# NOTE: This tests against "Illegal invocation".
it 'should invoke console.log in the context of the original console',
(test) ->
  consoleLogContext = null
  originalConsole =
    log: -> consoleLogContext = this

  logger = new Logger()
  extendedConsole = logger.extendConsole(originalConsole)
  extendedConsole.log('Testing console.log()')
  test.is(consoleLogContext, originalConsole)


# NOTE: This tests against "Illegal invocation".
it 'should invoke console.log in the context of the original console ' +
    'even when it was defined on a prototype', (test) ->
  consoleLogContext = null
  originalConsolePrototype =
    log: -> consoleLogContext = this

  originalConsole = Object.create(originalConsolePrototype)

  logger = new Logger()
  extendedConsole = logger.extendConsole(originalConsole)
  extendedConsole.log('Testing console.log()')
  test.is(consoleLogContext, originalConsole)
