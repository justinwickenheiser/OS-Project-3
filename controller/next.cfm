<!--- Set the info of the trace line for steps with no history --->
<cfIf url.step NEQ 0 AND !session.history[#url.step#].exists>
	<!--- trace type --->
	<cfIf ArrayLen(session.trace[url.step].process) EQ 2>
		<cfSet variables.lineType = "halt" />
		<cfSet variables.pid = session.trace[url.step].process[1] />

		<!--- Loop through physical M and empty frames that have the pid --->
		<cfLoop from="1" to="#session.numFrames#" index="i">
			<cfSet variables.currentPid = "P" & variables.pid />
			<!--- If current frame contains the pid then empty it --->
			<cfIf #find(variables.currentPid, session.physicalM[i])# >
				<cfSet session.physicalM[i] = "" />
			</cfIf>

			<!--- Update page table for current process --->

		</cfLoop>
	<cfElse>
		<cfSet variables.lineType = "trace" />
		<cfSet variables.pid = session.trace[url.step].process[1] />
		<cfSet variables.textPages = ceiling(session.trace[url.step].process[2] / session.pageSize) />
		<cfSet variables.dataPages = ceiling(session.trace[url.step].process[3] / session.pageSize) />

		<!--- Place text first --->
		<cfLoop from="0" to="#variables.textPages-1#" index="i">
			<cfSet variables.placed = false />
			<!--- For the current page i, loop through physical M to find an open frame --->
			<cfLoop from="1" to="#session.numFrames#" index="j">
				<!--- If current frame is open and the info hasn't already been placed, fill the frame with current trace info --->
				<cfIf session.physicalM[j] EQ "" AND !variables.placed>
					<cfSet session.physicalM[j] = "P" & variables.pid & " Text Page " & i />
					<cfSet variables.placed = true />
				</cfIf>

				<!--- Update page table for current process --->

			</cfLoop>
		</cfLoop>

		<!--- Place data second --->
		<cfLoop from="0" to="#variables.dataPages-1#" index="i">
			<cfSet variables.placed = false />
			<!--- For the current page i, loop through physical M to find an open frame --->
			<cfLoop from="1" to="#session.numFrames#" index="j">
				<!--- If current frame is open and the info hasn't already been placed, fill the frame with current trace info --->
				<cfIf session.physicalM[j] EQ "" AND !variables.placed>
					<cfSet session.physicalM[j] = "P" & variables.pid & " Data Page " & i />
					<cfSet variables.placed = true />
				</cfIf>

				<!--- Update page table for current process --->

			</cfLoop>
		</cfLoop>

	</cfIf>

	<!--- Add history to be able to come back to this STEP --->
	<!--- Indicate that there is now history --->
	<cfSet session.history[#url.step#].exists = true />
	<!--- Save physical M --->
	<cfSet session.history[#url.step#].physicalM = session.physicalM />
	<!--- Save page tables --->

<cfElseIf url.step NEQ 0 AND session.history[#url.step#].exists>
	<!--- If history already exists, just load the history into the variables --->
	<!--- Load physical M --->
	<cfSet session.physicalM = session.history[#url.step#].physicalM />
	<!--- Load page tables --->

<cfElse>
	<cfSet variables.lineType = "none" />
</cfIf>

		