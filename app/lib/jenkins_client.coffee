module.exports = class JenkinsClient
  refresh_jenkins_data: (callback) ->
    jQuery.getJSON "http://isotope11.selfip.com:8080/api/json?jsonp=?", (data) =>
      @jenkins_data = data
      callback() if callback
