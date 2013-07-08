
<%@ page import="eshop.Basket" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'basket.label', default: 'Basket')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-basket" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-basket" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<th><g:message code="basket.user.label" default="User" /></th>
						<th><g:message code="basket.purchase.label" default="Purchase" /></th>
					
						<th><g:message code="basket.itemCount.label" default="Item Count" /></th>
					
						<g:sortableColumn property="basketCost" title="${message(code: 'basket.basketCost.label', default: 'Basket Cost')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${basketInstanceList}" status="i" var="basketInstance">
				
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
						<td><g:link action="show" id="${basketInstance.id}">${basketInstance?.purchase?.good.name}</g:link></td>	
						<td>${fieldValue(bean: basketInstance, field: "itemCount")}</td>
						<td>${fieldValue(bean: basketInstance, field: "basketCost")}</td>		
					</tr>
				
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${basketInstanceTotal}" />
			</div>
				
		</div>
	</body>
</html>
