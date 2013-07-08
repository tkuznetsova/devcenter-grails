
<%@ page import="eshop.BasketItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'basketItem.label', default: 'BasketItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-basketItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-basketItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list basketItem">
			
				<g:if test="${basketItemInstance?.order}">
				<li class="fieldcontain">
					<span id="order-label" class="property-label"><g:message code="basketItem.order.label" default="Order" /></span>
					
						<span class="property-value" aria-labelledby="order-label"><g:link controller="order" action="show" id="${basketItemInstance?.order?.id}">${basketItemInstance?.order?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${basketItemInstance?.good}">
				<li class="fieldcontain">
					<span id="good-label" class="property-label"><g:message code="basketItem.good.label" default="Good" /></span>
					
						<span class="property-value" aria-labelledby="good-label"><g:link controller="good" action="show" id="${basketItemInstance?.good?.id}">${basketItemInstance?.good?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${basketItemInstance?.cost}">
				<li class="fieldcontain">
					<span id="cost-label" class="property-label"><g:message code="basketItem.cost.label" default="Cost" /></span>
					
						<span class="property-value" aria-labelledby="cost-label"><g:fieldValue bean="${basketItemInstance}" field="cost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${basketItemInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="basketItem.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${basketItemInstance?.user?.id}">${basketItemInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${basketItemInstance?.quantity}">
				<li class="fieldcontain">
					<span id="quantity-label" class="property-label"><g:message code="basketItem.quantity.label" default="Quantity" /></span>
					
						<span class="property-value" aria-labelledby="quantity-label"><g:fieldValue bean="${basketItemInstance}" field="quantity"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${basketItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${basketItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
