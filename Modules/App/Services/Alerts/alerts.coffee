###
	Handles the alert system.
###
class Alert extends Service
	constructor: ($rootScope, $window) ->

		$rootScope.alerts = []
		$rootScope.$on '$locationChangeSuccess', => @clear()

		$rootScope.closeAlert = (index) ->
			$rootScope.alerts.splice index, 1

		@Success = (message, keepAfterLocationChange, dontClear) ->
			@clear() unless dontClear
			$rootScope.alerts.push
				message: message
				type: 'success'
				keepAfterLocationChange: keepAfterLocationChange
			@scrollIntoView()

		@Error = (message, keepAfterLocationChange, dontClear) ->
			@clear() unless dontClear
			$rootScope.alerts.push
				message: message
				type: 'danger'
				keepAfterLocationChange: keepAfterLocationChange
			@scrollIntoView()

		@closeAlert = (index) ->
			$rootScope.alerts.splice index, 1

		@clear = (index) ->
			for alert, index in $rootScope.alerts
				if alert.keepAfterLocationChange
					alert.keepAfterLocationChange = false
				else
					$rootScope.alerts.splice(index, 1)


		@scrollIntoView = ->
			$window.scrollTo 0,0