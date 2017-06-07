class Authentication extends Factory
	constructor: ($rootScope, $http, $cookieStore, $base64, organisationService,$q,$window,localStorageService) ->
		return {
			Login: (username, password, callback) ->
				#No data set to auth against.
				#Attempt a request using the details supplied and check the response
				response = undefined
				d=$q.defer()
				organisationService.ready().then ( (organisationData)->
					$http.defaults.headers.common.Authorization = 'Basic ' + $base64.encode(username + ':' + password)
					$http.get(organisationData.url + '/' + organisationData.key + '/v2/' + organisationData.uuid + '/brands/').then ( (results)=>
						response = success: true
						d.resolve response
						callback response
					)
				)
				d.promise

			SetCredentials: (username, password) ->
				$rootScope.globals = {}
				authdata = $base64.encode(username + ':' + password)
				$rootScope.globals = currentUser:
					authdata: authdata
				$http.defaults.headers.common['Authorization'] = 'Basic ' + authdata
				$window.sessionStorage.globals  = JSON.stringify($rootScope.globals)
				#$cookieStore.put 'globals', $rootScope.globals


			ClearCredentials: ->
				$rootScope.globals = {}
				$window.sessionStorage.clear()
				localStorageService.clearAll()
				#$cookieStore.remove 'globals'
				$http.defaults.headers.common.Authorization = 'Basic '

		}