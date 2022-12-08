Icon = m.comp do
	onbeforeupdate: !->
		@attrs.size ?= 16
		if typeof @attrs.name in [\string \number]
			[kind, name] = @attrs.name / \:
			unless name?
				name = kind
				kind = /^\d{3,}$/test name and \flaticon or \fas
		else
			kind = \blank
		@kind = kind
		@name = name

	view: ->
		switch @kind
		| \blank
			m \.Icon.Icon--blank,
				class: m.class do
					@attrs.class
				style: m.style do
					width: @attrs.size
					height: @attrs.size
		| \flaticon \https \http
			m \img.Icon.Icon--img,
				class: m.class do
					@attrs.class
				style: m.style do
					width: @attrs.size
					height: @attrs.size
				src: "https://cdn-icons-png.flaticon.com/64/#{@name.slice 0 -3}/#@name.png"
		else
			m \.Icon.Icon--font,
				class: m.class do
					"#@kind fa-#@name"
					@attrs.class
				style: m.style do
					fontSize: @attrs.size

m.css do
	'.Icon':
		minWidth: 20
		display: \inline-flex
		justifyContent: \center
		alignItems: \center
	'.Icon--img':
		minHeight: 20
		objectFit: \contain
