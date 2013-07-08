<%@ page import="eshop.Good" %>



<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'name', 'error')} required">
	<label for="title">
		<g:message code="good.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="20" required="" value="${goodInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="good.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" type="double" value="${fieldValue(bean: goodInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'stockAmount', 'error')} required">
	<label for="stockAmount">
		<g:message code="good.stockAmount.label" default="Stock Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="stockAmount" type="number" value="${goodInstance.stockAmount}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'manufacturer', 'error')} ">
	<label for="manufacturer">
		<g:message code="good.manufacturer.label" default="Manufacturer" />
		
	</label>
	<g:textField name="manufacturer" maxlength="20" value="${goodInstance?.manufacturer}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'characteristics', 'error')} ">
	<label for="characteristics">
		<g:message code="good.characteristics.label" default="Characteristics" />
		
	</label>
	<g:textField name="characteristics" maxlength="20" value="${goodInstance?.characteristics}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: goodInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="good.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="name" name="category.id" from="${eshop.Category.list()}" optionKey="id" optionValue="name" required="" value="${goodInstance?.category?.name}" class="many-to-one"/>
</div>

