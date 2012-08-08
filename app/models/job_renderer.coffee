module.exports = class JobRenderer
  constructor: (@job, @x, @y) ->
  render: ->
    # set up the sphere vars
    radius = 50
    segments = 16
    rings = 16

    # create the sphere's material
    redMaterial = new THREE.MeshLambertMaterial(color: 0xCC0000)
    greenMaterial = new THREE.MeshLambertMaterial(color: 0x99FF33)

    if @job.color == "blue"
      material_to_use = greenMaterial
    else
      material_to_use = redMaterial

    sphere = new THREE.Mesh(new THREE.SphereGeometry(radius, segments, rings), material_to_use)
    sphere.position.set(@x, @y, -600)
    sphere
