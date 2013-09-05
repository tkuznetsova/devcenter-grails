
<%@ page import="eshop.Order" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'order.label', default: 'Order')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-order" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
			<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link></li>
			</ul>
		</div>
		<div id="list-order" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="number" title="${message(code: 'order.number.label', default: 'Number')}" />
					
						<g:sortableColumn property="paymentAmount" title="${message(code: 'order.paymentAmount.label', default: 'Payment Amount')}" />
					
						<g:sortableColumn property="orderDate" title="${message(code: 'order.orderDate.label', default: 'Order Date')}" />
					
						<g:sortableColumn property="requiredDate" title="${message(code: 'order.requiredDate.label', default: 'Required Date')}" />
					
						<g:sortableColumn property="shippedDate" title="${message(code: 'order.shippedDate.label', default: 'Shipped Date')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'order.status.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${orderInstanceList}" status="i" var="orderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${orderInstance.id}">${fieldValue(bean: orderInstance, field: "id")}</g:link></td>
					
						<td>${fieldValue(bean: orderInstance, field: "paymentAmount")}</td>
					
						<td><g:formatDate date="${orderInstance.orderDate}" /></td>
					
						<td><g:formatDate date="${orderInstance.requiredDate}" /></td>
					
						<td><g:formatDate date="${orderInstance.shippedDate}" /></td>
					
						<td>
						<g:if test="${fieldValue(bean: orderInstance, field: "status") == '0'}">
							<g:message code="order.status.new.label" default="New"/>
						</g:if>
						<g:elseif test="${fieldValue(bean: orderInstance, field: "status") == '1'}">
							<g:message code="order.status.waiting.label" default="Waiting"/>
						</g:elseif>
						<g:elseif test="${fieldValue(bean: orderInstance, field: "status") == '2'}">
							<g:message code="order.status.paid.label" default="Paid"/>
						</g:elseif>
						<g:elseif test="${fieldValue(bean: orderInstance, field: "status") == '3'}">
							<g:message code="order.status.shipped.label" default="Shipped"/>
						</g:elseif>
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${orderInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
