'use strict';
angular.element(function () {
    angular.bootstrap(document.body, ['app']);
});
var App = angular.module('app', ['ngRoute', "ui.bootstrap", "ngAnimate","app.Templates"]).config(['$routeProvider', function ($routeProvider) {
        $routeProvider.
                when('/about', {templateUrl: 'routes.html', controller: "routeExample"}).
                when('/contact', {templateUrl: 'httpservices.html', controller: "httpServices"}).
                when('/home', {templateUrl: 'home/home.html', controller: "homeController"}).
                otherwise({
                    redirectTo: '/home'
                });
    }]);
App.config(['$httpProvider', '$locationProvider', '$sceDelegateProvider', '$qProvider', function ($httpProvider, $locationProvider, $sceDelegateProvider, $qProvider) {
        $sceDelegateProvider.resourceUrlWhitelist(['self', 'https://api-uat.bijouapp.com/**']);
        $locationProvider.hashPrefix('');
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
        $httpProvider.defaults.headers.common = {};
        $httpProvider.defaults.headers.post = {};
        $httpProvider.defaults.headers.put = {};
        $httpProvider.defaults.headers.patch = {};
        $httpProvider.defaults.headers.post['Content-Type'] = 'application/json';
        $httpProvider.defaults.headers.put['Content-Type'] = 'application/json';
        //$httpProvider.interceptors.push('HttpInterceptor');
        $qProvider.errorOnUnhandledRejections(false);
    }])