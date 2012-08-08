JobRenderer = require('views/job_renderer')

module.exports = class Renderer
  # Initialize the renderer with the dom element it's to render in
  constructor: (@container) ->
    # set the scene size
    @width     = 1280
    @height    = 1024

    # set some camera attributes
    @field_of_view = 48
    @aspect = @width / @height
    @near = 0.1
    @far = 20000

    # Define the job grid parameters
    @starting_x = -400
    @starting_y = 200
    @starting_z = -600

    @max_x = 400
    @next_rendering_spot_x_offset = 100
    @next_rendering_spot_y_offset = 100

    @camera_z     = 500
    # Handle camera rove
    camera_rove_delta = 100
    @min_camera_z = @camera_z - camera_rove_delta
    @max_camera_z = @camera_z + camera_rove_delta
    @camera_direction = -1

    # Setup threejs bits
    @set_up_renderer_and_scene()

    @job_renderers = {}

  add_data: (data) ->
    @current_x = @starting_x
    @current_y = @starting_y
    @current_z = @starting_z

    # Add a cube per job
    for job in data.jobs
      do (job) => 
        job_renderer = new JobRenderer(job, @current_x, @current_y, @current_z)
        @job_renderers[job.name] = job_renderer
        @scene.add job_renderer.render()
        @go_to_next_rendering_spot()

    @render(data)

  render: (data) ->
    # re-render all the job renderers, so they're ready when the gl_renderer renders
    for job in data.jobs
      do (job) => 
        renderer = @job_renderers[job.name]
        renderer.job = job
        renderer.render()

    # Move the camera a little
    @rove_camera()

    # draw!
    @gl_renderer.render @scene, @camera

  # ---- INTERNAL METHODS AFTER THIS ----
  set_up_renderer_and_scene: ->
    @initialize_gl_renderer()

    @scene = new THREE.Scene()
    #@scene.fog = new THREE.Fog( 0xffffff, -1000, 1000 )
     
    @add_camera()
    @add_lighting()

  initialize_gl_renderer: ->
    @gl_renderer = new THREE.WebGLRenderer()
    # start the renderer
    @gl_renderer.setSize @width, @height
    @gl_renderer.sortObjects = false
    # attach the render-supplied DOM element
    @container.append @gl_renderer.domElement

  # add the camera to the scene
  add_camera: ->
    @camera = new THREE.PerspectiveCamera(@field_of_view, @aspect, @near, @far)
    # the camera starts at 0,0,0
    # so pull it back
    @camera.position.z = @camera_z
    @scene.add @camera

  # Make the camera rove
  rove_camera: ->
    @camera.position.z = @camera.position.z + (@camera_direction)
    @handle_camera_direction()

  # if we've moved past our max in either direction, change camera rove direction
  handle_camera_direction: ->
    if @camera.position.z < @min_camera_z or @camera.position.z > @max_camera_z
      @camera_direction = @camera_direction * -1

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
