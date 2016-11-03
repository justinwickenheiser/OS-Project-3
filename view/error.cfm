<h1>An error has occured</h1>
<cfSwitch expression="#sb.error#">
	<cfCase value="NOPAGE">
		<p>The page you are trying to access was not found.</p>
	</cfCase>
	<cfCase value="NOCIRCUIT">
		<p>The circuit you are trying to access was not found.</p>
	</cfCase>
	<cfCase value="CATCH">
		<p>An internal system error has occured.</p>
		<cfIf sb.isDevelopment>
			<cfDump var="#sb.cfCatch#" />
		</cfIf>
	</cfCase>
	<cfCase value="CORE">
		<p>You're attempting to reference an internal switchboard instance as a circuit. Process aborted.</p>
	</cfCase>
	<cfDefaultCase>
		<p>An unknown error has occured.</p>
	</cfDefaultCase>
</cfSwitch>