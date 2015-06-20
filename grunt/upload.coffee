ftp = require 'ftp'
async = require 'async'
fs = require 'fs'
joinPath = require 'path.join'

settings = require '../settings'

module.exports = (grunt) ->
    grunt.registerTask 'upload', 'Uploads queued files', ->
        success = @async()
        client = new ftp()

        files = fs.readdirSync settings.paths.from

        noErrors = true

        log = (message) ->
            console.log "[FTPorter] #{message}"

        uploadOne = (client, files) ->
            if !files? || files.length == 0
                log "No more files to upload, disconnecting."
                client.end()
            else
                next = files.pop()

                fromPath = joinPath settings.paths.from, next
                toPath = joinPath settings.paths.to, next

                log "Uploading local:#{fromPath} -> remote:#{toPath}..."

                client.put fromPath, toPath, (err) ->
                    if err?
                        log "Error: #{err}"
                        noErrors = false
                        client.end()
                    else
                        uploadOne client, files

        if files.length > 0
            log "#{files.length} file#{if files.length isnt 1 then 's' else ''} in queue."

            client.on 'ready', ->
                uploadOne client, files

            client.on 'error', (err) ->
                log err
                noErrors = false

            client.on 'end', ->
                log 'Disconnected.'
                success noErrors

            client.connect settings.credentials
        else
            success true
