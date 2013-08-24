<%@ page import="authentication.AuthenticationUser" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-user" class="content scaffold-create" role="main">
			<h1><g:message code="authentication.registration.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			
			</g:if>
			<def var = userInstance value = AuthenticationUser.findByLogin(session.user.login)/>
			<g:hasErrors bean="${userInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>< g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			
			
				<auth:ifLoggedIn>
					<div class="message" role="status"><g:message code="authentication.loggedin.message"/><auth:user/></div>
				</auth:ifLoggedIn>
				
				<auth:ifUnconfirmed>
					<div class="message" role="status"><g:message code="authentication.waitingconfirm.message"/></div>
					<g:link action="reconfirm"><g:message code="authentication.confirmation.message"/></g:link>
					<div class="message" role="status"><g:message code="authentication.missed.message"/></div>
				</auth:ifUnconfirmed>
			
			<auth:ifNotLoggedIn>
				<g:if test="${flash.authenticationFailure}">
					<div class="message" role="status"><g:message code="authentication.failure.message"/><g:message code="authentication.failure.${flash.authenticationFailure.result}"/><br/></div>
				</g:if>
				<div id="wrapper">
					<div class="message" role="status"><g:message code="authentication.completeform.message"/></div>
				</div>
				
				<auth:form authAction="signup" 
					success="[controller:'main', action:'authenticate']"
					error="[controller:'authentication', action:'create']">
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>
					<div class="nav" role="navigation">
				    	<ul>
							<li><g:actionSubmit value="Sign up"/></li>
							<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link></li>
						</ul>
				    </div>
				</auth:form>
			</auth:ifNotLoggedIn>
		</div>
	</body>
</html>
