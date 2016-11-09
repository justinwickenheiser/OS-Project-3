<h2>Simulation Running</h2>
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
						<td <cfIf session.physicalM[i] NEQ "">class="<cfOutput>#lCase(mid(session.physicalM[i],1,2))#</cfOutput>"</cfIf> >
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
				<tr class="currentLine">
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

<cfIf variables.numPageTables NEQ 0>
	<h3>Page Tables</h3>
	<!--- Show Page Tables --->
	<cfLoop from="1" to="#variables.numRows#" index="i">
		
		<div class="row">
			<!--- Left column --->
			<div class="col-md-6">
				<h4 class="p<cfOutput>#session.pageTables[variables.existingPageTables[variables.page]].pid#</cfOutput>">
					PID <cfOutput>#session.pageTables[variables.existingPageTables[variables.page]].pid#</cfOutput>
				</h4>
				
				<table class="table">
					<thead>
						<tr>
							<th>Frame</th>
							<th>Segment Type</th>
							<th>Page</th>
						</tr>
					</thead>
					<tbody>
						<!--- Loop over the array of pages --->
						<cfLoop from="1" to="#ArrayLen(session.pageTables[variables.existingPageTables[variables.page]].page)#" index="j">
							<tr>
								
								<td>
									<cfOutput>
										#session.pageTables[variables.existingPageTables[variables.page]].frame[j]#
									</cfOutput>
								</td>
								<td>
									<cfOutput>
										#session.pageTables[variables.existingPageTables[variables.page]].segType[j]#
									</cfOutput>
								</td>
								<td>
									<cfOutput>
										#session.pageTables[variables.existingPageTables[variables.page]].page[j]#
									</cfOutput>
								</td>
							</tr>
						</cfLoop>
					</tbody>
				</table>

				<cfSet variables.page += 1 />
			</div>

			<!--- Right column --->
			<!--- Only display if the table exists --->
			<cfIf variables.page LTE variables.numPageTables>
				<div class="col-md-6">
					<h4 class="p<cfOutput>#session.pageTables[variables.existingPageTables[variables.page]].pid#</cfOutput>" >
						PID <cfOutput>#session.pageTables[variables.existingPageTables[variables.page]].pid#</cfOutput>
					</h4>
					
					<table class="table">
						<thead>
							<tr>
								<th>Frame</th>
								<th>Segment Type</th>
								<th>Page</th>
							</tr>
						</thead>
						<tbody>
							<!--- Loop over the array of pages --->
							<cfLoop from="1" to="#ArrayLen(session.pageTables[variables.existingPageTables[variables.page]].page)#" index="j">
								<tr>
									
									<td>
										<cfOutput>
											#session.pageTables[variables.existingPageTables[variables.page]].frame[j]#
										</cfOutput>
									</td>
									<td>
										<cfOutput>
											#session.pageTables[variables.existingPageTables[variables.page]].segType[j]#
										</cfOutput>
									</td>
									<td>
										<cfOutput>
											#session.pageTables[variables.existingPageTables[variables.page]].page[j]#
										</cfOutput>
									</td>
								</tr>
							</cfLoop>
						</tbody>
					</table>

					<cfSet variables.page += 1 />
				</div>
			</cfIf>
		</div>
	</cfLoop>
</cfIf>

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