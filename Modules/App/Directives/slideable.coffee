class Slideable extends Directive
	constructor: ->
		return {
			restrict: 'C'
			compile: (element, attr) ->
				# wrap tag
				contents = element.html()
				element.html '<div class="slideable_content" style="margin:0 !important; padding:0 !important" >' + contents + '</div>'
				(scope, element, attrs) ->
					# default properties
					attrs.duration = if !attrs.duration then '1s' else attrs.duration
					attrs.easing = if !attrs.easing then 'ease-in-out' else attrs.easing
					element.css
						'overflow': 'hidden'
						'height': '0px'
						'transitionProperty': 'height'
						'transitionDuration': attrs.duration
						'transitionTimingFunction': attrs.easing
					return
		}


class SlideToggle extends Directive
	constructor: ->
		return {
			restrict: 'A'
			link: (scope, element, attrs) ->
				target = document.querySelector(attrs.slideToggle)
				attrs.expanded = false
				element.bind 'click', ->

					target = document.querySelector(attrs.slideToggle)

					content = target.querySelector('.slideable_content')
					if !attrs.expanded
						content.style.border = '1px solid rgba(0,0,0,0)'
						y = content.clientHeight
						content.style.border = 0
						target.style.height = y + 'px'
						element.toggleClass 'slider-open'
						angular.element(target).toggleClass 'slider-open'
					else
						target.style.height = '0px'
						element.toggleClass 'slider-open'
						angular.element(target).toggleClass 'slider-open'
					attrs.expanded = !attrs.expanded
					return
				return
		}