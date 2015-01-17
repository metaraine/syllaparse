start = /^\s*Course Outline\s*$/m
classTitle = /^(\d+\/\d+)\s+/m
required = /^\s*(Required)|(Required readings)|(Readings)[:]?\s*$/i
recommended = /^\s*Recommended[:]?\s*$/i
authorYearTitle = /(.*)\s+\((\d\d\d\d)\)[.]?\s*(.*)/i

module.exports = (input)->

	# find start token: Course Outline
	matches = start.exec(input)
	if not matches
		throw new Error('Could not find start token of "Course Outline".')
	input = input.slice(matches.index + matches[0].length)

	input.replace(required, '')

	# readingsList and procedural flags
	readings = []
	recommended = false
	classDate = null

	# begin reading line by line
	for line in input.split(/\s*\n\s*/)

		# check for class title line
		if matches = classTitle.exec(line)
			classDate = matches[1].trim()
		else if matches = authorYearTitle.exec(line)
			reading =
				author: matches[1].trim()
				year: +matches[2].trim()
				title: matches[3].trim()
				classDate: classDate

			if recommended
				reading.recommended = true

			readings.push reading

	readings
