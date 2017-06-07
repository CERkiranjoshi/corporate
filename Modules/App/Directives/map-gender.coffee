class MapGender extends Filter
	constructor: ->
		genderHash =
			'M': 'Male'
			'F': 'Female'
			'U': 'Unisex'
		(input) ->
			if !input
				''
			else
				genderHash[input]


class Gender extends Service
	constructor: ->
		@getGenders = ->
			[
				{
					value: 'men'
					label: 'Mens'
				}
				{
					value: 'women'
					label: 'Womens'
				}
				{
					value: 'unisex'
					label: 'Unisex'
				}
			]



class Checkmark extends Filter
	constructor: ->
		return (input) -> if input then '✓' else '✘'



class ProductFilter extends Filter
	constructor: ->
		return (productFilters, product) ->
			console.lof 'productFilters', productFilters
			console.lof 'productFilters product', product
			true