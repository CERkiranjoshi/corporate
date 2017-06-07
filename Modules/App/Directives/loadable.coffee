#
#		Displays a loading screen in place of loading content
#
#		Usage:
#
#		<div loadable="loading" loading-text="'Loading Curations...'">
#
#		Loading text needs to be wrapped in '' if a string, no need if bound to a scope string
#
class Loadable extends Directive
	constructor: ->
		return {
			restrict: 'A'
			transclude: true
			template: '<div class="page-loading-wait" ng-show="loadable"><i class="pe-7s-science pe-spin"></i><h5 ng-bind="loadingText"></h5></div><div class="loader_content" ng-transclude ng-show="!loadable" ng-cloak></div>'
			scope:
				loadable: '='
				loadingText: '=?'
			link: (scope, element, attrs) ->
				scope.loadingText = 'Loading...' unless angular.isDefined(scope.loadingText)
		}