class Analytics extends Service
	constructor: ($rootScope, $http, $q, $log, organisationService,localStorageService) ->
		@query = (params)->
			p = $q.defer()
			data = new (gapi.analytics.report.Data)(query: params)
			data.once('success', (response) ->
				p.resolve response
				return
			).once('error', (response) ->
				p.reject response
				return
			).execute()
			p.promise

		@getToken = ()->
			p = $q.defer()
			d = new Date()
			currentTime = d.getTime()
			token = localStorageService.get 'googleAccessToken'
			if token != null and token.expire > currentTime
				p.resolve token
				p.promise
			else
				organisationService.ready().then( (organisation) ->
					req =
						method: 'GET'
						url: organisation.url + '/v2/google-access-token/'
						headers: 'Content-Type': 'application/json'
					$http(req).then ((results) =>
						obj = results.data
						d = new Date()
						currentTime = d.getTime()
						obj.expire = currentTime + (3600*1000)
						obj.analytics_viewid = organisation.analytics_viewid
						localStorageService.set 'googleAccessToken', obj
						p.resolve results.data
					), (error) ->
						p.reject error.statusText
				)
				p.promise

		@convertTime24to12 = (timeValue)->
			if timeValue==0
				temp = "12 AM"
			else if timeValue < 12
				temp =  "#{timeValue} AM"
			else if timeValue == 12
				temp = "#{timeValue} PM"
			else
				temp = "#{timeValue-12} PM"
			return temp

		@dayDiff = (date2,date1)->
			second = new Date(date2)
			first = new Date(date1)
			return Math.round((second-first)/(1000*60*60*24))

		@formatDate = (d)->
			month = parseInt(d.getMonth()) + 1
			day = parseInt(d.getDate())
			year = d.getFullYear()
			if month.toString().length < 2
				month = '0' + month.toString()
			if day.toString().length < 2
				day = '0' + day.toString()
			return [year, month, day].join('-')

		@splitValue = (value, start,index)->
			value.substring(start, index)

		@getSplitDate = (date)->
			date.substring(0, 4)+"-"+date.substring(4,6)+"-"+date.substring(6,8)

		@getDisplayDate =(date)->
			d = new Date(date)
			day = parseInt(d.getDate())
			month = parseInt(d.getMonth())
			monthname = @getMonthName(month) + " "+day

		@getMonthName = (m)->
			month = []
			month[0] = 'January'
			month[1] = 'February'
			month[2] = 'March'
			month[3] = 'April'
			month[4] = 'May'
			month[5] = 'June'
			month[6] = 'July'
			month[7] = 'August'
			month[8] = 'September'
			month[9] = 'October'
			month[10] = 'November'
			month[11] = 'December'
			monthname=month[m]
			return monthname.substring(0, 3)