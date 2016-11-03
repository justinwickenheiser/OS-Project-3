<cfOutput>#sb.content#</cfOutput>
<cfIf sb.isLoggedIn>
	<p>
		<a href="<cfOutput>#sb.func.url("secretarea-logout")#</cfOutput>">Click here to logout</a>
	</p>
</cfIf>