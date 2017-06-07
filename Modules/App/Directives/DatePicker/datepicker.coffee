class TheEditDatePicker extends Directive
	constructor: ->
		{
			restrict: 'E'
			scope:
				ngModel: '='
				dateOptions: '='
				opened: '='
			link: ($scope, element, attrs) ->

				$scope.open = (event) ->
					event.preventDefault()
					event.stopPropagation()
					$scope.opened = true

				$scope.clear = ->
					$scope.ngModel = null

			templateUrl: 'App/Directives/DatePicker/datepicker.tmpl'
		}