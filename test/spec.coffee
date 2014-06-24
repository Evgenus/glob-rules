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

describe "transform", ->
    it '/(a*)/(**) -> /b/$1/c/$2', ->
        transformer = glob_rules.transformer("/(a*)/(**)", "/b/$1/c/$2")
        expect(transformer("/atest/x1/yy/zzz")).to.equal("/b/atest/c/x1/yy/zzz")
        expect(transformer("/test/x1/yy/zzz")).to.equal("/test/x1/yy/zzz")

    it '/(*)a(*)/ -> /$2b$1/', ->
        transformer = glob_rules.transformer("/(*)a(*)/", "/$2b$1/")
        expect(transformer("/1a2/")).to.equal("/2b1/")
        expect(transformer("/111a22/")).to.equal("/22b111/")
        expect(transformer("/111b22/")).to.equal("/111b22/")
