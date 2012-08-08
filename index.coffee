require("coffee-script")
stitch  = require("stitch")
express = require("express")
stylus  = require("stylus")
argv    = process.argv.slice(2)

_package = stitch.createPackage(
  # Specify the paths you want Stitch to automatically bundle up
  paths: [ __dirname + "/app" ]

  # Specify your base libraries
  dependencies: [
    __dirname + '/lib/jquery.js',
    __dirname + '/lib/three.js',
    __dirname + '/lib/request_animation_frame_polyfill.js',
    __dirname + '/lib/helvetiker_bold.typeface.js',
    __dirname + '/lib/helvetiker_regular.typeface.js'
  ]
)
app = express()

app.configure ->
  app.set "views", __dirname + "/views"
  app.use app.router
  app.use stylus.middleware(__dirname + "/public")
  app.use express.static(__dirname + "/public")
  app.get "/application.js", _package.createServer()

port = argv[0] or process.env.PORT or 9294
console.log "Starting server on port: #{port}"
app.listen port
