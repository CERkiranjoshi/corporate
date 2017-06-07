###
	A service that allows logging of debug messages
###
class Log extends Service
	constructor: ->
		@log = (msg, data) ->
			console?.log msg, data