module.exports = (grunt) ->
  pkg = grunt.file.readJSON './package.json'
  grunt.initConfig
    stylus:
      options:
        banner: [
          '/*',
          '  ' + pkg.name + ' v' + pkg.version,
          '  ' + pkg.description,
          '*/\n'
        ].join '\n'
      elastic:
        options:
          compress: true
        files:
          'build/elastic.css': 'stylus/elastic.styl'
      debug:
        options:
          compress: false
        files:
          'build/elastic-debug.css': 'stylus/elastic-debug.styl'
    postcss:
      options:
        map: false
        processors: [
           require('autoprefixer')({browsers: 'last 2 versions'})
        ]
      elastic:
        expand: true
        flatten: true
        src: 'build/elastic.css'
        dest: 'dist/'
      debug:
        expand: true
        flatten: true
        src: 'build/elastic-debug.css'
        dest: 'dist/'
    clean:
      build: ['build']
      reset: ['build', 'dist']
    watch:
      build:
        files: ['stylus/**/*.styl']
        tasks: [
          'stylus:debug'
          'stylus:elastic'
          'postcss:debug'
          'postcss:elastic'
        ]

  grunt.loadNpmTasks 'grunt-postcss'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', [
    'stylus:debug'
    'stylus:elastic'
    'postcss:debug'
    'postcss:elastic'
    'watch:build'
  ]