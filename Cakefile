fs = require("fs")
coffee = require("coffee-script")

task "build", "compile all coffeescript files to javascript", ->
    source = fs.readFileSync("index.coffee", encoding: "utf8")
    compiled = coffee.compile(source, bare: true)
    fs.writeFileSync("index.js", compiled)

task "sbuild", "build routine for sublime", ->
    invoke 'build'
