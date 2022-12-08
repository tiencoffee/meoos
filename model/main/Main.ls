class Main
	->
		@ <<< Both!
		@ <<< TaskPubl!
		m.bind @
		@taskbar =
			height: 37
		@desktop =
			x: 0
			y: 0
			width: innerWidth
			height: innerHeight - @taskbar.height
		@apps = []
		@tasks = []
		@dom = void
		@loaded = no

	oncreate: (vnode) !->
		@dom = vnode.dom
		await fs.init do
			bytes: 536870912
		for path in Paths"/C/apps/*"
			await @installApp \boot path, path
		@loaded = yes
		m.redraw!
		@runTask \/C/apps/FileManager/app.yml

	view: ->
		m \.Main,
			m \.Main__tasks,
				@tasks.map (task) ~>
					m task,
						key: task.pid
			m \.Main__taskbar,
				m \.Main__taskbarTasks,
					@tasks.map (task) ~>
						m Button,
							key: task.pid
							class: \Main__taskbarTask
							icon: task.icon
							task.title

m.css do
	'.Main':
		height: \100%
		display: \flex
		flexDirection: \column
	'.Main__tasks':
		position: \relative
		flex: 1
	'.Main__taskbar':
		padding: '4px 8px'
		borderTop: "solid 1px #{Css.gray.4}"
		display: \flex
		alignItems: \center
		gap: 8
		background: \#fff
		zIndex: 1
	'.Main__taskbarTasks':
		display: \flex
		gap: 4
	'.Main__taskbarTask':
		width: 200
