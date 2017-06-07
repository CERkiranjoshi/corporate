/*
 This is processed when running 'grunt' or building the project.
 It handles the build tasks, compiling and moving / merging / optimizing files etc.
 */
module.exports = function(grunt) {
  var getSettings, get_active_js_libs, get_js_from;
  get_js_from = function(js_array, release) {
    var j, js_component_files, js_file, js_fileParts, len, results;
    if (release == null) {
      release = false;
    }
    results = [];
    if (js_array != null) {
      js_component_files = js_array.toString().split(',');
      for (j = 0, len = js_component_files.length; j < len; j++) {
        js_file = js_component_files[j];
        js_fileParts = js_file.split('|');
        if (js_fileParts.length === 2) {
          js_file = js_fileParts[release ? 1 : 0];
        }
        results.push(js_file);
      }
    }
    return results;
  };
  get_active_js_libs = function(release) {
    if (release == null) {
      release = false;
    }
    return get_js_from(grunt.file.readYAML('settings.yaml').js_component_includes, release);
  };
  getSettings = function(release) {
    var i, key, replacement, replacements, result, val, valParts;
    if (release == null) {
      release = false;
    }
    replacements = grunt.file.readYAML('settings.yaml').replacements;
    result = {};
    for (i in replacements) {
      replacement = replacements[i];
      for (key in replacement) {
        val = replacement[key];
        valParts = val.split('|');
        if (valParts.length === 2) {
          val = valParts[release ? 1 : 0];
        }
        if (hasOwnProperty.call(replacement, key)) {
          result[key] = val;
        }
      }
    }
    return result;
  };
  require('load-grunt-tasks')(grunt);
  grunt.registerTask('default', ['dev']);
  grunt.registerTask('devandrelease', ['clean:temp','jade:compile_modules', 'ngtemplates', 'copy:all','concat']);
  grunt.registerTask('dev', ['clean:dev', 'devandrelease', 'template:dev', 'copy:dev', 'replace:dev']);
  grunt.registerTask('release', ['clean:release', 'devandrelease', 'template:release', 'copy:release', 'uglify:all', 'requirejs:styles', 'copy:release_post_processed', 'copy:release_files', 'replace:release']);
  return grunt.config.init({
    PKG: grunt.file.readJSON('package.json'),
    SETTINGS: grunt.file.readYAML('settings.yaml'),
    BUILD_DIR_DEV: '_BUILD/dev/',
    BUILD_DIR_RELEASE: '_BUILD/release/',
    CLIENT_DIR_DEV: '_BUILD/dev/client/',
    CLIENT_DIR_RELEASE: '_BUILD/release/client/',
    MODULES_DIR: 'Modules/',
    TMP_DIR: '.temp/',
    ASSET_DIR: 'Assets/',
    COMPONENTS_DIR: 'bower_components/',
    ABBR: '<%= PKG.abbr%>',
    watch: {
      scripts: {
        files: ['<%= MODULES_DIR %>**/*.js', '<%= MODULES_DIR %>**/*.sass', '<%= MODULES_DIR %>**/*.html'],
        tasks: 'dev'
      }
    },
    clean: {
      temp: '<%= TMP_DIR %>',
      dev: '<%= BUILD_DIR_DEV %>',
      release: '<%= BUILD_DIR_RELEASE %>'
    },
    bower: {
      install: {
        options: {
          copy: false
        }
      },
      uninstall: {
        options: {
          cleanBowerDir: true,
          copy: false,
          install: false
        }
      }
    },
    connect: {
      server: {
        options: {
          port: 8000,
          base: '_BUILD/dev/client',
          keepalive: true,
          open: true
        }
      }
    },
    stylus: {
      compile_modules: {
        options: {
          'include css': true
        },
        files: {
          '<%= TMP_DIR %>client/css/style.css': ['<%= COMPONENTS_DIR %>angular-loading-bar/src/loading-bar.css', '<%= COMPONENTS_DIR %>components-font-awesome/css/font-awesome.css', '<%= MODULES_DIR %>**/*.styl', '!<%= MODULES_DIR %>**/*.inc.styl']
        }
      }
    },
    jade: {
      compile_modules: {
        options: {
          pretty: true,
          data: {
            debug: false
          }
        },
        files: [{
            '<%= TMP_DIR %>client/index.html': '<%= MODULES_DIR %>App/Index/index.jade'
          }
        ]
      }
    },
    ngtemplates: {
      app: {
        cwd: '<%= MODULES_DIR %>',
        src: '**/*.html',
        dest: '<%= TMP_DIR %>client/js/app.templates.js',
        options: {
          htmlmin: {
            collapseBooleanAttributes: true,
            collapseWhitespace: true,
            removeAttributeQuotes: true,
            removeComments: true,
            removeEmptyAttributes: true,
            removeRedundantAttributes: true,
            removeScriptTypeAttributes: true,
            removeStyleLinkTypeAttributes: true
          },
          bootstrap: function(module, script) {
            return "angular.module('app.Templates', []).run([ '$templateCache', function($templateCache) { " + script + " }]);";
          }
        }
      }
    },
    copy: {
      all: {
        files: [
          {
            expand: true,
            flatten: true,
            cwd: '<%= COMPONENTS_DIR %>',
            src: get_active_js_libs(),
            dest: '<%= TMP_DIR %>client/js/libs/'
          }
        ]
      },
      dev: {
        files: [
          {
            '<%= CLIENT_DIR_DEV %>css/animate.css': '<%= COMPONENTS_DIR %>animate.css/animate.css'
          }, {
            expand: true,
            cwd: '<%= ASSET_DIR %>',
            src: ['**'],
            dest: '<%= CLIENT_DIR_DEV %>'
          }, {
            expand: true,
            cwd: '<%= COMPONENTS_DIR %>components-font-awesome/fonts/',
            src: ['**'],
            dest: '<%= CLIENT_DIR_DEV %>fonts/'
          }, {
            expand: true,
            cwd: '<%= TMP_DIR %>client/',
            src: ['**'],
            dest: '<%= CLIENT_DIR_DEV %>'
          }
        ]
      },
      release: {
        files: [
          {
            '<%= CLIENT_DIR_RELEASE %>index.html': '<%= TMP_DIR %>client/index.html',
            '<%= TMP_DIR %>client/css/loading-bar.css': '<%= COMPONENTS_DIR %>angular-loading-bar/build/loading-bar.css'
          }, {
            expand: true,
            cwd: '<%= COMPONENTS_DIR %>components-font-awesome/fonts/',
            src: ['**'],
            dest: '<%= CLIENT_DIR_RELEASE %>fonts/'
          }, {
            expand: true,
            cwd: '<%= ASSET_DIR %>',
            src: ['**'],
            dest: '<%= CLIENT_DIR_RELEASE %>'
          }
        ]
      },
      release_post_processed: {
        files: [
          {
            expand: true,
            cwd: '<%= TMP_DIR %>client/js/',
            src: '**/*.js',
            dest: '<%= CLIENT_DIR_RELEASE %>js/'
          }
        ]
      },
      release_files: {
        files: [
          {
            '<%= CLIENT_DIR_RELEASE %>css/style.min.css': '<%= TMP_DIR %>client/css/style.min.css'
          }
        ]
      }
    },
    replace: {
      dev: {
        options: {
          patterns: [
            {
              json: getSettings(false)
            }
          ]
        },
        files: [
          {
            expand: true,
            cwd: '<%= BUILD_DIR_DEV %>',
            src: ['**'],
            dest: '<%= BUILD_DIR_DEV %>'
          }
        ]
      },
      release: {
        options: {
          patterns: [
            {
              json: getSettings(true)
            }
          ]
        },
        files: [
          {
            expand: true,
            cwd: '<%= BUILD_DIR_RELEASE %>',
            src: ['**'],
            dest: '<%= BUILD_DIR_RELEASE %>'
          }
        ]
      }
    },
    template: {
      dev: {
        files: {
          './.temp/client/index.html': './.temp/client/index.html'
        }
      },
      release: {
        files: '<%= template.dev.files %>',
        environment: 'prod'
      }
    },
    concat: {
        basic_and_extras: {
            files: {
                '<%= TMP_DIR %>client/js/modules.js': '<%= MODULES_DIR %>**/*.js',
                '<%= TMP_DIR %>client/js/bundle.js': ['<%= TMP_DIR %>client/js/libs/jquery.js','<%= TMP_DIR %>client/js/libs/jquery-ui.js','<%= TMP_DIR %>client/js/libs/angular.js','<%= TMP_DIR %>client/js/libs/angular-route.js','<%= TMP_DIR %>client/js/libs/angular.js','<%= TMP_DIR %>client/js/libs/angular-animate.js','<%= TMP_DIR %>client/js/libs/angular-base64.js','<%= TMP_DIR %>client/js/libs/angular-cookies.js','<%= TMP_DIR %>client/js/libs/angular-local-storage.js','<%= TMP_DIR %>client/js/libs/ui-bootstrap-tpls.js','<%= TMP_DIR %>client/js/libs/angular-touch.js','<%= TMP_DIR %>client/js/libs/lodash.js','<%= TMP_DIR %>client/js/app.templates.js']
              }
        }
      },
    uglify: {
      options: {
        mangle: {
          except: ['main']
        }
      },
      all: {
        files: {
          '<%= TMP_DIR %>client/js/scripts.min.js': ['<%= TMP_DIR %>client/js/libs/lodash.js', '<%= TMP_DIR %>client/js/libs/jquery.js', '<%= TMP_DIR %>client/js/libs/jquery-ui.js', '<%= TMP_DIR %>client/js/libs/jquery.flip.js', '<%= TMP_DIR %>client/js/libs/hammer.js', '<%= TMP_DIR %>client/js/libs/angular.js', '<%= TMP_DIR %>client/js/libs/angular-ui-router.js', '<%= TMP_DIR %>client/js/libs/angular-animate.js', '<%= TMP_DIR %>client/js/libs/angular-touch.js', '<%= TMP_DIR %>client/js/libs/angular-cookies.js', '<%= TMP_DIR %>client/js/libs/angular-hammer.js', '<%= TMP_DIR %>client/js/libs/angular-base64.js', '<%= TMP_DIR %>client/js/libs/angular-local-storage.js', '<%= TMP_DIR %>client/js/libs/ng-file-upload-shim.js', '<%= TMP_DIR %>client/js/libs/ng-file-upload.js', '<%= TMP_DIR %>client/js/libs/dirPagination.js', '<%= TMP_DIR %>client/js/libs/ui-bootstrap-tpls.js', '<%= TMP_DIR %>client/js/libs/xeditable.js', '<%= TMP_DIR %>client/js/libs/slider.js', '<%= TMP_DIR %>client/js/*.js', '!<%= TMP_DIR %>client/js/main.js']
        }
      }
    }
  });
};