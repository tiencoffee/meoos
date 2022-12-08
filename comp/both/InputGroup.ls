InputGroup = m.comp do
	view: ->
		m \.InputGroup,
			class: m.class do
				@attrs.class
			style: m.style do
				@attrs.style
			@children

m.css do
	'.InputGroup':
		'>*':
			position: \relative
		'>:not(:first-child)':
			marginLeft: -1
			borderTopLeftRadius: 0
			borderBottomLeftRadius: 0
		'>:not(:last-child)':
			borderTopRightRadius: 0
			borderBottomRightRadius: 0
		'>.Button':
			zIndex: 1
		'>.Button--hasColor':
			zIndex: 2
