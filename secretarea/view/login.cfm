<p class="alert">
	To sample this demo use the following...<br />
	username: switchboard<br />
	password: demo
</p>
<h2>Login Demo</h2>
<cfIf isDefined("url.error")>
	<p class="alert">
		<cfIf url.error EQ "login">
			Your username and password combination are incorrect.
		<cfElseIf url.error EQ "session">
			Your session has expired. Please login to continue to the page you requested.
		<cfElseIf url.error EQ "logout">
			You have been successfully logged out.
		<cfElse>
			An unknown login error occured.
		</cfIf>
	</p>
</cfIf>
<form method="post" action="<cfOutput>#sb.func.url("secretarea-login_post")#</cfOutput>">
	<p>
		<label for="username">
			Username:<br />
			<input type="text" name="username" id="username" size="35" maxlength="255" />
		</label>
	</p>
	<p>
		<label for="password">
			Password:<br />
			<input type="password" name="password" id="password" size="35" maxlength="255" />
		</label>
	</p>
	<p>
		<input type="submit" value="Login" />
	</p>
</form>