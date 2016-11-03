<cfSwitch expression="#sb.page#">
	<cfCase value="login_post">
		<cfSet sb.useRedirect = "#sb.func.url("secretarea-index")#" />
	</cfCase>
	<cfCase value="logout">
		<cfSet sb.useRedirect = "#sb.func.url("secretarea-login","error=logout")#" />
	</cfCase>
</cfSwitch>