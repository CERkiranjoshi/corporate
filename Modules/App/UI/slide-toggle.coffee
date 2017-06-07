class SlideToggle extends Animation
	constructor: ($animateCss)->

		lastId = 0
		_cache = {}

		getId = (el) ->
			id = el[0].getAttribute('data-slide-toggle')
			if !id
				id = ++lastId
				el[0].setAttribute 'data-slide-toggle', id
			id

		getState = (id) ->
			state = _cache[id]
			if !state
				state = {}
				_cache[id] = state
			state

		generateRunner = (closing, state, animator, element, doneFn) ->
			->
				state.animating = true
				state.animator = animator
				state.doneFn = doneFn
				animator.start().finally ->
					if closing and state.doneFn == doneFn
						element[0].style.height = ''
					state.animating = false
					state.animator = undefined
					state.doneFn()
					return
				return

		return
		{
			addClass: (element, className, doneFn) ->
				if className == 'ng-hide'
					state = getState(getId(element))
					height = if state.animating and state.height then state.height else element[0].offsetHeight
					animator = $animateCss(element,
						from:
							height: height + 'px'
							opacity: 1
						to:
							height: '0px'
							opacity: 0)
					if animator
						if state.animating
							state.doneFn = generateRunner(true, state, animator, element, doneFn)
							return state.animator.end()
						else
							state.height = height
							return generateRunner(true, state, animator, element, doneFn)()
				doneFn()
				return
			removeClass: (element, className, doneFn) ->
				if className == 'ng-hide'
					state = getState(getId(element))
					height = if state.animating and state.height then state.height else element[0].offsetHeight
					animator = $animateCss(element,
						from:
							height: '0px'
							opacity: 0
						to:
							height: height + 'px'
							opacity: 1)
					if animator
						if state.animating
							state.doneFn = generateRunner(false, state, animator, element, doneFn)
							return state.animator.end()
						else
							state.height = height
							return generateRunner(false, state, animator, element, doneFn)()
				doneFn()
				return
		}