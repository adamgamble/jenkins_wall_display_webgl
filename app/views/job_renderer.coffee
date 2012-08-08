module.exports = class JobRenderer
  constructor: (@job, @x, @y, @z) ->
    # create the sphere's material
    @redMaterial = new THREE.MeshLambertMaterial(color: 0xCC0000)
    @greenMaterial = new THREE.MeshLambertMaterial(color: 0x99FF33)

  render: ->
    console.log(@job)
    # set up the cube vars
    width     = 50
    height    = 50
    depth     = 50
    segments  = 16

    cube = new THREE.Mesh(new THREE.CubeGeometry(width, height, depth, segments, segments, segments, @material()), new THREE.MeshFaceMaterial())
    cube.position.set(@x, @y, @z)
    cube

  # Ideally, we'd make a new renderer for each job color and inherit from a baserenderer, then use a rendererfactory to pick the renderer for the job.
  # This won't matter until there's another switch on a job property
  # It would be a place that the materials could live and not be re-instantiated per-job/per-render
  material: ->
    switch @job.color
      when "blue"
        @greenMaterial
      else
        @redMaterial
