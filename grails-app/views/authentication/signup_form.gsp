<!--%@ page contentType="text/html;charset=UTF-8" %-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
<meta name="layout" content="main"/>
<title>Registration</title>
</head>
<body>
  <div class="body">
	<auth:ifLoggedIn>
		You are currently logged in as: <auth:user/>
		<h2>Log out</h2>
		<auth:form authAction="logout" success="[controller:'authentication', action:'index']" error="[controller:'authentication', action:'index']">
		    <g:actionSubmit value="Log out"/> 
		</auth:form>
	</auth:ifLoggedIn>
	
	<auth:ifUnconfirmed>
		<g:message code="authentication.waitingconfirm.message"/>
		<g:link action="reconfirm"><g:message code="authentication.confirmation.message"/></g:link><g:message code="authentication.missed.message"/>
	</auth:ifUnconfirmed>
	
	<auth:ifNotLoggedIn>
	<g:if test="${flash.authenticationFailure}">
		<g:message code="authentication.failure.message"/><g:message code="authentication.failure.${flash.authenticationFailure.result}"/><br/>
	</g:if>
	
	<div id="wrapper">
		<h1><g:message code="authentication.registration.label"/></h1>
		<g:message code="authentication.completeform.message"/>
	</div>
	<div id="authSignup">
		<auth:form authAction="signup" 
			success="[controller:'main', action:'authenticate']"
			error="[controller:'authentication', action:'signup_form']">
		    <g:message code="authentication.userId.message"/><g:textField name="login" value="${flash.signupForm?.login?.encodeAsHTML()}"/>
			<g:hasErrors bean="${flash.signupFormErrors}" field="login">
				<g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/>
			</g:hasErrors><br/>
		    Email: <g:textField name="email" value="${flash.signupForm?.email?.encodeAsHTML()}"/><br/>
			<g:hasErrors bean="${flash.signupFormErrors}" field="email"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/></g:hasErrors>
		    <g:message code="authentication.password.message"/><input name="password" value="" type="password"/><br/>
			<g:hasErrors bean="${flash.signupFormErrors}" field="password"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="password"/></g:hasErrors>
		    <g:message code="authentication.confirmpassword.message"/><input name="passwordConfirm" value="" type="password"/><br/>
			<g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="passwordConfirm"/></g:hasErrors>
		    <g:actionSubmit value="Sign up"/>
		    
		</auth:form>
	</div>
	</auth:ifNotLoggedIn>
  </div>
</body>
</html>