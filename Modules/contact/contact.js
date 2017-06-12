App.controller('contactController', ['$scope', '$http','$rootScope', function($scope, $http,$rootScope) {
    $scope.init = function() {
        $rootScope.tab='contact';
    };
    $scope.init();
}]);
