module.exports = App =
  init: ->
    JenkinsClient = require('lib/jenkins_client')
    Renderer = require('views/renderer')
    # Bootstrap the app
    renderer        = new Renderer
    client          = new JenkinsClient(renderer)
    renderer.client = client

    client.refresh_jenkins_data()
