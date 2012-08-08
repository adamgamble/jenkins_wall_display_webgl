class JenkinsClient
  jenkins_data: ""
  refresh_jenkins_data: () ->
    jQuery.getJSON "http://isotope11.selfip.com:8080/api/json?jsonp=?", (data) ->
      Isotope11.WallDisplay.client.jenkins_data = data
      Isotope11.WallDisplay.renderer.render()

#This has to happen right now for the namespacing, maybe there is a better way.
namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

namespace "Isotope11.WallDisplay", (exports) ->
  exports.JenkinsClient = JenkinsClient
