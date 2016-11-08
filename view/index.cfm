<h2>Memory Simulator</h2>
<br />

<p>
	This simulation reads a trace tape of recorded process executions.  The trace tape contains two types of events. Each event is on a separate line and has one of the following formats:<br />
	<ol>
		<li>Process arrival: &nbsp; ProcID &nbsp; TextSize &nbsp; DataSize</li>
		<li>Process termination: &nbsp; ProcID &nbsp; Halt</li>
	</ol>
	where sizes are given in bytes.
</p>

<p>
	<strong>System Specs:</strong><br />
	Physical Memory: 4 KB<br />
	Page/Frame Size: 512 B<br />
</p>

<form method="post" action="index_post.htm" enctype="multipart/form-data">
	<input type="hidden" name="physicalMSizeKB" value="4" />
	<input type="hidden" name="pageSizeKB" value =".5" />

	<p>
		<label for="fileUpload">
			Please select a trace file <span style="color: red;">*</span>
		</label>
		<br />
		<cfOutput>
			<select name="fileUpload" id="inputFiles" required="true">
				<option value="">- Please Select</option>
				<cfLoop array="#variables.inputFiles#" index="i">
					<!--- The file has .data extension --->
					<cfIf #find(".data", i)#>
						<option value="#i#">#getFileFromPath(i)#</option>
					</cfIf>
				</cfLoop>
			</select>
		</cfOutput>
	</p>
	<p>
		<input type="submit" class="btn btn-primary" value="Submit" />
	</p>
</form>
