'use strict';
angular.element(function () {
    angular.bootstrap(document.body, ['app']);
});
var App = angular.module('app', ['ngRoute', "ui.bootstrap", "ngAnimate","app.Templates"]).config(['$routeProvider', function ($routeProvider) {
        $routeProvider.
                when('/article', {templateUrl: 'article/article.html', controller: "articleController"}).
                when('/research', {templateUrl: 'research/research.html', controller: "researchController"}).
                when('/contact', {templateUrl: 'contact/contact.html', controller: "contactController"}).
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
    }]);
App.run(['$rootScope','$timeout','$interval','$location',function ($rootScope, $http, $timeout,$interval,$location) {
    $rootScope.tab='home';
    $rootScope.notifier = function (params, callback) {
        $rootScope.error = {}
        $rootScope.error.type = params.type || "message"; //there is also a confirm type which shows Yes and No buttons
        $rootScope.error.title = params.title || "error";
        $rootScope.error.choices = params.choices || [];
        $rootScope.error.notification = params.notification || "Oops! Something went wrong!";
        $("#error-module").modal('show');

        if (params.title == "timeout") {
            $timeout(function () {
                $user.logout();
            }, 2000)
        }

        $rootScope.errorResolution = function (status, value) {
            $("#error-module").modal('hide');
            callback(status, value);
        }
    }
    $rootScope.confirmationAlert = function (params) {
        $rootScope.confirmation = {}
        $rootScope.confirmation.title = params.title || "success";
        $rootScope.confirmation.notification = params.notification;
        $("#confirmation-module").modal('show');
        $timeout(function () {
            $("#confirmation-module").modal('hide');
        }, 2000);
    }
    $rootScope.clearInterval = function () {
        if (angular.isDefined($rootScope.countPromiseInterval)) {
            $interval.cancel($rootScope.countPromiseInterval);
        }
    }
    $rootScope.setTabs = function (tab) {
         $rootScope.tab=tab;
    }
}]);