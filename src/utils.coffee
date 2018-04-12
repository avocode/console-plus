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
  getGlobalScope: getGlobalScope
  isBrowser: isBrowser
