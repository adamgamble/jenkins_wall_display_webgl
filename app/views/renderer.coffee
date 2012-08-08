JobRenderer = require('views/job_renderer')

module.exports = class Renderer
  # Initialize the renderer with the dom element it's to render in
  constructor: (@container) ->

  render: (data) ->
    # set the scene size
    WIDTH     = 1024
    HEIGHT    = 768

    # set some camera attributes
    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000

    # create a WebGL renderer, camera
    # and a scene
    renderer = new THREE.WebGLRenderer()
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    scene = new THREE.Scene()

    # add the camera to the scene
    scene.add camera

    # the camera starts at 0,0,0
    # so pull it back
    camera.position.z = 300

    # start the renderer
    renderer.setSize WIDTH, HEIGHT

    # attach the render-supplied DOM element
    @container.append renderer.domElement

    x = -400
    y = 200
    for job in data.jobs
      do (job) -> 
        job_renderer = new JobRenderer(job, x, y)
        scene.add job_renderer.render()
        x = x + 100
        if x > 400
          x = -400
          y = y - 100


    # create a point light
    pointLight = new THREE.PointLight(0xFFFFFF)

    # set its position
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130

    # add to the scene
    scene.add pointLight

    # draw!
    renderer.render scene, camera