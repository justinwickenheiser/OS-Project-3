<!--- IF YOUR SERVER SUPPORTS .htaccess FILES AND MOD REWRITE SET THIS TO "true". --->
<cfSet sb.useModRewrite = true />
<!--- DEVELOPMENT SERVER LIST. SB.ISDEVELOPMENT WILL BE SET IF CGI.HTTP_HOST IS WITHIN THE LIST. --->
<cfSet sb.developmentServers = "localhost" />
<!--- THIS VARIABLE IS GLOBAL TO ALL, BUT ONLY REFERENCED ON sb_template.cfm --->
<cfSet sb.title = "The Paging Tutor" />
<!--- AUTHENTICATION --->
<cfSet sb.sessionCheck = "" /> <!--- A VALUE SUCH AS "session.user" WOULD BE HERE --->
<cfSet sb.defaultSessionPath = "" /> <!--- WHERE SWITCHBOARD WILL REDIRECT TO IF SESSIONCHECK IS DEFINED AND THE USER ATTEMPTS TO ACCESS A PAGE THEY *DONT* HAVE TO BE LOGGED INTO --->
<cfSet sb.defaultNoSessionPath = "" /> <!--- WHERE SWITCHBOARD WILL REDIRECT TO IF SESSIONCHECK IS *NOT* DEFINED AND THE USER ATTEMPTS TO ACCESS A PAGE THEY HAVE TO BE LOGGED INTO --->
<cfSet sb.noSessionActions = "" /> <!--- CITCUIT/PAGES SUCH AS "index,examplecircuit-index,login_post" THAT A USER CAN ACCESS WITHOUT BEING LOGGED IN --->
<cfSet sb.anySessionActions = "" /> <!--- ANYONE CAN ACCESS THESE PAGES REGARDLESS OF SESSION AUTHENTICATION --->

<!--- Set up global variables --->
<cfParam name="session.kb" default="1024" />
<cfParam name="session.physicalMsize" default="" />
<cfParam name="session.pageSize" default="" />
<cfParam name="session.numFrames" default="" />

<!--- Assumed max number of processes in a file --->
<cfSet variables.maxRecords = 24 />