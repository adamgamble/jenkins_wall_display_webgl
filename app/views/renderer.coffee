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

    # Define the job grid parameters
    @starting_x = -400
    @starting_y = 200
    @starting_z = -600
    @camera_z   = 300

    @max_x = 400
    @next_rendering_spot_x_offset = 100
    @next_rendering_spot_y_offset = 100

    # Setup threejs bits
    @set_up_renderer_and_scene()

  render: (data) ->
    @current_x = @starting_x
    @current_y = @starting_y
    @current_z = @starting_z

    for job in data.jobs
      do (job) => 
        job_renderer = new JobRenderer(job, @current_x, @current_y, @current_z)
        @scene.add job_renderer.render()
        @go_to_next_rendering_spot()

    # draw!
    @gl_renderer.render @scene, @camera

  # ---- INTERNAL METHODS AFTER THIS ----
  set_up_renderer_and_scene: ->
    @initialize_gl_renderer()
    @scene = new THREE.Scene()
    @add_camera()
    @add_lighting()

  initialize_gl_renderer: ->
    @gl_renderer = new THREE.WebGLRenderer()
    # start the renderer
    @gl_renderer.setSize @width, @height
    # attach the render-supplied DOM element
    @container.append @gl_renderer.domElement

  # add the camera to the scene
  add_camera: ->
    @camera = new THREE.PerspectiveCamera(@view_angle, @aspect, @near, @far)
    # the camera starts at 0,0,0
    # so pull it back
    @camera.position.z = @camera_z
    @scene.add @camera

  add_lighting: ->
    # create a point light
    pointLight = new THREE.PointLight(0xFFFFFF)

    # set its position
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130

    # add to the scene
    @scene.add pointLight

  go_to_next_rendering_spot: ->
    @current_x += @next_rendering_spot_x_offset
    if @current_x > @max_x
      @current_x  = @starting_x
      @current_y -= @next_rendering_spot_y_offset
