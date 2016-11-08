<!--- Set up global variables via form inputs --->
<cfSet session.physicalMsize = Val(form.physicalMSizeKB) * session.kb />
<cfSet session.pageSize = Val(form.pageSizeKB) * session.kb />
<cfSet session.numFrames = session.physicalMsize / session.pageSize />

<!--- Set up physical memory as a 1 dimensional array --->
<cfSet session.physicalM = ArrayNew(1) />
<!--- Loop through the array numFrames time and initialize to NULL --->
<cfLoop from="1" to="#session.numFrames#" index="i">
	<cfSet session.physicalM[i] = "" />
</cfLoop>


<!--- Set mime and path of traces files --->
<cfSet variables.mime = "text/plain" />
<cfSet variables.path = "/Library/WebServer/Documents/OSProject3/files/trace" />

<cfIf form.fileUpload EQ "">
	<p>
		Failed to select a file. Please go back and select a file to run.
	</p>
	<cfAbort />
</cfIf>

<!--- Read file --->
<cfTry>
	<cfFile action="read" file="#form.fileUpload#" variable="traceFile" />

	<cfCatch>
		<h2>Could not read file.</h2>
		<cfDump var="#cfcatch#" />
		<cfAbort />
	</cfCatch>
</cfTry>

<!--- The trace structure will be stored in the session so it can be accessed across multiple pages. --->

<!--- Turn text file list from read into an array delimited by \n\r --->
<cfSet session.traceArray = listToArray("#traceFile#", "#chr(13)##chr(10)#") />

<!--- Create a new structure to hold the multiple split arrays --->
<cfSet session.trace = ArrayNew(1) />

<cfSet variables.counter = 1 />

<!--- Loop over array and for each element, turn the list into an array --->
<cfLoop array="#session.traceArray#" index="line">
	<!--- For each line (i.e. process) make a structure --->
	<cfSet session.trace[variables.counter] = StructNew() />

	<!--- Within the structure, make an array of the individual line delimited by \n\r --->
	<cfSet session.trace[#variables.counter#].process = listToArray("#line#", " ") />

	<!--- Within the structure, keep the full line --->
	<cfSet session.trace[#variables.counter#].line = #line# />
	
	<!--- Increment counter --->
	<cfSet variables.counter += 1 />
</cfLoop>


<!--- Establish the backup for stepping back through history --->
<!--- This will be an array of structures --->
<!--- Each structure will have 2 keys: the array of physical M and an array of structures --->
<!--- Those arrays of structures will be the Page Tables --->

<!--- create array of structures (one for each trace line) --->
<cfSet session.history = ArrayNew(1) />
<cfLoop from="1" to="#ArrayLen(session.trace)#" index="i">
	<cfSet session.history[i] = StructNew() />
	<!--- Indicate no histry exists for the STEP --->
	<cfSet session.history[i].exists = false />
	<!--- Add physical M array --->
	<cfSet session.history[i].physicalM = ArrayNew(1) />
	<!--- Add array of page table structs --->
	<cfSet session.history[i].pageTables = ArrayNew(1) />
	<cfLoop from="1" to="#variables.maxRecords#" index="j">
		<!--- Build the page table struct --->
		<cfSet session.history[i].pageTables[j] = StructNew() />
		<cfSet session.history[i].pageTables[j].pid = j />
		<cfSet session.history[i].pageTables[j].segType = "" />
		<cfSet session.history[i].pageTables[j].page = "" />
		<cfSet session.history[i].pageTables[j].frame = "" />
	</cfLoop>
</cfLoop>
<!--- End of backup establishment --->