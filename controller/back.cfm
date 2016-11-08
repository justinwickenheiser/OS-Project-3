<!--- If not returning back the start --->
<cfIf url.step NEQ 0>
	<!--- Load physical M --->
	<cfSet session.physicalM = session.history[#url.step#].physicalM />
	<!--- Load page tables --->

<cfElse>
	<!--- If returing back to the start --->
	<!--- Reset physical M --->
	<cfLoop from="1" to="#session.numFrames#" index="i">
		<cfSet session.physicalM[i] = "" />
	</cfLoop>
	<!--- Reset page tables --->
	
</cfIf>