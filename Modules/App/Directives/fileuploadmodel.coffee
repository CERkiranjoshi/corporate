#		Usage: filemodel="curatedListData.selectedImage"
class Filemodel extends Directive
	constructor: ($parse,$timeout)->
		return	{
			restrict: 'A'
			link : (scope, element, attrs) ->
				model = $parse(attrs.filemodel)
				modelSetter = model.assign
				element.bind 'change', ->
					$timeout( ->
						modelSetter scope , element[0].files[0]
					,)
		}