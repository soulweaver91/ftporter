joinPath = require 'path.join'

###
    Use joinPath to combine folder names instead of typing forward or backslashes manually, like so:
    joinPath 'root', 'folder', 'subfolder'
###

module.exports = {
    credentials:
        host: "ftp.example.localhost"
        user: "user"
        password: "pass"
    paths:
        # You can create multiple configurations here, just add another item like this queue here.
        queue:
            # Local path to watch for file changes
            from: 'queue'
            # Remote path to upload each file to. The same file name will be used; the old file will be overwritten
            # if it already exists.
            to: joinPath 'www-root', 'files'
}
