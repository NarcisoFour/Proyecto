const browserSync = require('browser-sync').create();
const gulp = require('gulp');
const notify = require('gulp-notify');
const plumber = require('gulp-plumber');
const prefix = require('gulp-autoprefixer');
const sass = require('gulp-sass');

var onError = function (err) {
  notify.onError({
    title: "Gulp",
    subtitle: "Failure!",
    message: "Error: <%= error.message %>",
    sound: "Basso"
  })(err);
  this.emit('end');
};

var sassOptions = {
  outputStyle: 'expanded'
};

var prefixerOptions = {
  browsers: ['last 2 versions']
};

gulp.task('copy', () => {
  return gulp.src([
    'node_modules/animate.css/animate.min.css'
])
    .pipe(gulp.dest('src/css'));
});

gulp.task('bootstrap', () => {
  return gulp.src('node_modules/bootstrap/scss/bootstrap.scss')
  .pipe(sass({outputStyle: 'compressed'}))
  .pipe(gulp.dest('src/css'))
  .pipe(browserSync.stream());
});

gulp.task('sass', () => {
  return gulp.src('src/scss/*.scss')
    .pipe(plumber({ errorHandler: onError }))
    .pipe(sass(sassOptions))
    .pipe(prefix(prefixerOptions))
    .pipe(gulp.dest('src/css'))
    .pipe(browserSync.stream());
})

gulp.task('js', () => {
  return gulp.src([
    'node_modules/bootstrap/dist/js/bootstrap.min.js',
    'node_modules/jquery/dist/jquery.min.js',
    'node_modules/popper.js/dist/umd/popper.min.js',
    'node_modules/feather-icons/dist/feather.min.js',
    'node_modules/faker/lib/fake.js'
  ])
  .pipe(gulp.dest('src/js'))
  .pipe(browserSync.stream());
});

gulp.task('serve', ['bootstrap', 'sass'], () => {
  browserSync.init({
    server: './src'
  });

  gulp.watch(['node_modules/bootstrap/scss/bootstrap.min.scss'], ['bootstrap']);
  gulp.watch(['src/scss/*.scss'], ['sass']);
  gulp.watch('src/*.html').on('change', browserSync.reload);

});

gulp.task('font-awesome', () => {
  return gulp.src('node_modules/font-awesome/css/font-awesome.min.css')
  .pipe(gulp.dest('src/css'));
})

gulp.task('fonts', () => {
  return gulp.src('node_modules/font-awesome/fonts/*')
    .pipe(gulp.dest('src/fonts'));
});

gulp.task('default', ['copy', 'js', 'serve', 'font-awesome', 'fonts'])
