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

<form method="post" action="simulation.htm" enctype="multipart/form-data">
	<p>
		<label for="fileUpload">
			Please upload a trace file <span style="color: red;">*</span>
		</label>
		<input type="file" name="fileUpload" required="true">
	</p>
	<p>
		<input type="submit" class="btn btn-primary" value="Submit" />
	</p>
</form>
