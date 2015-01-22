cint = require 'cint'

re =
	blankline: /^\s*$/
	start: /^\s*Course Outline\s*$/m
	classTitle: /^(\d+\/\d+).*/m
	required: /^\s*(?:Required)|(?:Required readings)|(?:Readings)[:]?\s*$/i
	recommended: /^\s*Recommended[:]?\s*$/i
	# regex101.com/r/bU5uP0/1
	authorYearTitle: /^(.*?(?:\s\w\.|(?=\.)))[\s.]*\((\d{4})\)\.?\s*(.*?)\s*$/i

module.exports = (input)->

	# find start token: Course Outline
	matches = re.start.exec(input)
	if not matches
		throw new Error('Could not find start token: "Course Outline"')
	input = input.slice(matches.index + matches[0].length)

	input
		.replace(re.blankline, '')
		.replace(re.required, '')

	# readingsList and procedural flags
	readings = []
	recommended = false
	classDate = null

	# begin reading line by line
	for line in input.split('\n')

		# console.log 'line', line

		# check for class title line
		if matches = re.classTitle.exec(line)
			classDate = matches[1]
			recommended = false # reset recommended
		# check for recommended line
		else if re.recommended.exec(line)
			recommended = true
		# check for reading line
		else if matches = re.authorYearTitle.exec(line)
			reading =
				author: matches[1]
				year: +matches[2]
				title: matches[3]
				classDate: classDate

			if recommended
				reading.recommended = true

			readings.push reading
		# check for multiline with tab
		else if readings.length and line.indexOf('\t') is 0
			cint.index(readings, -1).title += line.trim()

	readings
