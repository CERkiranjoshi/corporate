#	Author : kiran joshi
#	Directive Name Sortable
#	How To Use : sortable list="categoriesList" Name Of Attr as sortable & list will be the Scope of List you want to sort
class Sortable extends Directive
	constructor: ()->
		return	{
			scope:
				list: '='
			restrict:'A'
			link : ($scope, element, attrs,ngModelCtrl) ->
				$scope.$watch 'list',(value) ->
					options =
						cancel: 'input,textarea,button,select,option'
						items: '> [ng-repeat],> [data-ng-repeat],> [x-ng-repeat]'
						placeholder: "ui-state-highlight"
						axis: 'y'
						appendTo: "document.body"
						cursor: "move"
						opacity: 0.9
						revert: true
						start: (e, ui) ->
							ui.item.data 'start', ui.item.index()
							ui.item.parent().css 'overflow', 'auto'
						update: (e, ui) ->
							start = ui.item.data('start')
							end = ui.item.index()
							value.splice end, 0, value.splice(start, 1)[0]
							$scope.$apply()
							if attrs.SortableOnUpdate
								$scope.$eval attrs.SortableOnUpdate
					element.sortable options
		}