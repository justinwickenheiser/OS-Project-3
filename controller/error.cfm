<cfIf sb.error EQ "CATCH" AND sb.errorToEmail NEQ "" AND NOT sb.isDevelopment>
	<cfMail to="#sb.errorToEmail#" from="#sb.errorFromEmail#" subject="An error in #sb.title# occurred" type="html">
		<cfIf isDefined("sb.cfCatch")>
			<h1>cfCatch</h1>
			<cfDump var="#sb.cfCatch#" />
		</cfIf>
		<h1>session</h1>
		<cfDump var="#session#" />
		<h1>url</h1>
		<cfDump var="#url#" />
		<cfIf isDefined("form.fieldnames")>
			<h1>form</h1>
			<cfDump var="#form#" />
		</cfIf>
		<h1>cgi</h1>
		<cfDump var="#cgi#" />
		<cfIf isDefined("sb")>
			<h1>sb</h1>
			<cfDump var="#sb#" />
		</cfIf>
	</cfMail>
</cfIf>