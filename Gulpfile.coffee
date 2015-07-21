gulp = require 'gulp'
cjsx = require 'gulp-cjsx'
plumber = require 'gulp-plumber'


gulp.task 'cjsx', ->
	gulp.src './src/*.cjsx'
		.pipe plumber()
		.pipe cjsx {bare: true}
		.pipe gulp.dest './public'

gulp.task 'watch', ->
	gulp.watch ['./src/*'], ['cjsx']

gulp.task 'default', ['cjsx', 'watch']
