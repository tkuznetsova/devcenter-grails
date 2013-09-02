
<%@ page import="eshop.Basket" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
		<g:set var="entityName" value="${message(code: 'basket.label', default: 'Basket')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-basket" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
			<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link></li>
			<li><g:link controller="basket" action="order">
					${message(code: 'basket.order.label', default: 'Check out order')}
				</g:link></li>
			
			</ul>
		</div>
		<div id="show-basket" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
				<tr>
					<g:sortableColumn property="id" title="${message(code: 'basket.id.label', default: 'ID')}" />
					<g:sortableColumn property="name" title="${message(code: 'basket.name.label', default: 'Name')}" />
					<g:sortableColumn property="manufacturer" title="${message(code: 'basket.manufacturer.label', default: 'Manufacturer')}" />
					<g:sortableColumn property="characteristics" title="${message(code: 'basket.characteristics.label', default: 'Characteristics')}" />
					<g:sortableColumn property="price" title="${message(code: 'basket.price.label', default: 'Price')}" />
					<g:sortableColumn property="quantity" title="${message(code: 'basket.quantity.label', default: 'Quantity')}" />
					<g:sortableColumn property="cost" title="${message(code: 'basket.cost.label', default: 'Total Price')}" />
					<th><g:message code="" default="" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${basketInstance.purchase}" var="purchase">
					<tr>
						<td>
							${purchase.id}
						</td>
						<td><g:link controller="good" action="show"
								id="${purchase.good.id}">
								${purchase.good.name}
							</g:link></td>
						<td>
							${purchase.good.manufacturer}
						</td>
						<td>
							${purchase.good.characteristics}
						</td>
						<td>
							${purchase.good.price}
						</td>
						<td>
						<g:remoteLink controller="basketItem" action="removeOne"
								id="${purchase.id}">[-]
						</g:remoteLink>
							${purchase.quantity}
							
						<g:remoteLink controller="basketItem" action="addOne"
								id="${purchase.id}">[+]
						</g:remoteLink>
						</td>
						<td>
							${purchase.cost}
						</td>
						<td><g:remoteLink controller="basket" action="removePurchase"
								id="${purchase.id}">${message(code: 'basket.removeProduct.label', default: 'Remove product')}
							</g:remoteLink>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		
	</div>

		<g:form>
			<fieldset class="buttons">
				<g:hiddenField name="id" value="${basketInstance?.id}" />
				
			</fieldset>
		</g:form>
		
		<p>
			<strong>${message(code: 'basket.totalItems.label', default: 'Total items:')}</strong>
			${basketInstance.itemCount}
			| <strong>${message(code: 'basket.totalPrice.label', default: 'Total Price:')}</strong>
			${basketInstance.basketCost}
			${message(code: 'basket.euros.label', default: 'Euros')}

		</p>

	</body>
</html>
