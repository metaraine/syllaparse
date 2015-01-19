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

	it 'should mark recommended readings', ->
		sample = readSample 'recommended'
		assert.deepEqual(syllaparse(sample), [
			classDate: '1/19'
			author: 'Maddux, J. E., Gosselin, J. T., & Winstead, B. A.'
			year: 2012
			title: 'Conceptions of Psychopathology: A social constructional perspective.'
		,
			classDate: '1/19'
			author: 'American Psychiatric Association.'
			year: 2013
			title: 'Introduction.'
		,
			classDate: '1/19'
			author: 'Freud, S.'
			year: 2002
			title: 'Advice to doctors on psychoanalytic treatment.'
			recommended: true
		,
			classDate: '1/19'
			author: 'Germer, C.'
			year: 2005
			title: 'Mindfulness: What is it? What does it matter?'
			recommended: true
		])

	it 'should parse readings that extend onto a second line that starts with a tab', ->
		sample = readSample 'multiline-tab'
		assert.deepEqual(syllaparse(sample), [
			classDate: '1/19'
			author: 'Freud, S.'
			year: 2002
			title: 'Advice to doctors on psychoanalytic treatment.'
		])
