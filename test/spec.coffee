assert = require 'insist'
syllaparse = require '../index.js'
fs = require 'fs'

sample = fs.readFileSync __dirname + '/Lineages Syllabus.txt'

describe 'something', ->
  it 'should do something', ->
    assert true, false
