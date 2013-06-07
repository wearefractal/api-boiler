grunt = require 'grunt'

explode = (cwd, files) ->
  files = [files] unless Array.isArray files
  return ("#{cwd}/#{f}" for f in files)

gruntConfig =
  pkg: grunt.file.readJSON('package.json')

  reload: {}

  clean:
    public: ["public"]

  jaded:
    app:
      expand: true
      cwd: "client/templates"
      src: [ "*.jade" ]
      dest:  "public/templates"
      options:
        amd: true
        development: false
        rivets: false

  coffee:
    options:
      bare: true
    app:
      expand: true
      cwd: "client/js/"
      src: [ "*.coffee", "*.js" ]
      dest:  "public/js/"
      ext: ".js"

    views:
      expand: true
      cwd: "client/js/views"
      src: [ "*.coffee", "*.js" ]
      dest:  "public/js/views"
      ext: ".js"

    layouts:
      expand: true
      cwd: "client/js/layouts"
      src: [ "*.coffee", "*.js" ]
      dest:  "public/js/layouts"
      ext: ".js"

    models:
      expand: true
      cwd: "client/js/models"
      src: [ "*.coffee", "*.js" ]
      dest:  "public/js/models"
      ext: ".js"

  copy:
    vendor:
      expand: true
      src: ["**/*.js"]
      dest: "public/js/vendor/"
      cwd: "client/js/vendor"

    images:
      expand: true
      src: ["**"]
      dest: "public/img"
      cwd: "client/img"

    css:
      expand: true
      src: ["**"]
      dest: "public/css"
      cwd: "client/css"

    static:
      src: "client/index.html"
      dest: "public/index.html"

gruntConfig.watch = {}
toWatch = ["coffee","jaded","copy"]
for cat in toWatch
  for set, files of gruntConfig[cat]
    continue if set is 'options'
    if files.cwd
      fls = explode files.cwd, files.src
    else
      fls = files.src
    gruntConfig.watch["#{set}-#{cat}"] =
      files: fls
      tasks: ["#{cat}:#{set}","reload"]

module.exports = (grunt) ->
  ## init config 
  grunt.initConfig gruntConfig

  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-jaded"
  grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-contrib-watch"

  ## default 
  grunt.registerTask "default", ["clean",
    "copy","coffee",
    "jaded","start",
    "reload","watch"]

  ## start
  grunt.registerTask "start", "start up servers", ->
    grunt.log.writeln "Starting server..."
    server = require "./server/start"