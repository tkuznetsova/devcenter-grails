
<%@ page import="eshop.Order" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'order.label', default: 'Order')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-order" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				
			</ul>
		</div>
		<div id="show-order" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list order">
			
				<g:if test="${orderInstance?.id}">
				<li class="fieldcontain">
					<span id="number-label" class="property-label"><g:message code="order.number.label" default="Number" /></span>
					
						<span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${orderInstance}" field="id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.paymentAmount}">
				<li class="fieldcontain">
					<span id="paymentAmount-label" class="property-label"><g:message code="order.paymentAmount.label" default="Payment Amount" /></span>
					
						<span class="property-value" aria-labelledby="paymentAmount-label"><g:fieldValue bean="${orderInstance}" field="paymentAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.orderDate}">
				<li class="fieldcontain">
					<span id="orderDate-label" class="property-label"><g:message code="order.orderDate.label" default="Order Date" /></span>
					
						<span class="property-value" aria-labelledby="orderDate-label"><g:formatDate date="${orderInstance?.orderDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.requiredDate}">
				<li class="fieldcontain">
					<span id="requiredDate-label" class="property-label"><g:message code="order.requiredDate.label" default="Required Date" /></span>
					
						<span class="property-value" aria-labelledby="requiredDate-label"><g:formatDate date="${orderInstance?.requiredDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.shippedDate}">
				<li class="fieldcontain">
					<span id="shippedDate-label" class="property-label"><g:message code="order.shippedDate.label" default="Shipped Date" /></span>
					
						<span class="property-value" aria-labelledby="shippedDate-label"><g:formatDate date="${orderInstance?.shippedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="order.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${orderInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="order.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${orderInstance?.user?.id}">${orderInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${orderInstance?.id}" />
					<g:link class="edit" action="edit" id="${orderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
