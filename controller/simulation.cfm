<cfSet variables.mime = "text/plain" />
<cfSet variables.path = "files/trace" />
<cfSet variables.tempPath = "#variables.path#/temp" />


<!---
<!--- Check/Create folder---->
<cfIf NOT directoryExists(variables.path)>
	<cfDirectory action="create" directory="#variables.path#" />
</cfIf>
<cfIf NOT directoryExists(variables.tempPath)>
	<cfDirectory action="create" directory="#variables.tempPath#" />
</cfIf>
--->

<!--- Upload spreadsheet to temp location--->
<!--- <cfTry>
	<cfFile action="upload" accept="#variables.mime#" destination="#variables.tempPath#/" fileField="emailFile" mode="644" nameconflict="makeunique" />
	<cfSet variables.extension = lCase(trim(cfFile.clientFileExt)) />
	<cfCatch>
		Your document is not valid, please use the back button and upload a new file.
		<cfAbort />
	</cfCatch>
</cfTry> --->

<!--- Read file --->
<cfTry>
	<cfFile action="read" file="/www/gvsu/OSProject3/input3a.data" variable="traceFile" />
	<cfCatch>
		Could not read file.
		<cfAbort />
	</cfCatch>
</cfTry>

<!--- Turn text file list from read into an array --->
<cfSet variables.traceArray = listToArray("#traceFile#", "#chr(13)##chr(10)#") />

<!--- Loop over array and for each element, turn the list into an array --->
<cfLoop array="#variables.traceArray#" index="line">
	
</cfLoop>