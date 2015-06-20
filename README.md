FTPorter
========
FTPorter (portmanteau of *FTP teleporter*) is an automatic Grunt powered Node.js program that watches a directory for
new files and, whenever noticing any, uploads them to a server via FTP and deletes the local copies. It was designed to
automate saving screenshots from a local Windows computer to a remote web server; Windows' built in FTP support is
lacking and doesn't allow saving directly to defined FTP shares, so without this a manual upload step was necessary.
Naturally it can be used for other similar tasks as well.

Setup
-----
Make sure you have [Node.js](http://nodejs.org/) installed and properly set up. Clone this repository to a location of
your choice and then install the dependencies by running

```
npm install
```

If you don't yet have [Grunt](http://gruntjs.com/) installed globally, you should also do so now:

```
npm install -g grunt-cli
```

Copy the file `settings.template.coffee` to the name `settings.coffee` and fill in the settings, which currently consist
of the FTP server credentials and the paths to use on each end. Once that is done, start it up by typing

```
grunt run
```

It will keep moving the files from the local directory to the remote one until you shut it down (by pressing Ctrl-C,
as with most other command line tools).

License
-------
The source code is licensed under the [MIT license](http://opensource.org/licenses/MIT).
