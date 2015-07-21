example = """
function test() {
	console.log('Hello world');
	var variable = 5;
}

test.prototype.bla = function() {
	return 3+3;
}
"""

# esprima uses almost the same syntax as pegjs except for the range stuff. peg will be used if this becomes more than a POC. peg does not support the range option

class File
	# All cursors and their scope
	selections: [
		[1, 1, 0]
	]

	mode: 'visual'

	constructor: (@source) ->
		@tree = esprima.parse @source,
			tolernat: true
			range: true
	
	send: (key) ->
		console.log key
		for selection in @selections
			switch key
				when 'h'
					selection.pop()
				when 'l'
					selection.push 0
				when 'j'
					selection[selection.length-1]++
				when 'k'
					selection[selection.length-1]--
		console.log @selections[0]

	computeSelections: () ->
		selections = {}
		for selection in @selections
			node = @tree
			i = 0
			while i < selection.length
				switch node.type
					when 'ExpressionStatement'
						node = node.expression
					when 'AssignmentExpression'
						switch selection[i]
							when 0
								node = node.left
							when 1
								node = node.right
						i++
					else
						console.log "no resolve of #{node.type}, trying body"
						if node.body instanceof Array
							node = node.body[selection[i]]
							i++
						else
							node = node.body
			selections[node.range[0]] = node.range[1]
		return selections


bla = new File example
console.log bla.source, bla.tree

class Aste extends React.Component
	styling:
		fontFamily: "Courier New"
		margin: '3em'
	selected:
		backgroundColor: 'lightblue'
	handleKeyDown: (event) =>
		if @props.file.mode == 'visual'
			key = String.fromCharCode event.keyCode
				.toLowerCase()
			@props.file.send key
			@forceUpdate()		# is this needed?
	componentDidMount: () ->
		document.body.addEventListener 'keydown', @handleKeyDown
	render: ->
		characters = []
		file = @props.file
		selections = file.computeSelections()
		i = 0
		while i < file.source.length
			to = selections[i]
			if to?
				for j in [i...to]
					characters.push <span style={@selected}>{file.source[j]}</span>
				i = to
			characters.push file.source[i]
			i++
		<pre style={@styling}>{characters}</pre>




React.render <Aste file={bla} />, document.querySelector '.aste'
