#This has to happen right now for the namespacing, maybe there is a better way.
namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

$(document).ready ->
  client        = new Isotope11.WallDisplay.JenkinsClient
  renderer      = new Isotope11.WallDisplay.Renderer

  #Export the instances to the namespace so we can get at them whenever we want
  namespace "Isotope11.WallDisplay", (exports) ->
    exports.client    = client
    exports.renderer  = renderer

  client.refresh_jenkins_data()
