module.exports = class JobRenderer
  constructor: (@job, @x, @y, @z) ->
    # create the cube's material
    @redMaterial = new THREE.MeshLambertMaterial(color: 0xCC0000)
    @greenMaterial = new THREE.MeshLambertMaterial(color: 0x99FF33)
    @yellowMaterial = new THREE.MeshLambertMaterial(color: 0xFF9933)

    @create_cube()

  render: ->
    # Change the color for the material based on the state
    mat = @material()
    mat.opacity = @materialOpacity()
    @cube.material = mat
    # return the mesh
    @cube

  create_cube: ->
    # set up the cube vars
    width     = 50
    height    = 50
    depth     = 50

    @cube_geom = new THREE.CubeGeometry(width, height, depth)
    @cube = new THREE.Mesh(@cube_geom, @redMaterial)
    @cube.position.set(@x, @y, @z)
    @cube

  # Ideally, we'd make a new renderer for each job color and inherit from a baserenderer, then use a rendererfactory to pick the renderer for the job.
  # This won't matter until there's another switch on a job property
  # It would be a place that the materials could live and not be re-instantiated per-job/per-render
  material: ->
    if /blue/.test @job.color
      @greenMaterial
    else
      @redMaterial

  materialOpacity: ->
    if /anime/.test @job.color # Prime opportunity for model method #building?
      1 + Math.sin(new Date().getTime() * .0025)
    else
      1
