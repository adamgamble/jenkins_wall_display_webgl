class Renderer
  render: () ->
    # set the scene size
    WIDTH     = 1024
    HEIGHT    = 768

    # set some camera attributes
    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000

    # get the DOM element to attach to
    # - assume we've got jQuery to hand
    $container = $("#container")

    # create a WebGL renderer, camera
    # and a scene
    renderer = new THREE.WebGLRenderer()
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    scene = new THREE.Scene()

    # add the camera to the scene
    scene.add camera

    # create the sphere's material
    redMaterial = new THREE.MeshLambertMaterial(color: 0xCC0000)
    greenMaterial = new THREE.MeshLambertMaterial(color: 0x99FF33)

    # the camera starts at 0,0,0
    # so pull it back
    camera.position.z = 300

    # start the renderer
    renderer.setSize WIDTH, HEIGHT

    # attach the render-supplied DOM element
    $container.append renderer.domElement

    # set up the sphere vars
    radius = 50
    segments = 16
    rings = 16

    x = -400
    y = 200
    for job in Isotope11.WallDisplay.client.jenkins_data.jobs
      do (job) -> 
        if job.color == "blue"
          material_to_use = greenMaterial
        else
          material_to_use = redMaterial
        sphere = new THREE.Mesh(new THREE.SphereGeometry(radius, segments, rings), material_to_use)
        sphere.position.set(x,y,-600)
        scene.add sphere
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

namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

namespace "Isotope11.WallDisplay", (exports) ->
  exports.Renderer = Renderer
