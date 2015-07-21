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
			children = data.body.map (a) ->
				<Aste data={a} />
		switch data.type
			when "Program"
				<div style={@styling} className="program">
					{children}
				</div>
			when "FunctionDeclaration"
				<span className="function">
					function {data.id.name}() &#123;
						<Aste data={data.body} />
					&#125;
				</span>
			when 'ExpressionStatement'
				data = data.expression
				switch data.type
					when 'CallExpression'
						args = data.arguments.map (a) ->
							<Aste data={a} />
						return <span className="call">
							{data.callee.object.name}.{data.callee.property.name}(
								{args}
							)
						</span>
					else
						return <span className={data.type}></span>
			else
				<span className={data.type}>
					{children}
				</span>


React.render <Aste data={parsed} />, document.querySelector '.aste'
