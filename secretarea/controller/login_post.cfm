<!--- Your own business logic should be on this page. For the purpose of this demo we will just hardcode in the username/password. --->
<cfIf lCase(form.username) EQ "switchboard" AND form.password EQ "demo">
	<cfSet session.user = structNew() />
	<cfSet session.user.username = lCase(form.username) />
<cfElse>
	<cfSet sb.useRedirect = "#sb.func.url("secretarea-login","error=login")#" />
</cfIf>