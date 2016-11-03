<cfSwitch expression="#sb.page#">
	<cfCase value="index">
		<cfParam name="form.name" default="World" />
	</cfCase>
</cfSwitch>