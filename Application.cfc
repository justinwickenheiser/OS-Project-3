<cfComponent output="false">
	<cfSet this.name = "#Replace(Replace(cgi.SCRIPT_NAME,"/","","all"),".","","all")#">
	<cfSet this.sessionManagement = true>
	<cfSet this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<cfFunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<!--- Don't let anyone access any cfm page except index.cfm within directly --->
		<cfIf Right(thePage,10) EQ "/index.cfm">
			<cfreturn true>
		</cfIf>
		<cfReturn false>
	</cfFunction>
</cfComponent>