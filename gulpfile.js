const gulp = require('gulp');
const pug = require('gulp-pug');
const sass = require('gulp-sass')(require('sass'));
const data = require('gulp-data');
const connect = require('gulp-connect');
const sitemap = require('gulp-sitemap');
const path = require('path')

function buildSass(baseurl="/") {
  let dest_path = '.' + path.join('/static/', baseurl, '/assets/css')
  gulp.src('src/sass/**/*.sass')
    .pipe(data((file) => {
      console.log("[build] " + file['history']);
    }))
    .pipe(sass.sync().on('error', sass.logError))
    .pipe(gulp.dest(dest_path))
    .pipe(connect.reload());

  gulp.src('./assets/**')
    .pipe(gulp.dest('.' + path.join('/static/', baseurl, '/assets/')))
    .pipe(connect.reload());
}

function buildPug(baseurl="/") {
  let build_time = new Date().getTime();
  let dest_path = '.' + path.join('/static/', baseurl)
  console.log(dest_path)
  gulp.src('src/pug/**/index.pug')
    .pipe(data((file) => {
      console.log("[build] " + file['history']);
      const result = {
        index: require('./src/data/index.json'),
        timestamp: build_time,
        base: baseurl
      };
      return result;
    }))
    .pipe(pug())
    .pipe(gulp.dest(dest_path))
    .pipe(sitemap({
      siteUrl: 'https://summit.g0v.tw',
      images: true
    }))
    .pipe(gulp.dest(dest_path))
    .pipe(connect.reload());
}

gulp.task('build', async() => {
  await buildSass('/2024/');
  await buildPug('/2024/');
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