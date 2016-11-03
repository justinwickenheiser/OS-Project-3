<p>
	Hello <cfOutput>#form.name#</cfOutput>!
</p>
<form method="post" action="<cfOutput>#sb.func.url("index")#</cfOutput>">
	<p>
		<input type="text" name="name" size="35" maxlength="255" />
		<input type="submit" value="Change Name" />
	</p>
</form>
<p>
	<a href="<cfOutput>#sb.func.url("secretarea-login")#</cfOutput>">Click here to try out the Secret Area login authentication.</a>
</p>