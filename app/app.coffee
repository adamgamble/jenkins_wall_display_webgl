module.exports = App =
  init: ->
    JenkinsClient = require('lib/jenkins_client')
    Renderer = require('views/renderer')
    # Bootstrap the app
    container = $("#container")
    renderer  = new Renderer(container)
    client    = new JenkinsClient(renderer)

    client.refresh_jenkins_data()
