# Use CoffeeScript everywhere
require 'coffee-script/register'

fs = require 'fs'
joinPath = require 'path.join'

module.exports = (grunt) ->
    if !fs.existsSync 'settings.coffee'
        grunt.fail.fatal 'Settings file not found! Copy settings.coffee.template over to settings.coffee and fill in the details first.'

    settings = require './settings'

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-chokidar'

    grunt.initConfig {
        chokidar:
            options:
                events: ['add']
            queue:
                files: [joinPath settings.paths.from, '*']
                tasks: ['upload', 'clean:queue']
        clean:
            queue: [joinPath settings.paths.from, '*']
    }

    grunt.loadTasks 'grunt'

    grunt.registerTask 'run', ['upload', 'clean', 'chokidar']

