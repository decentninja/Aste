example = """
function test() {
	console.log('Hello world');
}

test.prototype.bla = function() {
	return 3+3;
}
"""

# esprima uses almost the same syntax as pegjs except for the range stuff. peg will be used if this becomes more than a POC. peg does not support the range option

class File
	selections:
		0: 5

	constructor: (@source) ->
		@tree = esprima.parse @source,
			tolernat: true
			range: true

bla = new File example
console.log bla.source, bla.tree

class Aste extends React.Component
	styling:
		fontFamily: "Courier New"
		margin: '3em'
	selected:
		backgroundColor: 'lightblue'
	render: ->
		characters = []
		file = this.props.file
		i = 0
		while i < file.source.length
			to = file.selections[i]
			if to?
				for j in [i...to]
					characters.push <span style={@selected}>{file.source[j]}</span>
				i = file.selections[i]
			characters.push file.source[i]
			i++
		<pre style={@styling}>{characters}</pre>




React.render <Aste file={bla} />, document.querySelector '.aste'
