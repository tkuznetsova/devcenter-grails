
<%@ page import="eshop.Good" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'good.label', default: 'Good')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-good" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<auth:ifLoggedIn>
		<div class="nav" role="navigation">
			<ul>
				
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		</auth:ifLoggedIn>
		<div id="list-good" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<th><g:message code="" default="" /></th>
						<g:sortableColumn property="name" title="${message(code: 'good.name.label', default: 'Title')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'good.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="stockAmount" title="${message(code: 'good.stockAmount.label', default: 'Stock Amount')}" />
					
						<g:sortableColumn property="manufacturer" title="${message(code: 'good.manufacturer.label', default: 'Manufacturer')}" />
					
						<g:sortableColumn property="characteristics" title="${message(code: 'good.characteristics.label', default: 'Characteristics')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${goodInstanceList}" status="i" var="goodInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:remoteLink controller="basketItem" action="addToBasket"
								id="${goodInstance.id}">Add to basket
							</g:remoteLink>
						</td>
					
						<td><g:link action="show" id="${goodInstance.id}">${fieldValue(bean: goodInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: goodInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: goodInstance, field: "stockAmount")}</td>
					
						<td>${fieldValue(bean: goodInstance, field: "manufacturer")}</td>
					
						<td>${fieldValue(bean: goodInstance, field: "characteristics")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${goodInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
