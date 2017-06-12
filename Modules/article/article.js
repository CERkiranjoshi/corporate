App.controller('articleController', ['$scope', '$http','$rootScope', function($scope, $http,$rootScope) {
    $scope.myInterval = 2000;
    $scope.noWrapSlides = false;
    $scope.active = 0;
    var slides = $scope.slides = [];
    var currIndex = 0;
    $rootScope.tab='article';
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
    $scope.init();
}]);
