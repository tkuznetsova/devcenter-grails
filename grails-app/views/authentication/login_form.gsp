<!--%@ page contentType="text/html;charset=UTF-8" %-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
<meta name="layout" content="main"/>
<title>Log in</title>
</head>
<body>
    <div class="body">
	
	<auth:ifUnconfirmed>
		<g:message code="authentication.waitingconfirm.message"/>
		<g:link action="reconfirm"><g:message code="authentication.confirmation.message"/></g:link><g:message code="authentication.missed.message"/>
	</auth:ifUnconfirmed>
	
	<auth:ifNotLoggedIn>
	<g:if test="${flash.authenticationFailure}">
		<g:message code="authentication.failure.message"/><g:message code="authentication.failure.${flash.authenticationFailure.result}"/><br/>
	</g:if>

	<div id="wrapper">
		<h1><g:message code="authentication.login.label"/></h1>
		<p><g:message code="authentication.pleaseLogin.message"/> 
			<br><g:message code="authentication.havenotaccount.message"/>
			<g:link controller="authentication" action="signup_form"><g:message code="authentication.now.message"/></g:link>
			<div id="line"></div>
		</p>
	</div>	
	<div id="authLogin">
		<auth:form authAction="login" success="[controller:'main', action:'index']" 
					error="[controller:'authentication', action:'login']">
		    <g:message code="authentication.userId.message"/><g:textField name="login" value="${flash.loginForm?.login?.encodeAsHTML()}"/><br/>
			<g:hasErrors bean="${flash.loginFormErrors}" field="login"><g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/></g:hasErrors>
		   <g:message code="authentication.password.message"/><input name="password" value="" type="password"/><br/><br>
			<g:hasErrors bean="${flash.loginFormErrors}" field="password"><g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/></g:hasErrors>
		    <g:actionSubmit value="Log in"/> 
		</auth:form>
	</div>
	</auth:ifNotLoggedIn>  
	</div>  		
</body>
</html>