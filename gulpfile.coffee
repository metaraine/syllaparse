gulp =         require('gulp')
gutil =        require('gulp-util')
coffee =       require('gulp-coffee')
runSequence =  require('run-sequence')
jshint =       require('gulp-jshint')
clean =        require('gulp-rimraf')
###
rename =       require('gulp-rename')
uglify =       require('gulp-uglify')
concat =       require('gulp-concat')
imagemin =     require('gulp-imagemin')
cache =        require('gulp-cache')
filter =       require('gulp-filter')
###

config =
	scriptsSrc: 'src/**/*.coffee'
	scriptsDest: 'lib'

gulp.task 'scripts', ->
	gulp.src(config.scriptsSrc)
		.pipe(coffee().on('error', gutil.log))
		.pipe(gulp.dest(config.scriptsDest))

gulp.task 'clean', ->
	gulp.src(['./lib'], read: false)
	.pipe clean()

gulp.task 'default', (callback)->

	runSequence 'clean', [
		'scripts'
	], callback

	gulp.watch(config.scriptsSrc, ['scripts'])
