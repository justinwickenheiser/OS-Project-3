<!--- If not returning back the start --->
<cfIf url.step NEQ 0>
	<!--- Load physical M --->
	<cfSet session.physicalM = session.history[#url.step#].physicalM />
	<!--- Load page tables --->
	<cfSet session.pageTables = session.history[#url.step#].pageTables />
<cfElse>
	<!--- If returing back to the start --->
	<!--- Reset physical M --->
	<cfLoop from="1" to="#session.numFrames#" index="i">
		<cfSet session.physicalM[i] = "" />
	</cfLoop>
	<!--- Reset page tables --->
	<cfLoop from="1" to="#variables.maxRecords#" index="i">
		<cfSet session.pageTables[i] = StructNew() />
		<cfSet session.pageTables[i].pid = i-1 />
		<cfSet session.pageTables[i].exists = false />
		<cfSet session.pageTables[i].segType = ArrayNew(1) />
		<cfSet session.pageTables[i].page = ArrayNew(1) />
		<cfSet session.pageTables[i].frame = ArrayNew(1) />
	</cfLoop>
</cfIf>