#	Author : kiran joshi
#	Directive Name Entersearch
#	How To Use : entersearch="getFilterProducts()" Name Of Attr as entersearch
class Entersearch extends Directive
	constructor: ()->
		return	{
			restrict:'A'
			link : (scope, element, attrs) ->
				element.bind 'keydown keypress', (event) ->
					if event.which == 13
						#console.log scope.$eval attrs.ngModel
						scope.$apply ->
							scope.$eval attrs.entersearch
						event.preventDefault()
		}