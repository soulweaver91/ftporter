ftp = require 'ftp'
async = require 'async'
fs = require 'fs'
joinPath = require 'path.join'
moment = require 'moment'

settings = require '../settings'

module.exports = (grunt) ->
    grunt.registerMultiTask 'upload', 'Uploads queued files', ->
        success = @async()
        client = new ftp()

        target = this.target
        paths = this.data

        files = fs.readdirSync paths.from

        noErrors = true

        log = (message) ->
            now = moment().format('YYYY-MM-DD HH:mm:ss')
            console.log "[#{now} FTPorter:#{target}] #{message}"

        uploadOne = (client, files) ->
            if !files? || files.length == 0
                log "No more files to upload, disconnecting."
                client.end()
            else
                next = files.pop()

                fromPath = joinPath paths.from, next
                toPath = joinPath paths.to, next

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
