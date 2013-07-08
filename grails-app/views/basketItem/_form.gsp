<%@ page import="eshop.BasketItem" %>



<div class="fieldcontain ${hasErrors(bean: basketItemInstance, field: 'order', 'error')} ">
	<label for="order">
		<g:message code="basketItem.order.label" default="Order" />
		
	</label>
	<g:select id="order" name="order.id" from="${eshop.Order.list()}" optionKey="id" value="${basketItemInstance?.order?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: basketItemInstance, field: 'good', 'error')} ">
	<label for="good">
		<g:message code="basketItem.good.label" default="Good" />
		
	</label>
	<g:select id="good" name="good.id" from="${eshop.Good.list()}" optionKey="id" value="${basketItemInstance?.good?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: basketItemInstance, field: 'cost', 'error')} ">
	<label for="cost">
		<g:message code="basketItem.cost.label" default="Cost" />
		
	</label>
	<g:field name="cost" value="${fieldValue(bean: basketItemInstance, field: 'cost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: basketItemInstance, field: 'user', 'error')} ">
	<label for="user">
		<g:message code="basketItem.user.label" default="User" />
		
	</label>
	<g:select id="user" name="user.id" from="${eshop.User.list()}" optionKey="id" value="${basketItemInstance?.user?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: basketItemInstance, field: 'quantity', 'error')} required">
	<label for="quantity">
		<g:message code="basketItem.quantity.label" default="Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="quantity" type="number" value="${basketItemInstance.quantity}" required=""/>
</div>

