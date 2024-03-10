const gulp = require('gulp')
const pug = require('gulp-pug')
const postcss = require('gulp-postcss')
const data = require('gulp-data')
const connect = require('gulp-connect')
const sitemap = require('gulp-sitemap')
const path = require('path')
const rename = require('gulp-rename')

function buildPcss (baseurl = '/2024/') {
  let dest_path = '.' + path.join('/static/', baseurl, '/assets/css')
  gulp
    .src('src/assets/**')
    .pipe(gulp.dest('.' + path.join('/static/', baseurl, '/assets/')))
  return gulp
    .src('src/pcss/*.pcss')
    .pipe(
      data(file => {
        console.log('[build] ' + file['history'])
      })
    )
    .pipe(postcss())
    .pipe(
      rename({
        extname: '.css'
      })
    )
    .pipe(gulp.dest(dest_path))
}

function buildPug (baseurl = '/2024/') {
  let build_time = new Date().getTime()
  let dest_path = '.' + path.join('/static/', baseurl)
  console.log(dest_path)
  return gulp
    .src('src/pug/**/index.pug')
    .pipe(
      data(file => {
        console.log('[build] ' + file['history'])
        const result = {
          index: require('src/data/index.json'),
          timestamp: build_time,
          base: baseurl
        }
        return result
      })
    )
    .pipe(pug())
    .pipe(gulp.dest(dest_path))
    .pipe(
      sitemap({
        siteUrl: 'https://summit.g0v.tw',
        images: true
      })
    )
    .pipe(gulp.dest(dest_path))
    .pipe(connect.reload())
}

gulp.task('build', async () => {
  await buildPug('/2024/')
  await buildPcss('/2024/')
})

gulp.task('server', function () {
  connect.server({
    port: 3000,
    livereload: true,
    host: '::',
    root: 'static'
  })
  buildPug()
  buildPcss()

  gulp.watch(
    ['src/**/*.pug', 'src/**/*.pcss', 'static/assets/js/*.js', 'src/data/*.json'],
    function (cb) {
      buildPug()
      buildPcss()
      cb()
    }
  )
})
