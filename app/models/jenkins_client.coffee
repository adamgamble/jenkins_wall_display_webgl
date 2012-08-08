module.exports = class JenkinsClient
  constructor: (@renderer) ->
  refresh_jenkins_data: () ->
    jQuery.getJSON "http://isotope11.selfip.com:8080/api/json?jsonp=?", (data) =>
      @jenkins_data = data
      @renderer.render()
