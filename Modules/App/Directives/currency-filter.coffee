class CurrencyFilter extends Filter
	constructor: ->
		return (value) -> value.toFixed(2).replace /\d(?=(\d{3})+\.)/g, '$&,'