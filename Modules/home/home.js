App.controller('homeController', ['$scope', '$http', function ($scope, $http) {
        $scope.init = function () {
            $scope.setTabs(1);
            $scope.myname = "kiran joshi";
            $scope.mytp = "select type";
        };
        $scope.addData = function () {
            alert($scope.myname + " " + $scope.mytp);
        };
        $scope.setTabs = function (tab) {
            $scope.tab = tab;
        };

        $scope.init();
    }]);