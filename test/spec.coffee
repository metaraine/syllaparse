assert = require('chai').assert
syllaparse = require '../lib/index.js'
fs = require 'fs'

readSample = (name)->
	fs.readFileSync __dirname + '/samples/' + name + '.txt', 'utf-8'

describe 'syllaparse', ->
	it 'should parse readings that follow "Course Outline" in the format "Author. (Year). Title".', ->
		sample = readSample 'author-year-title'
		console.log 'a', syllaparse(), sample
		assert.deepEqual(syllaparse(sample), [
			author: 'Yo'
			year: 'blah'
			title: 'Yo'
		])
