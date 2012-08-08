module.exports = App =
  init: ->
    JenkinsClient = require('lib/jenkins_client')
    Renderer = require('views/renderer')
    # Bootstrap the app
    container = $("#container")
    @renderer  = new Renderer(container)
    @client    = new JenkinsClient

    @client.refresh_jenkins_data =>
      console.log(@client.jenkins_data)
      @renderer.add_data(@client.jenkins_data)
      @animate()
      @refresh_jenkins_data_periodically()

  # Until we separate 'creating stuff' from 'updating stuff' our animate loop can't run...
  # Leaving it here because it's easy enough and this is Right
  animate: ->
    window.requestAnimationFrame =>
      @animate()
    @draw()

  draw: ->
    @renderer.render(@client.jenkins_data)

  refresh_jenkins_data_periodically: ->
    interval = 5000
    setTimeout =>
      @refresh_jenkins_data_periodically()
    , interval
    @client.refresh_jenkins_data()
