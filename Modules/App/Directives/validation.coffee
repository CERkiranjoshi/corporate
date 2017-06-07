#
#		handle validation while form is beling used
#		Usage: in form tag use
#		Validation="yourSubmitFunction()"
#		add ng-required in your input field & use has-error & has-success class for display error
#		Note : add type="submit" in button
#
class Validation extends Directive
	constructor: ($parse)->
		return	{
			require: 'form'
			link : (scope, element, iAttrs, form) ->
				form.$submitted = false
				fn = $parse(iAttrs.validation)
				element.on 'submit', (event) ->
					scope.$apply ->
						form.$submitted = true
						#console.log form
						if form.$valid
							fn scope, $event: event
							form.$submitted = false
		}
