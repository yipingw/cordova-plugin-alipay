var gulp = require('gulp');
var runSequence = require('run-sequence');
var conventionalChangelog = require('conventional-changelog');
var conventionalGithubReleaser = require('conventional-github-releaser');
var bump = require('gulp-bump');
var gutil = require('gulp-util');
var git = require('gulp-git');
var fs = require('fs');

gulp.task('default', ['changelog']);

gulp.task('changelog', function () {
	return gulp.src('CHANGELOG.md', {buffer: false})
							.pipe(conventionalChangelog({preset: 'angular'}))
							.pipe(gulp.dest('./'));
});

gulp.task('github-release', function (done) {
	conventionalGithubReleaser({type:"oauth", token:'5e70b007d1905f146fc1184a5786a30d7f0358a3'}, {
		preset: 'angular'
	}, done);
});

gulp.task('bump-version', function () {
	return gulp.src(['./bower.json', './package.json'])
	.pipe(bump({type: 'patch'}).on('error', gutil.log))
	.pipe(gulp.dest('./'));
});

gulp.task('commit-changes', function () {
	return gulp.src('.')
	.pipe(git.add())
	.pipe(git.commit('[Prerelease] Bump version number'));
});

gulp.task('push-changes', function (cb) {
	git.push('origin', 'master', cb);
});

