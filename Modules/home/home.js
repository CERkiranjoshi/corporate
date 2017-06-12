App.controller('homeController', ['$scope', '$http', function($scope, $http) {
    $scope.myInterval = 2000;
    $scope.noWrapSlides = false;
    $scope.active = 0;
    var slides = $scope.slides = [];
    var currIndex = 0;
    $scope.init = function() {
        $scope.setTabs(1);
        $scope.myname = "kiran joshi";
        $scope.mytp = "select type";

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
            type:"image",
            image: 'img/2.jpg',
            text: ['Nice image', 'Awesome photograph', 'That is so cool', 'I love that'][slides.length % 4],
            id: 2
        });
        slides.push({
            type:"image",
            image: 'img/3.jpg',
            text: ['Nice image', 'Awesome photograph', 'That is so cool', 'I love that'][slides.length % 4],
            id: 3
        });
    };
    $scope.addData = function() {
        alert($scope.myname + " " + $scope.mytp);
    };
    $scope.setTabs = function(tab) {
        $scope.tab = tab;
    };
    $scope.init();
    $scope.renderSlide()
}]);
