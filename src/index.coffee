start = /^\s*Course Outline\s*$/m
classTitle = /^(\d+\/\d+)\s+/m
required = /^\s*(Required)|(Required readings)|(Readings)[:]?\s*$/i
recommended = /^\s*Recommended[:]?\s*$/i
authorYearTitle = ///
	^ 					# start of line
	(.*?) 			# AUTHOR
	\s* 				# whitespace
	\((\d{4})\)	# YEAR
	\.?					# optional dot
	\s* 				# whitespace
	(.*) 				# TITLE
	\s* 				# whitespace
	$ 					# end of line
///i

module.exports = (input)->

	# find start token: Course Outline
	matches = start.exec(input)
	if not matches
		throw new Error('Could not find start token: "Course Outline"')
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
			classDate = matches[1]
		else if matches = authorYearTitle.exec(line)
			reading =
				author: matches[1]
				year: +matches[2]
				title: matches[3]
				classDate: classDate

			if recommended
				reading.recommended = true

			readings.push reading

	readings
