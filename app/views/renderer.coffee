JobRenderer = require('views/job_renderer')

module.exports = class Renderer
  # Initialize the renderer with the dom element it's to render in
  constructor: (@container) ->
    # set the scene size
    @width     = 1024
    @height    = 768

    # set some camera attributes
    @view_angle = 45
    @aspect = @width / @height
    @near = 0.1
    @far = 10000

    @starting_x = -400
    @starting_y = 200

    # create a WebGL renderer, camera
    # and a scene
    @gl_renderer = new THREE.WebGLRenderer()
    @camera = new THREE.PerspectiveCamera(@view_angle, @aspect, @near, @far)
    @scene = new THREE.Scene()

    # add the camera to the scene
    @scene.add @camera

    # the camera starts at 0,0,0
    # so pull it back
    @camera.position.z = 300

    # start the renderer
    @gl_renderer.setSize @width, @height

    # create a point light
    pointLight = new THREE.PointLight(0xFFFFFF)

    # set its position
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130

    # add to the scene
    @scene.add pointLight

    # attach the render-supplied DOM element
    @container.append @gl_renderer.domElement

  render: (data) ->
    x = @starting_x
    y = @starting_y

    for job in data.jobs
      do (job) => 
        job_renderer = new JobRenderer(job, x, y)
        @scene.add job_renderer.render()
        x = x + 100
        if x > 400
          x = -400
          y = y - 100

    # draw!
    @gl_renderer.render @scene, @camera
