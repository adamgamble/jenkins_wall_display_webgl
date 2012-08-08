module.exports = class JobRenderer
  constructor: (@job, @x, @y) ->
    # create the sphere's material
    @redMaterial = new THREE.MeshLambertMaterial(color: 0xCC0000)
    @greenMaterial = new THREE.MeshLambertMaterial(color: 0x99FF33)

  render: ->
    # set up the cube vars
    width     = 50
    height    = 50
    depth     = 50
    segments  = 16

    cube = new THREE.Mesh(new THREE.CubeGeometry(width, height, depth, segments, segments, segments, @material()), new THREE.MeshFaceMaterial())
    cube.position.set(@x, @y, -600)
    cube

  material: ->
    switch @job.color
      when "blue"
        @greenMaterial
      else
        @redMaterial
