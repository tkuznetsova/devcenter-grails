
<%@ page import="eshop.Good" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'good.label', default: 'Good')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-good" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<auth:ifLoggedIn>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</auth:ifLoggedIn>
			</ul>
		</div>
		<div id="show-good" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list good">
			
				<g:if test="${goodInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="good.name.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${goodInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goodInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="good.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${goodInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goodInstance?.stockAmount}">
				<li class="fieldcontain">
					<span id="stockAmount-label" class="property-label"><g:message code="good.stockAmount.label" default="Stock Amount" /></span>
					
						<span class="property-value" aria-labelledby="stockAmount-label"><g:fieldValue bean="${goodInstance}" field="stockAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goodInstance?.manufacturer}">
				<li class="fieldcontain">
					<span id="manufacturer-label" class="property-label"><g:message code="good.manufacturer.label" default="Manufacturer" /></span>
					
						<span class="property-value" aria-labelledby="manufacturer-label"><g:fieldValue bean="${goodInstance}" field="manufacturer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goodInstance?.characteristics}">
				<li class="fieldcontain">
					<span id="characteristics-label" class="property-label"><g:message code="good.characteristics.label" default="Characteristics" /></span>
					
						<span class="property-value" aria-labelledby="characteristics-label"><g:fieldValue bean="${goodInstance}" field="characteristics"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goodInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="good.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${goodInstance?.category?.id}">${goodInstance?.category?.name}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<auth:ifLoggedIn>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${goodInstance?.id}" />
					<g:link class="edit" action="edit" id="${goodInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
			</auth:ifLoggedIn>
		</div>
	</body>
</html>
