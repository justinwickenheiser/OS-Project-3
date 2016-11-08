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
