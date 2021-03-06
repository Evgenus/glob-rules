fs = require("fs")
path = require("path")
chai = require("chai")
expect = chai.expect
glob_rules = require("..")

chai.use (chai, util) ->
    chai.Assertion.addMethod 'match', (tester) ->
      this.assert(
            tester(this._obj),
            'expected #{this} to be matched',
            'expected #{this} to not be matched'
            )

    chai.Assertion.addMethod 'properties', (expectedPropertiesObj) ->
        for own key, func of expectedPropertiesObj
            func.call(new chai.Assertion(this._obj).property(key))

describe 'Mocha self test', ->
    it 'tests are working', ->
        expect(true).to.be.true.and.not.to.be.false

describe "test", ->
    it '**', ->
        tester = glob_rules.tester("**")
        expect("").to.match(tester)
        expect("/").to.match(tester)
        expect("a").to.match(tester)
        expect("/a").to.match(tester)
        expect("a/").to.match(tester)
        expect("a/b").to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").to.match(tester)
        expect("a/b.c/").to.match(tester)

    it '/**', ->
        tester = glob_rules.tester("/**")
        expect("").not.to.match(tester)
        expect("/").to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").not.to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").to.match(tester)

    it '/**/*', ->
        tester = glob_rules.tester("/**/b*")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").not.to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '**/*', ->
        tester = glob_rules.tester("/**/b*")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").not.to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '**/b*', ->
        tester = glob_rules.tester("**/b*")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '/**/b*', ->
        tester = glob_rules.tester("/**/b*")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").to.match(tester)
        expect("a/b.c").not.to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '**/*.c', ->
        tester = glob_rules.tester("**/*.c")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").not.to.match(tester)
        expect("a/b.c").to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '**/*.c*', ->
        tester = glob_rules.tester("**/*.c")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").not.to.match(tester)
        expect("a/b.c").to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").not.to.match(tester)
        expect("/a/b.c/").not.to.match(tester)

    it '**/*.c**', ->
        tester = glob_rules.tester("**/*.c**")
        expect("").not.to.match(tester)
        expect("/").not.to.match(tester)
        expect("a").not.to.match(tester)
        expect("/a").not.to.match(tester)
        expect("a/").not.to.match(tester)
        expect("a/b").not.to.match(tester)
        expect("/a/b").not.to.match(tester)
        expect("a/b.c").to.match(tester)
        expect("/a/b.c").to.match(tester)
        expect("a/b.c/").to.match(tester)
        expect("/a/b.c/").to.match(tester)
        expect("/a/b.cqqq/").to.match(tester)
        expect("/a/b.cqqq").to.match(tester)
        expect("/a/b.cqqq/zzz").to.match(tester)

    it '**/c*b/**', ->
        tester = glob_rules.tester("**/c*b/**")
        expect("a/b/cab").not.to.match(tester)
        expect("a/b/cab/b").to.match(tester)
        expect("a/b/caaaab/b").to.match(tester)
        expect("a/b/caa/b").not.to.match(tester)
        expect("a/b/caa/b/cab/b").to.match(tester)

    it "realistic example 1", ->
        tester = glob_rules.tester("./src/builder/**/*.coffee")
        expect("./src/builder/index.coffee").to.match(tester)

    it "realistic example 2", ->
        tester = glob_rules.tester("./**/app.js")
        expect("./app.js").to.match(tester)
        expect("./some/where/app.js").to.match(tester)

    it "realistic example 3", ->
        tester = glob_rules.tester("**/*.js")
        expect("/app.js").to.match(tester)
        expect("test/app.js").to.match(tester)
        expect("/some/where/app.js").to.match(tester)

    it "realistic example 4", ->
        tester = glob_rules.tester("/**/*.js")
        expect("/app.js").to.match(tester)
        expect("/test/app.js").to.match(tester)
        expect("/some/where/app.js").to.match(tester)
        expect("app.js").not.to.match(tester)
        expect("test/app.js").not.to.match(tester)
        expect("some/where/app.js").not.to.match(tester)

describe "transform", ->
    it '/(a*)/(**) -> /b/$1/c/$2', ->
        transformer = glob_rules.transformer("/(a*)/(**)", "/b/$1/c/$2")
        expect(transformer("/atest/x1/yy/zzz")).to.equal("/b/atest/c/x1/yy/zzz")
        expect(transformer("/test/x1/yy/zzz")).to.equal("/test/x1/yy/zzz")

    it '/(a*)/(**) -> /b/{1}/c/{2}', ->
        transformer = glob_rules.transformer("/(a*)/(**)", "/b/{1}/c/{2}")
        expect(transformer("/atest/x1/yy/zzz")).to.equal("/b/atest/c/x1/yy/zzz")
        expect(transformer("/test/x1/yy/zzz")).to.equal("/test/x1/yy/zzz")

    it '/(*)a(*)/ -> /$2b$1/', ->
        transformer = glob_rules.transformer("/(*)a(*)/", "/$2b$1/")
        expect(transformer("/1a2/")).to.equal("/2b1/")
        expect(transformer("/111a22/")).to.equal("/22b111/")
        expect(transformer("/111b22/")).to.equal("/111b22/")

    it '/(*)a(*)/ -> /{2}b{1}/', ->
        transformer = glob_rules.transformer("/(*)a(*)/", "/{2}b{1}/")
        expect(transformer("/1a2/")).to.equal("/2b1/")
        expect(transformer("/111a22/")).to.equal("/22b111/")
        expect(transformer("/111b22/")).to.equal("/111b22/")

    it '/a(*)/ -> /b{t}/', ->
        delegate = (name, match) ->
            if name == "t"
                return match[1] + match[1]
            return "t"
        transformer = glob_rules.transformer("/a(*)/", "/b{t}/", delegate)
        expect(transformer("/a2/")).to.equal("/b22/")
        expect(transformer("/a22/")).to.equal("/b2222/")
        expect(transformer("/111b22/")).to.equal("/111b22/")

describe "matcher", ->
    it '/(a*)/(**) -> /b/$1/c/$2', ->
        matcher = glob_rules.matcher("/(a*)/(**)")
        expect(matcher("/test/x1/yy/zzz")).to.be.null
        expect(matcher("/atest/x1/yy/zzz"))
            .to.be.an("Array")
            .with.length(3)
            .with.properties
                0: -> this.equal("/atest/x1/yy/zzz")
                1: -> this.equal("atest")
                2: -> this.equal("x1/yy/zzz")

    it '/(*)a(*)/ -> /$2b$1/', ->
        matcher = glob_rules.matcher("/(*)a(*)/")
        expect(matcher("/1a2/"))
            .to.be.an("Array")
            .with.length(3)
            .with.properties
                0: -> this.equal("/1a2/")
                1: -> this.equal("1")
                2: -> this.equal("2")

        expect(matcher("/111a22/"))
            .to.be.an("Array")
            .with.length(3)
            .with.properties
                0: -> this.equal("/111a22/")
                1: -> this.equal("111")
                2: -> this.equal("22")

        expect(matcher("/111b22/")).to.be.null
