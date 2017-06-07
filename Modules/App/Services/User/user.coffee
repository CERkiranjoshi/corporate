class User extends Service
	constructor: ($q, $timeout, $filter) ->
		@Create = (user) ->
			deferred = $q.defer()
			# simulate api call with $timeout
			$timeout (->
				userService.GetByUsername(user.username).then (duplicateUser) ->
					if duplicateUser != null
						deferred.resolve
						success: false
						message: 'Username "' + user.username + '" is already taken'
					else
						users = userService.getUsers()
						# assign id
						lastUser = users[users.length - 1] or id: 0
						user.id = lastUser.id + 1
						# save to local storage
						users.push user
						userService.setUsers users
						deferred.resolve success: true
					return
				return
			), 1000
			deferred.promise


		@GetByUsername = (username) ->
			deferred = $q.defer()
			filtered = $filter('filter')(userService.getUsers(), username: username)
			user = if filtered.length then filtered[0] else null
			deferred.resolve user
			deferred.promise


		@getUsers = ->
			if !localStorage.users
				localStorage.users = JSON.stringify([])
			JSON.parse localStorage.users

		@setUsers = (users) ->
			localStorage.users = JSON.stringify(users)
			return