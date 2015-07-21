example = "
function test() {
	console.log('Hello world');
}

test.prototype.bla = function() {
	return 3+3;
}"
parsed = javascript_parser.parse example
console.log parsed

class Aste extends React.Component
	styling:
		fontFamily: "Courier New"
		margin: '3em'
	render: ->
		data = this.props.data
		children = []
		if data.body and data.body.length > 0
			for a in data.body
				children.push <Aste data={a} />
		switch data.type
			when "Program"
				<div style={@styling} class="program">
					{children}
				</div>
			when "FunctionDeclaration"
				<span class="function">
					function {data.id.name}() &#123;
						{children}
					&#125;
				</span>
			else
				return <span></span>


React.render <Aste data={parsed} />, document.querySelector '.aste'
console.log 'hi'
