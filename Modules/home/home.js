App.controller('homeController', ['$scope', '$http','$rootScope','$location', function($scope, $http,$rootScope,$location) {
    $scope.myInterval = 2000;
    $scope.noWrapSlides = false;
    $scope.active = 0;
    var slides = $scope.slides = [];
    var currIndex = 0;
    $scope.init = function() {
        $scope.articleList=[{
            type:"article",
            name: "Corporate article 1",
            image:"img/1.jpg",
            id: 1
        },{
            type:"article",
            name: "Corporate article 2",
            image:"img/2.jpg",
            id: 2
        },{
            type:"article",
            name: "Corporate article 3",
            image:"img/3.jpg",
            id: 3
        },{
            type:"article",
            name: "Corporate article 4",
            image:"img/4.jpg",
            id: 4
        }]

    };
    $scope.renderSlide = function() {
        slides.push({
            type:"template",
            template: 'download',
            text: ['Nice image', 'Awesome photograph', 'That is so cool', 'I love that'][slides.length % 4],
            id: 0
        });
        slides.push({
            type:"template",
            template: 'sub',
            text: ['Nice image', 'Awesome photograph', 'That is so cool', 'I love that'][slides.length % 4],
            id: 1
        });
        slides.push({
            type:"template",
            template: 'browser',
            text: ['Nice image', 'Awesome photograph', 'That is so cool', 'I love that'][slides.length % 4],
            id: 2
        });
    };
    $scope.openArticle=function(article){
        $rootScope.tab='article';
        window.location.href = '#/article';
    }
    $scope.init();
    $scope.renderSlide()
}]);
