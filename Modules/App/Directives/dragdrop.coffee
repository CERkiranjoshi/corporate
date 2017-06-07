#	Author : kiran joshi
#	Directive Name draggablecontent,droppablecontent
#	How To Use : add draggablecontent to list which you want to drag &  add droppablecontent to list in which you want to drop data
class Draggablecontent extends Directive
	constructor: ()->
		return	{
			restrict:'A'
			link : (scope, element, attrs) ->
				options =
					containment: 'document'
					helper: 'clone'
					appendTo: "body"
					cursor: "move"
					revert: true
					start:(e,ui)->
						$(ui.helper).addClass("ui-helper")
						wd = $(e.target).width()+14
						#for grid view
						if wd < 50
							wd = 200
						#for list view
						if wd >310
							wd = 310
						$(ui.helper).css 'width', wd+'px'
					drag: (e, ui) ->
						scope.draggedToFolder.file = scope.content
				element.draggable options
		}

class Droppablecontent extends Directive
	constructor: ()->
		return	{
			restrict:'A'
			link : (scope, element, attrs) ->
				options =
					hoverClass: 'ui-state-active'
					drop: (e, ui) ->
						scope.draggedToFolder.folder = scope.folder
						scope.dragAndDrop()
				element.droppable options
		}

class Changesize extends Directive
	constructor: ($timeout)->
		return	{
			restrict:'A'
			link : (scope, element, attrs) ->
				$timeout( ()->
					wd = element[0].clientWidth
					id = element[0].id
					newheight=(scope.folder.height/scope.folder.width)*wd
					$('#'+id).css('height',newheight+'px')
				)
		}