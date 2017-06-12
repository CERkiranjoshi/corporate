App.controller('researchController', ['$scope', '$http','$rootScope', function($scope, $http , $rootScope) {
    
    $scope.init = function() {
        $rootScope.tab='research';
    };
    $scope.init();
}]);
