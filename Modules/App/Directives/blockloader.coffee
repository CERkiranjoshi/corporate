
#
#		Displays a loading spin  in place of loading graph or block
#
#		Usage:
#
#		blockloader(loader-status="loader.totalDownloads", blockspin-colors="[colors[1],colors[2]]",block-class="'dashboard-graph-spin-medium'")
#
#		loaderStaus = based on which status you need to manage blocker.blockspin-colors : Array Of Colors you need to change in Spinner
#		block-class = font & line height of Div you have added in that class.. that class name you need to pass
class Blockloader extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<div class="block-loader" ng-if="loaderStatus"><i class="pe-7s-config pe-spin pe-lg dashboard-graph-spin {{blockClass}}"></i></div>'
			scope:
				loaderStatus: '='
				blockspinColors: '='
				blockClass: '='
				currentFilter:'='
			link: (scope, element, attrs) ->
				counter = 0
				scope.$watchCollection 'currentFilter.name', (newVal, oldVal) =>
					scope.bgchange=()->
						counter = (counter + 1) % scope.blockspinColors.length
						nextColor = scope.blockspinColors[counter]
						element.css('color', nextColor)
						if scope.loaderStatus == false
							window.clearTimeout(timer)
					if scope.blockspinColors.length == 1
						nextColor = scope.blockspinColors[0]
						element.css('color', nextColor)
					if scope.blockspinColors.length > 1
						timer = setInterval scope.bgchange, 500
		}