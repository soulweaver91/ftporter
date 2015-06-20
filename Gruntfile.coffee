# Use CoffeeScript everywhere
require 'coffee-script/register'

fs = require 'fs'
joinPath = require 'path.join'
_ = require 'lodash'

module.exports = (grunt) ->
    if !fs.existsSync 'settings.coffee'
        grunt.fail.fatal 'Settings file not found! Copy settings.coffee.template over to settings.coffee and fill in the details first.'

    settings = require './settings'

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-chokidar'


    configurations =
        chokidar:
            options:
                events: ['add']
        clean: {}
        upload: {}

    _.each settings.paths, (path, name) ->
        configurations.chokidar[name] =
            files: [joinPath path.from, '*']
            tasks: ["upload:#{name}", "clean:#{name}"]

        configurations.clean[name] = [joinPath path.from, '*']
        configurations.upload[name] =
            from: path.from
            to: path.to

    grunt.initConfig configurations

    grunt.loadTasks 'grunt'

    grunt.registerTask 'run', ['upload', 'clean', 'chokidar']

