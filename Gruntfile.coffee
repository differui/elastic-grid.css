module.exports = (grunt) ->
  pkg = grunt.file.readJSON './package.json'
  grunt.initConfig
    stylus:
      build:
        options:
          banner: [
            '/*',
            '  ' + pkg.name + ' v' + pkg.version,
            '  ' + pkg.description,
            '*/\n'
          ].join '\n'
          compress: true
        files:
          'build/elastic.css': 'stylus/elastic.styl'
    autoprefixer:
      options:
        browsers: ['last 2000 versions']
        cascade: true
        diff: true
        map: true
      build:
        expand: true
        flatten: true
        src: 'build/elastic.css'
        dest: 'dist/'
    clean:
      build: ['build']
      reset: ['build', 'dist']
    watch:
      build:
        files: ['stylus/**/*.styl']
        tasks: ['stylus:build', 'autoprefixer:build']

  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['stylus:build', 'autoprefixer:build', 'watch:build']