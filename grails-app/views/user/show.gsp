
<%@ page import="eshop.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>				
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="user.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${userInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.creditcardID}">
				<li class="fieldcontain">
					<span id="creditcardID-label" class="property-label"><g:message code="user.creditcardID.label" default="Creditcard ID" /></span>
					
						<span class="property-value" aria-labelledby="creditcardID-label"><g:fieldValue bean="${userInstance}" field="creditcardID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="user.phone.label" default="Phone" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${userInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.addressline1}">
				<li class="fieldcontain">
					<span id="addressline1-label" class="property-label"><g:message code="user.addressline1.label" default="Addressline1" /></span>
					
						<span class="property-value" aria-labelledby="addressline1-label"><g:fieldValue bean="${userInstance}" field="addressline1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.addressline2}">
				<li class="fieldcontain">
					<span id="addressline2-label" class="property-label"><g:message code="user.addressline2.label" default="Addressline2" /></span>
					
						<span class="property-value" aria-labelledby="addressline2-label"><g:fieldValue bean="${userInstance}" field="addressline2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="user.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${userInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.stateregion}">
				<li class="fieldcontain">
					<span id="stateregion-label" class="property-label"><g:message code="user.stateregion.label" default="Stateregion" /></span>
					
						<span class="property-value" aria-labelledby="stateregion-label"><g:fieldValue bean="${userInstance}" field="stateregion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.postalcode}">
				<li class="fieldcontain">
					<span id="postalcode-label" class="property-label"><g:message code="user.postalcode.label" default="Postalcode" /></span>
					
						<span class="property-value" aria-labelledby="postalcode-label"><g:fieldValue bean="${userInstance}" field="postalcode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.country}">
				<li class="fieldcontain">
					<span id="country-label" class="property-label"><g:message code="user.country.label" default="Country" /></span>
					
						<span class="property-value" aria-labelledby="country-label"><g:fieldValue bean="${userInstance}" field="country"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.creditlimit}">
				<li class="fieldcontain">
					<span id="creditlimit-label" class="property-label"><g:message code="user.creditlimit.label" default="Creditlimit" /></span>
					
						<span class="property-value" aria-labelledby="creditlimit-label"><g:fieldValue bean="${userInstance}" field="creditlimit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.role}">
				<li class="fieldcontain">
					<span id="role-label" class="property-label"><g:message code="user.role.label" default="Role" /></span>
					
						<span class="property-value" aria-labelledby="role-label"><g:fieldValue bean="${userInstance}" field="role"/></span>
					
				</li>
				</g:if>
			
			
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${userInstance?.id}" />
					<g:link class="edit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
