function TaskPubl
	statEntry: (entry) ->
		stat = await fs.stat entry
		name: stat.name
		path: stat.fullPath
		isFile: stat.isFile
		isDir: stat.isDirectory
		size: stat.size
		mtime: stat.modificationTime

	castEntryPath: (entry) ->
		if typeof entry is \object
			entry.path
		else entry

	readFile: (path, type = \text) ->
		path = @castEntryPath path
		type = @upperFirst type
		type = \DataURL if type is \DataUrl
		fs.readFile path, type

	writeFile: (path, data) ->
		path = @castEntryPath path
		entry = await fs.writeFile path, data
		@statEntry entry

	appendFile: (path, data) ->
		path = @castEntryPath path
		entry = await fs.appendFile path, data
		@statEntry entry

	installApp: (kind, url, path) !->
		switch kind
		| \boot
			text = await m.fetch "#url/app.yml"
			yml = jsyaml.safeLoad text
			await @writeFile "#path/app.yml" text
			text = await m.fetch "#url/app.ls"
			await @writeFile "#path/app.ls" text
			app = Object.assign do
				icon: \fad:window
				type: \user
				yml
				path: path
			os.apps.push app
		m.redraw!

	runTask: (ymlPath, env = {}) !->
		path = @dirPath ymlPath
		app = os.apps.find (.path is path)
		task = new Task app, env, @
		os.tasks.push task
		m.redraw!
