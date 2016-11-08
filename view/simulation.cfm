<h2>Simulator Running</h2>
<br />

<!--- Add next and back buttons that only appear when they logically make sense to --->
<p style="text-align: center;">
	<!--- when it is not the beginning, make the button clickable --->
	<cfIf url.step NEQ 0>
		<a href="back.htm?step=<cfOutput>#url.step-1#</cfOutput>" class="btn btn-default">
			 <span class="fa fa-arrow-left"></span> Back
		</a>
	<cfElse>
		<!--- disable it and remove the link --->
		<a href="" class="btn btn-default" disabled>
			 <span class="fa fa-arrow-left"></span> Back
		</a>
	</cfIf>
	<!--- when it is not the end, make the button clickable --->
	<cfIf url.step NEQ ArrayLen(session.trace)>
		<a href="next.htm?step=<cfOutput>#url.step+1#</cfOutput>" class="btn btn-primary">
			Next <span class="fa fa-arrow-right"></span>
		</a>
	<cfElse>
		<!--- disable it and remove the link --->
		<a href="" class="btn btn-primary" disabled>
			Next <span class="fa fa-arrow-right"></span>
		</a>
	</cfIf>
</p>

<div class="row">
	<!--- left column --->
	<div class="col-md-6">
		<h3>Memory</h3>
		<table class="table">
			<thead>
				<tr>
					<th>Frame</th>
					<th>Physical Memory</th>
				</tr>
			</thead>
			<tbody>
				<!--- Loop through the number of frames --->
				<cfLoop from="1" to="#session.numFrames#" index="i">
					<tr>
						<td>
							Frame <cfOutput>#i-1#</cfOutput>
						</td>
						<!--- What is stored in this frame of memory --->
						<td>
							<cfOutput>#session.physicalM[i]#</cfOutput>
						</td>
					</tr>
				</cfLoop>
			</tbody>
		</table>
	</div>
	<!--- right column --->
	<div class="col-md-6">
		<!--- Trace line table --->
		<h3>Trace Line</h3>
		<table class="table">
			<thead>
				<tr>
					<th>Line</th>
					<th>PID &nbsp; Text &nbsp; Data</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Previous Line</th>
					<td>
						<cfIf url.step EQ 0>
							N/a
						<cfElseIf url.step EQ 1>
							Start of File
						<cfElse>
							<cfOutput>#session.trace[url.step-1].line#</cfOutput>
						</cfIf>
					</td>
				</tr>
				<tr>
					<th>Current Line</th>
					<td>
						<cfIf url.step EQ 0>
							Start of File
						<cfElse>
							<cfOutput>#session.trace[url.step].line#</cfOutput>
						</cfIf>
					</td>
				</tr>
				<tr>
					<th>Next Line</th>
					<td>
						<cfIf url.step NEQ ArrayLen(session.trace)>
							<cfOutput>#session.trace[url.step+1].line#</cfOutput>
						<cfElse>
							End of File
						</cfIf>
					</td>
				</tr>
			</tbody>
		</table>

		<cfIf variables.lineType EQ "trace">
			<!--- Page breakdown for line --->
			<h3>Current Line Breakdown</h3>
			<table class="table">
				<thead>
					<tr>
						<th>Segment Type</th>
						<th>Number of Pages</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Text</td>
						<td>
							<cfOutput>#variables.textPages#</cfOutput>
						</td>
					</tr>
					<tr>
						<td>Data</td>
						<td>
							<cfOutput>#variables.dataPages#</cfOutput>
						</td>
					</tr>
				</tbody>
			</table>
		</cfIf>
	</div>
</div>


<!--- Add next and back buttons that only appear when they logically make sense to --->
<p style="text-align: center;">
	<!--- when it is not the beginning, make the button clickable --->
	<cfIf url.step NEQ 0>
		<a href="back.htm?step=<cfOutput>#url.step-1#</cfOutput>" class="btn btn-default">
			 <span class="fa fa-arrow-left"></span> Back
		</a>
	<cfElse>
		<!--- disable it and remove the link --->
		<a href="" class="btn btn-default" disabled>
			 <span class="fa fa-arrow-left"></span> Back
		</a>
	</cfIf>
	<!--- when it is not the end, make the button clickable --->
	<cfIf url.step NEQ ArrayLen(session.trace)>
		<a href="next.htm?step=<cfOutput>#url.step+1#</cfOutput>" class="btn btn-primary">
			Next <span class="fa fa-arrow-right"></span>
		</a>
	<cfElse>
		<!--- disable it and remove the link --->
		<a href="" class="btn btn-primary" disabled>
			Next <span class="fa fa-arrow-right"></span>
		</a>
	</cfIf>
</p>

<p>
	<a href="index.htm" class="btn btn-default">Restart</a>
</p>