LogLevels = require './log-levels'


module.exports =
  browser:
    "#{LogLevels.FATAL}": '  ! '
    "#{LogLevels.ERROR}": '  ! '
    "#{LogLevels.WARN}": ' warn '
    "#{LogLevels.INFO}": ' info '
    "#{LogLevels.DEBUG}": 'debug '
    "#{LogLevels.TRACE}": '... '
    "#{LogLevels.SILLY}": 'silly '

  cli:
    "#{LogLevels.FATAL}": ' fatal | '
    "#{LogLevels.ERROR}": ' error | '
    "#{LogLevels.WARN}": '  warn | '
    "#{LogLevels.INFO}": '  info | '
    "#{LogLevels.DEBUG}": ' debug | '
    "#{LogLevels.TRACE}": ' trace | '
    "#{LogLevels.SILLY}": ' silly | '
