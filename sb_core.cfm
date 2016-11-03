<cfSilent>
<!---
	Switchboard Framework 1.0.0
	May 24, 2011
	
	http://switchboard.riaforge.org/
	
	Daniel Slaughter
--->
<cfFunction name="sb_func_url" output="false" returntype="string">
	<cfArgument name="action" required="true" />
	<cfArgument name="args" required="false" default="" />
	<cfIf sb.useModrewrite AND arguments.args NEQ "">
		<cfReturn action & ".htm?" & args />
	<cfElseIf sb.useModrewrite>
		<cfReturn action & ".htm" />
	<cfElseIf arguments.args NEQ "">
		<cfReturn "index.cfm?action=" & action & "&" & args />
	<cfElse>
		<cfReturn "index.cfm?action=" & action />
	</cfIf>
</cfFunction>
<cfHeader name="X-Powered-By" value="Switchboard Framework 1.0.0 (http://www.switchboardframework.com/)" />
<cfSet sb = structNew() />
<!--- CLEAN UP THE URL FUNCTION SO IT CANNOT BE CALLED DIRECTLY --->
<cfSet sb.func.url = sb_func_url />
<cfSet structDelete(variables, "sb_func_url") />
<!--- SET UP DEFAULT VARIABLES. OVERRIDE IN SB_SETTINGS.CFM --->
<cfParam name="sb.useModRewrite" default="true" />
<cfParam name="sb.defaultPage" default="index" />
<cfParam name="sb.defaultCircuit" default="" />
<cfParam name="sb.title" default="" />
<cfParam name="sb.content" default="" />
<cfParam name="sb.sessionCheck" default="" />
<cfParam name="sb.defaultSessionPath" default="" />
<cfParam name="sb.defaultNoSessionPath" default="" />
<cfParam name="sb.noSessionActions" default="" />
<cfParam name="sb.anySessionActions" default="" />
<cfParam name="sb.useController" default="true" />
<cfParam name="sb.useModel" default="true" />
<cfParam name="sb.useView" default="true" />
<cfParam name="sb.useRedirect" default="" />
<cfParam name="sb.useTemplate"default="true" />
<cfParam name="sb.useForm" default="" />
<cfParam name="sb.errorToEmail" default="" />
<cfParam name="sb.errorFromEmail" default="error@#cgi.http_host#" />
<cfParam name="sb.errorPage" default="error" />
<cfParam name="sb.error" default="" />
<cfParam name="sb.isLoggedIn" default="false" />
<cfParam name="sb.isHomepage" default="false" />
<cfParam name="sb.isDevelopment" default="false" />
<cfParam name="sb.developmentServers" default="" />
<cfTry>
	<!--- INCLUDE ROOT'S SETTINGS FILE --->
	<cfInclude template="sb_settings.cfm" />
	<!--- SET UP THE PATH'S ARRAY --->
	<cfParam name="url.sb_path" default="#sb.defaultPage#" />
	<cfParam name="sb.url" default="#url.sb_path#" />
	<cfParam name="url.action" default="#sb.defaultPage#" />
	<cfSet sb.url = lCase(sb.url) />
	<cfSet url.action = lCase(url.action) />
	<cfIf sb.useModrewrite>
		<!--- MOD-REWRITE (.htaccess) --->
		<cfSet sb.routing = listToArray(sb.url,"-")>
		<cfSet sb.path = sb.url />
	<cfElse>
		<!--- NON MOD-REWRITE (.htaccess) --->
		<cfSet sb.routing = listToArray(url.action,"-")>
		<cfSet sb.path = url.action />
		<cfSet sb.url = url.action />
	</cfIf>
	<!--- SET THE NUMBER OF CURCUITS ( -1 FOR THE PAGE ) --->
	<cfSet sb.circuitCount = arrayLen(sb.routing)-1 />
	<cfIf sb.circuitCount EQ 0>
		<cfSet sb.circuit = sb.defaultCircuit />
		<cfSet sb.page = sb.routing[1] />
	<cfElse>
		<cfSet sb.path = listDeleteAt(sb.path,listLen(sb.path,"-"),"-") />
		<cfSet sb.circuit = sb.defaultCircuit />
		<cfLoop list="#sb.path#" index="circuit" delimiters="-">
			<cfSet sb.circuit = sb.circuit & circuit & "/" />
		</cfLoop>
		<cfSet sb.page = sb.routing[sb.circuitCount+1] />
	</cfIf>
	<!--- CHECK TO MAKE SURE URL IS NOT CALLING A CIRCUIT WHICH IS REALLY A NEW SWITCHBOARD INSTANCE --->
	<cfSet sb.remainingCircuit = "" />
	<cfLoop list="#sb.circuit#" delimiters="/" index="currentSpot">
		<cfSet sb.remainingCircuit = listAppend(sb.remainingCircuit,currentSpot,"/") & "/" />
		<cfIf fileExists(expandPath("#sb.remainingCircuit#sb_core.cfm"))>
			<cfSet sb.error = "CORE" />
		</cfIf>
	</cfLoop>
	<cfIf sb.error NEQ "CORE">
		<cfSet sb.includedFiles = 0 />
		<!--- INCLUDE SETTINGS, IF NOT ROOT --->
		<cfSet sb.remainingCircuit = "" />
		<cfLoop list="#sb.circuit#" delimiters="/" index="currentSpot">
			<cfSet sb.remainingCircuit = listAppend(sb.remainingCircuit,currentSpot,"/") & "/"  />
			<cfIf sb.remainingCircuit NEQ "" AND fileExists(expandPath("#sb.remainingCircuit#sb_settings.cfm"))>				
				<cfInclude template="#sb.remainingCircuit#sb_settings.cfm" />
			</cfIf>
		</cfLoop>
		<!--- DETERMINE HOMEPAGE --->
		<cfIf sb.circuit EQ sb.defaultCircuit AND sb.page EQ sb.defaultPage>
			<cfSet sb.isHomepage = true />
		</cfIf>
		<!--- DETERMINE DEVELOPMENT --->
		<cfIf listFind(sb.developmentServers,cgi.http_host)>
			<cfSet sb.isDevelopment = true />
		</cfIf>
		<!--- DETERMINE LOGGEDIN --->
		<cfIf sb.sessionCheck NEQ "">
			<cfSet sb.isLoggedIn = isDefined(sb.sessionCheck) />
		</cfIf>
		<!--- AUTHENTICATION --->
		<cfIf sb.anySessionActions NEQ "" AND listFind(sb.anySessionActions,sb.url)>
		<cfElseIf sb.sessionCheck NEQ "" AND NOT listFind(sb.noSessionActions,sb.url) AND NOT isDefined(sb.sessionCheck)>
			<cfSet urlList = "" />
			<cfSet urlDontList = "cfid,cftoken,sb_path" />
			<cfIf sb.useModrewrite>
				<cfSet urlDontList = listAppend(urlDontList,"action") />
			</cfIf>
			<cfLoop list="#LCase(StructKeyList(url))#" index="urlItem">
				<cfIf NOT listFind(urlDontList,urlItem)>
					<cfSet urlList = ListAppend(urlList, "#urlItem#=#url['#urlItem#']#","&") />
				</cfIf>
			</cfLoop>
			<cfSet urlList = Replace(urlList,"&","%26","all") />
			<cfIf cgi.request_method EQ "POST">
				<cfLocation url="#sb.defaultNoSessionPath#" addtoken="false" />
			<cfElseIf sb.useModrewrite>
				<cfLocation url="#sb.defaultNoSessionPath#&goto=#sb.url#.htm%3F#urlList#" addtoken="false" />
			<cfElse>
				<cfLocation url="#sb.defaultNoSessionPath#&goto=index.cfm%3F#urlList#" addtoken="false" />
			</cfIf>
			<cfAbort />
		<cfElseif sb.sessionCheck NEQ "" AND listFind(sb.noSessionActions,sb.url) AND isDefined(sb.sessionCheck)>
			<cfLocation url="#sb.defaultSessionPath#" addtoken="false" />
            <cfAbort />
		</cfIf>
		<!--- INCLUDE SWITCH --->
		<cfIf fileExists(expandPath("#sb.circuit#sb_switch.cfm"))>
			<cfInclude template="#sb.circuit#sb_switch.cfm" />
		</cfIf>
		<!--- USE FORM LOGIC --->
		<cfIf cgi.request_method NEQ "POST" AND sb.useForm NEQ "">
			<cfLocation url="#sb.useForm#" addtoken="false" />
			<cfAbort />
		</cfIf>
        <cfSaveContent variable="sb.content">
            <!--- INCLUDE CONTROLLER FILE --->
            <cfIf fileExists(expandPath("#sb.circuit#controller/#sb.page#.cfm")) AND sb.useController EQ true>
                <cfInclude template="#sb.circuit#controller/#sb.page#.cfm">
                <cfSet sb.includedFiles = sb.includedFiles + 1 />
            </cfIf>
            <!--- INCLUDE MODEL FILE --->
            <cfIf fileExists(expandPath("#sb.circuit#model/#sb.page#.cfm")) AND sb.useModel EQ true>
                <cfInclude template="#sb.circuit#model/#sb.page#.cfm">
                <cfSet sb.includedFiles = sb.includedFiles + 1 />
            </cfIf>
        </cfSaveContent>
        <cfSaveContent variable="sb.content">
            <cfIf sb.isDevelopment AND len(trim(sb.content)) GT 0>
                <div class="sb_development">
                    <strong>The following information is only displayed on the development server</strong>
                    <hr />
                    <cfOutput>#sb.content#</cfOutput>
                    <hr />
                </div>
            </cfIf>
            <!--- INCLUDE VIEW FILE --->
            <cfIf fileExists(expandPath("#sb.circuit#view/#sb.page#.cfm")) AND sb.useView EQ true>
                <cfInclude template="#sb.circuit#view/#sb.page#.cfm" />
                <cfSet sb.includedFiles = sb.includedFiles + 1 />
            </cfIf>
        </cfSaveContent>
		<cfSet sb.remainingCircuit = sb.circuit />
		<cfIf sb.includedFiles EQ 0>
			<!--- NO CASE IN SWITCH FOR sb.PAGE AND NO FILES FOR PAGE --->
			<cfIf directoryExists(expandPath(sb.circuit))>
				<!--- CIRCUIT EXISTS, PAGE DOESN'T --->
				<cfSet sb.error = "NOPAGE" />
			<cfElse>
				<!--- CIRCUIT DOESN'T EXIST --->
				<cfSet sb.error = "NOCIRCUIT" />
			</cfIf>
		<cfElse>
			<cfSet sb.content = trim(sb.content) />
		</cfIf>
		<!--- REDIRECT LOGIC --->
		<cfIf sb.useRedirect NEQ "">
			<cfLocation url="#sb.useRedirect#" addtoken="false" />
			<cfAbort />
		</cfIf>
		<!--- LOOP THROUGH CIRCUITS BACKWARDS TO INCLUDE TEMPLATES --->
		<cfIf sb.useTemplate>
			<cfLoop from="#sb.circuitCount#" to="1" step="-1" index="currentSpot">
				<cfIf fileExists(expandPath("#sb.remainingCircuit#sb_template.cfm"))>
					<cfSaveContent variable="sb.newContent">
						<cfInclude template="#sb.remainingCircuit#sb_template.cfm" />
					</cfSaveContent>
					<cfSet sb.content = trim(sb.newContent)>
				</cfIf>
				<cfSet sb.remainingCircuit = listDeleteAt(sb.remainingCircuit, currentSpot, "/") & "/" />
			</cfLoop>
		</cfIf>
		<!--- INCLUDE HOME TEMPLATE --->	
		<cfIf sb.useTemplate>
			<cfSaveContent variable="sb.newContent">
				<cfInclude template="sb_template.cfm">
			</cfSaveContent>
			<cfSet sb.content = trim(sb.newContent)>
		</cfIf>
	</cfIf>
	<cfCatch>
		<cfSet sb.error = "CATCH" />
		<cfSet sb.cfCatch = cfCatch />
	</cfCatch>
</cfTry>
<!--- HANDLE ERRRORS IF THEY OCCUR --->
<cfIf sb.error NEQ "">
	<cfSet sb.includedErrorFiles = 0 />
	<cfTry>
		<cfIf fileExists(expandPath("#sb.circuit#controller/#sb.errorPage#.cfm"))>
			<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
			<cfInclude template="#sb.circuit#controller/#sb.errorPage#.cfm">
		<cfElseIf fileExists(expandPath("controller/#sb.errorPage#.cfm"))>
			<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
			<cfInclude template="controller/#sb.errorPage#.cfm">
		</cfIf>
		<cfIf fileExists(expandPath("#sb.circuit#model/error.cfm"))>
			<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
			<cfInclude template="#sb.circuit#model/#sb.errorPage#.cfm">
		<cfElseIf fileExists(expandPath("model/#sb.errorPage#.cfm"))>
			<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
			<cfInclude template="model/#sb.errorPage#.cfm">
		</cfIf>
		<cfSaveContent variable="sb.content">
			<cfIf fileExists(expandPath("#sb.circuit#view/error.cfm"))>
				<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
				<cfInclude template="#sb.circuit#view/#sb.errorPage#.cfm">
			<cfElseIf fileExists(expandPath("view/#sb.errorPage#.cfm"))>
				<cfSet sb.includedErrorFiles = sb.includedErrorFiles + 1 />
				<cfInclude template="view/#sb.errorPage#.cfm">
			</cfIf>
		</cfSaveContent>
		<cfCatch>
			<!--- IGNORED --->
			<cfSet sb.includedErrorFiles = 0 />
		</cfCatch>
	</cfTry>
	<cfIf NOT sb.includedErrorFiles>
		<cfSet sb.content = "An error occured" />
	</cfIf>
	<cfTry>
		<!--- LOOP THROUGH CIRCUITS BACKWARDS TO INCLUDE TEMPLATES --->
		<cfIf sb.useTemplate>
			<cfSet sb.remainingCircuit = sb.circuit />
			<cfLoop from="#sb.circuitCount#" to="1" step="-1" index="currentSpot">
				<cfIf fileExists(expandPath("#sb.remainingCircuit#sb_template.cfm"))>
					<cfSaveContent variable="sb.newContent">
						<cfInclude template="#sb.remainingCircuit#sb_template.cfm" />
					</cfSaveContent>
					<cfSet sb.content = trim(sb.newContent)>
				</cfIf>
				<cfSet sb.remainingCircuit = listDeleteAt(sb.remainingCircuit, currentSpot, "/") & "/" />
			</cfLoop>
		</cfIf>
		<!--- INCLUDE HOME TEMPLATE --->
		<cfIf sb.useTemplate>
			<cfSaveContent variable="sb.newContent">
				<cfInclude template="sb_template.cfm">
			</cfSaveContent>
			<cfSet sb.content = trim(sb.newContent)>
		</cfIf>
		<cfCatch>
			<!--- IGNORED --->
		</cfCatch>
	</cfTry>
</cfIf>
</cfSilent><cfOutput>#sb.content#</cfOutput>