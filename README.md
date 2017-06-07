BIJOU - The Edit : Admin
==============================
Developed using Angular JS, RequireJS, Grunt


## Requirements
* Node  - https://nodejs.org/en/
* Grunt - `sudo npm install -g grunt-cli`
* Bower - `sudo npm install -g bower`

## Install
`npm install && bower install` Installs the projects dependencies

## Usefull grunt tasks
* `grunt` Runs a dev build
* `grunt dev` Create and deploy a dev build
* `grunt release` Create and deploy a release build
* `grunt watch` Watches for changes in the Modu8les folder and rebuilds dev branch as needed.
* `grunt connect` Runs the app on a local server

## Development
Create a directory under the Modules folder for any logical components. Create all files effecting that component in that directory. The build process will use ngClassify, to turn coffee script classes into Angular controllers and services. Jade templates are compiled and cached as js. styl files are merged to generate the CSS.

* `products.coffee`	- Angular Controller
* `products.jade`	- HTML templates
* `products.service.coffee`	- Angular Service
* `products.styl` - CSS Styling
