module.exports = App =
  init: ->
    JenkinsClient = require('models/jenkins_client')
    Renderer = require('models/renderer')
    # Bootstrap the app
    renderer        = new Renderer
    client          = new JenkinsClient(renderer)
    renderer.client = client

    client.refresh_jenkins_data()
