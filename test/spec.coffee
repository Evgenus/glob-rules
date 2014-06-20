fs = require("fs")
mock = require("mock-fs")
yaml = require("js-yaml")
path = require("path")
expect = require("chai").expect
glob_rules = require("..")

beforeEach ->
    @old_cwd = process.cwd()
    process.chdir("/")

afterEach ->
    mock.restore()
    process.chdir(@old_cwd)

describe 'Mocha self test', ->
    it 'tests are working', ->
        expect(true).to.be.true.and.not.to.be.false;
