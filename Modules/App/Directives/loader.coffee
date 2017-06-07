#
#		Displays a loading screen in place of loading content
#
#		Usage:
#
#		<div loadable="loading" loading-text="'Loading Curations...'">
#
#		Loading text needs to be wrapped in '' if a string, no need if bound to a scope string
#
class Loader extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<div class="page-loading-wait"><i class="pe-7s-science pe-spin"></i><h5 ng-bind="loadingText"></h5></div>'
			scope:
				loadingText: '=?'
			link: (scope, element, attrs) ->
				scope.loadingText = 'Loading...' unless angular.isDefined(scope.loadingText)
		}