function Both
	incrId = 0

	rand: (min = 0, max) ->
		unless max?
			[min, max] = [0, min]
		min + Math.floor Math.random! * (max - min + 1)

	clamp: (val, min, max) ->
		| val < min => min
		| val > max => max
		else val

	upperFirst: (str) ->
		str.charAt! + str.substring 1

	indent: (code, level = 1) ->
		code.replace /^(?=.)/gm "\t"repeat level

	incrId: ->
		++incrId

	uuid: ->
		"#{Date.now!}_#{@rand 9e12}_#{@incrId!}"

	splitPath: (path) ->
		if path.0 is \/
			root = \/
			path .= substring 1
		else
			root = ""
		nodes = []
		for val in path.split /\/+/
			switch val
			| \. "" =>
			| \.. => nodes.pop!
			else nodes.push val
		[nodes, root]

	normPath: (path) ->
		[nodes, root] = @splitPath path
		root + nodes.join \/

	dirPath: (path) ->
		[nodes, root] = @splitPath path
		root + nodes.slice 0 -1 .join \/

	filePath: (path) ->
		[nodes] = @splitPath path
		nodes.at -1 or ""

	basePath: (path) ->
		name = @filePath path
		/^(.*?)(?:\.[^.]*)?$/exec name .1

	extPath: (path, withDot) ->
		name = @filePath path
		base = @basePath name
		ext = name.replace base, ""
		unless withDot
			ext .= substring 1
		ext
