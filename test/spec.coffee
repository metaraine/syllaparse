assert = require('chai').assert
syllaparse = require '../lib/index.js'
fs = require 'fs'

readSample = (name)->
	fs.readFileSync __dirname + '/samples/' + name + '.txt', 'utf-8'

describe 'syllaparse', ->
	it 'should parse readings that follow "Course Outline" in the format "Author. (Year). Title".', ->
		sample = readSample 'author-year-title'
		assert.deepEqual(syllaparse(sample), [
			classDate: '1/19'
			author: 'Maddux, J. E., Gosselin, J. T., & Winstead, B. A.'
			year: 2012
			title: 'Conceptions of Psychopathology: A social constructional perspective. In J. E Maddux, & B. A. Winstead (Eds.), Psychopathology: Foundations for a contemporary understanding (pp. 3-22). NY, NY: Routledge.'
		,
			classDate: '1/19'
			author: 'American Psychiatric Association.'
			year: 2013
			title: 'Introduction. In Diagnostic and statistical manual of mental 	disorders (5th ed.)(pp. 5-17). Arlington, VA: American Psychiatric Publishing.'
		])
