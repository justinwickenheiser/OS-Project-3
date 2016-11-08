<!--- Set the info of the trace line --->
<cfIf url.step NEQ 0>
	<!--- trace type --->
	<cfIf ArrayLen(session.trace[url.step].process) EQ 2>
		<cfSet variables.lineType = "halt" />
		<cfSet variables.pid = session.trace[url.step].process[1] />
	<cfElse>
		<cfSet variables.lineType = "trace" />
		<cfSet variables.pid = session.trace[url.step].process[1] />
		<cfSet variables.textPages = ceiling(session.trace[url.step].process[2] / session.pageSize) />
		<cfSet variables.dataPages = ceiling(session.trace[url.step].process[3] / session.pageSize) />
	</cfIf>
<cfElse>
	<cfSet variables.lineType = "none" />
</cfIf>


<!--- Find out how many Page Tables are needed to be displayed --->
<cfSet variables.numPageTables = 0 />
<cfSet variables.existingPageTables = ArrayNew(1) />
<cfIf url.step NEQ 0>
	<cfLoop array="#session.history[url.step].pageTables#" index="i">
		<!--- if the table exists, increment numPageTable count and add the pid number to the list of existing tables --->
		<cfIf i.exists>
			<cfSet variables.numPageTables += 1 />
			<cfSet #ArrayAppend(variables.existingPageTables,i.pid+1)# />
		</cfIf>
	</cfLoop>
</cfIf>

<cfSet variables.page = 1 />