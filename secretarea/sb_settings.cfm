<!--- AUTHENTICATION --->
<cfSet sb.sessionCheck = "session.user" /> <!--- A VALUE SUCH AS "session.user" WOULD BE HERE --->
<cfSet sb.defaultSessionPath = "#sb.func.url("secretarea-index")#" /> <!--- WHERE SWITCHBOARD WILL REDIRECT TO IF SESSIONCHECK IS DEFINED AND THE USER ATTEMPTS TO ACCESS A PAGE THEY *DONT* HAVE TO BE LOGGED INTO --->
<cfSet sb.defaultNoSessionPath = "#sb.func.url("secretarea-login","error=session")#" /> <!--- WHERE SWITCHBOARD WILL REDIRECT TO IF SESSIONCHECK IS *NOT* DEFINED AND THE USER ATTEMPTS TO ACCESS A PAGE THEY HAVE TO BE LOGGED INTO --->
<cfSet sb.noSessionActions = "secretarea-login,secretarea-login_post" /> <!--- CITCUIT/PAGES SUCH AS "index,examplecircuit-index,login_post" THAT A USER CAN ACCESS WITHOUT BEING LOGGED IN --->
<cfSet sb.anySessionActions = "secretarea-anysession" /> <!--- ANYONE CAN ACCESS THESE PAGES REGARDLESS OF SESSION AUTHENTICATION --->
<cfSet header = "hello" />