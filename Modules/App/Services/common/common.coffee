class Common extends Service
	constructor:($q,$http,organisationService,$window) ->

		@validDates = (start,end)->
			obj={}
			obj.error=false
			obj.message=''
			now = new Date()
			current=parseInt(now.getTime() / 1000).toFixed(0)
			if end <=start
				obj.error=true
				obj.message='End date should be greater then Start date.'
			else if end <=current
				obj.error=true
				obj.message='End date should be greater then Current time.'
			obj

		@validTodayDatetime = (end,fortype='Notification')->
			obj={}
			obj.error=false
			obj.message=''
			now = new Date()
			current=parseInt(now.getTime() / 1000).toFixed(0)
			if end <=current
				obj.error=true
				obj.message= fortype+' time should be greater then current time.'
			obj


		@validStatus = (start,end)->
			st='Inactive'
			now = new Date()
			current=parseInt (now.getTime() / 1000).toFixed(0)
			if start>current
				st='Inactive'
			else if start<=current and end >=current
				st='Active'
			st

		@getDate=(date,type='string')->
			dt= new Date(date)
			da=dt.getDate()
			if type=='string'
				return da.toString()
			return da

		@getDay=(date,type='short')->
			d = new Date(date)
			weekday=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
			n = weekday[d.getDay()]
			if type=='short'
				day=n.toUpperCase()
				shortday=day.substring(0, 3)
				return shortday
			return n

		@getMonth=(date,type='short')->
			d = new Date(date)
			month=['January','February','March','April','May','June','July','August','September','October','November','December']
			n = month[d.getMonth()]
			if type=='short'
				mon=n.toUpperCase()
				shortmon=mon.substring(0, 3)
				return shortmon
			return n

		@getMinute=(date)->
			dt= new Date(date)
			da=dt.getMinutes()
			return da.toString()

		@getHour=(date)->
			dt= new Date(date)
			da=dt.getHours()
			return da.toString()

		@replaceString=(str)->
			str=str.replace(/:|_/g,'')
			return str
		
		@uploadFile = (file,type='image')->
			p = $q.defer()
			fd = new FormData
			fd.append 'file', file
			headerRequest =
  				transformRequest:  angular.identity
  				headers: {'Content-Type': undefined}
			organisationService.ready().then( (organisation) ->
				url = organisation.url + '/' + organisation.key + '/v2/content/?upload_type='+type
				$http.post(url,fd,headerRequest).then (results)->
					p.resolve results
				,(error) ->
					p.reject error.statusText
			)
			p.promise


		@get = -> @curatedQueue

		@clear = ()->
			@list.length = 0
			@curatedQueue.length = 0

		@setSessionStorage = (name,val)->
			$window.sessionStorage[name] = JSON.stringify(val)

		@getSessionStorage = (name)->
			if $window.sessionStorage[name] != undefined
				gb = JSON.parse $window.sessionStorage[name]
				return gb

		@clearUrlSpace = (name)->
			furl = name.replace(RegExp(' ', 'g'), '%20')
			return furl