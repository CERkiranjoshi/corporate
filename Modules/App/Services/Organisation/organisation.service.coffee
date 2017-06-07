###
	Supplys white labelled organisation data
	Currently read from a json file stored in data/organisation.json
	#TODO Need to use promises to ensure data always ready
	call like organisationService.ready().then (data)->
###
class Organisation extends Service

	constructor: ($q, $http, $timeout)->
		@p = $q.defer()

		$http.get('data/organisation.json').then (success) =>
			data = success.data
			@name = data.name
			@key = data.organisation_key
			@url = data.url
			@url_insecure = data.url_insecure
			@uuid = data.uuid
			@analytics_viewid = data.analytics_viewid
			@image_aws_url=data.image_aws_url
			@currency=data.currency

			# console.log "Start Loading Remote Config"
			# $http.get(@url + '/v2/configuration/').success (data) =>
			# 	console.log "Loaded Remote Config", data

			@p.resolve {name: @name, key: @key, url: @url, url_insecure: @url_insecure, uuid: @uuid, analytics_viewid:@analytics_viewid,image_aws_url:@image_aws_url,currency:@currency}

		@ready = ->
			@p.resolve {name: @name, key: @key, url: @url, url_insecure: @url_insecure, uuid: @uuid, analytics_viewid:@analytics_viewid,image_aws_url:@image_aws_url,currency:@currency} if @.hasOwnProperty 'name'	#if the service has already loaded
			@p.promise

	getName: -> @name
	getKey: -> @key
	