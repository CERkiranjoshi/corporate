Corporate WEB
==============================
Developed using Angular JS, Grunt , Sass


## Requirements
* Node  - https://nodejs.org/en/
* Grunt - `sudo npm install -g grunt-cli`
* Bower - `sudo npm install -g bower`
* insatll https://rubyinstaller.org/
* install sass `gem install sass`

## Install
`npm install && bower install` Installs the projects dependencies

## Usefull grunt tasks
* Go in your project dir & execute follow command
* `grunt` Runs a dev build
* `grunt dev` Create and deploy a dev build
* `grunt release` Create and deploy a release build
* `grunt watch` Watches for changes in the Modu8les folder and rebuilds dev branch as needed.
* `grunt connect` Runs the app on a local server

## dir to find code that needs to be go on live with developemnet code
* when you run grunt or grunt dev command your code is genrated in `_BUILD\dev\client`
* and if you want to deploy that code, then just copy it from `_BUILD\dev\client` directory & put on your server `public_html` folder

## dir to find code that needs to be go on live with production code
* when you run grunt release command your code is genrated in `_BUILD\release\client`
* and if you want to deploy that code, then just copy it from `_BUILD\release\client` directory & put on your server `public_html` folder
* Note : in production all css & js file is minified.

## Usefull Notes
* you can change color of all web by going into `Modules\App\Style\app.scss` & change $themeColor value after that you need to run grunt task based on dev or prod
