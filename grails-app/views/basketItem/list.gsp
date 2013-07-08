
<%@ page import="eshop.BasketItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'basketItem.label', default: 'BasketItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-basketItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-basketItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="basketItem.order.label" default="Order" /></th>
					
						<th><g:message code="basketItem.good.label" default="Good" /></th>
					
						<g:sortableColumn property="cost" title="${message(code: 'basketItem.cost.label', default: 'Cost')}" />
					
						<th><g:message code="basketItem.user.label" default="User" /></th>
					
						<g:sortableColumn property="quantity" title="${message(code: 'basketItem.quantity.label', default: 'Quantity')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${basketItemInstanceList}" status="i" var="basketItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${basketItemInstance.id}">${fieldValue(bean: basketItemInstance, field: "order")}</g:link></td>
					
						<td>${fieldValue(bean: basketItemInstance, field: "good")}</td>
					
						<td>${fieldValue(bean: basketItemInstance, field: "cost")}</td>
					
						<td>${fieldValue(bean: basketItemInstance, field: "user")}</td>
					
						<td>${fieldValue(bean: basketItemInstance, field: "quantity")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${basketItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
