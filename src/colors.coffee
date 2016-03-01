LogLevels = require './log-levels'


module.exports =
  browser:
    "#{LogLevels.FATAL}": 'color: #FFF; background-color: #E00; padding: 0 3px; margin: 0 -3px'
    "#{LogLevels.ERROR}": 'color: #E00; background-color: #FDD; padding: 0 3px; margin: 0 -3px'
    "#{LogLevels.WARN}": 'color: #C63; background-color: #FFA; padding: 0 3px; margin: 0 -3px'
    "#{LogLevels.INFO}": 'color: #5A5; font-weight: bold'
    "#{LogLevels.DEBUG}": 'color: #999'
    "#{LogLevels.TRACE}": 'color: #AAA'
    "#{LogLevels.SILLY}": 'color: #BBB'

  cli:
    "#{LogLevels.FATAL}": '#F00'
    "#{LogLevels.ERROR}": '#A00'
    "#{LogLevels.WARN}": '#CB3'
    "#{LogLevels.INFO}": '#5A5'
    "#{LogLevels.DEBUG}": '#555'
    "#{LogLevels.TRACE}": '#444'
    "#{LogLevels.SILLY}": '#333'
