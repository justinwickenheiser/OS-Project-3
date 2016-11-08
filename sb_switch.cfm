<cfSwitch expression="#sb.page#">
	<cfCase value="index_post">
		<cfSet sb.useRedirect = "simulation.htm" />
		<cfSet sb.useForm = "index.htm" />
	</cfCase>
	<cfCase value="simulation">
		<cfParam name="url.step" default="0" />
	</cfCase>
	<cfCase value="next">
		<cfParam name="url.step" default="0" />
		<cfSet sb.useRedirect = "simulation.htm?step=#url.step#" />
	</cfCase>
	<cfCase value="back">
		<cfParam name="url.step" default="0" />
		<cfSet sb.useRedirect = "simulation.htm?step=#url.step#" />
	</cfCase>
</cfSwitch>