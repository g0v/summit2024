const gulp = require('gulp');
const pug = require('gulp-pug');
const sass = require('gulp-sass')(require('sass'));
const data = require('gulp-data');
const connect = require('gulp-connect');
const sitemap = require('gulp-sitemap');

function buildSass() {
  gulp.src('src/sass/**/*.sass')
    .pipe(data((file) => {
      console.log("[build] " + file['history']);
    }))
    .pipe(sass.sync().on('error', sass.logError))
    .pipe(gulp.dest('./static/assets/css'))
    .pipe(connect.reload());
}

function buildPug(baseurl="/") {
  let build_time = new Date().getTime();
  gulp.src('src/pug/**/index.pug')
    .pipe(data((file) => {
      console.log("[build] " + file['history']);
      const result = {
        index: require('./src/data/index.json'),
        timestamp: build_time
      };
      return result;
    }))
    .pipe(pug())
    .pipe(gulp.dest('./static/'))
    .pipe(sitemap({
      siteUrl: 'https://summit.g0v.tw',
      images: true
    }))
    .pipe(gulp.dest('./static/'))
    .pipe(connect.reload());
}

gulp.task('build', async() => {
  await buildSass();
  await buildPug();
});

gulp.task('server', function () {
  connect.server({
    port: 3000,
    livereload: true,
    host: '::',
    root: 'static'
  });
  buildSass();
  buildPug();

  gulp.watch(['src/**/*.sass'], function (cb) {
    buildSass();
    cb();
  });
  gulp.watch(['src/**/*.pug', 'src/**/*.sass', 'static/assets/js/*.js', 'data/*.json'], function (cb) {
    buildPug();
    cb();
  });
});