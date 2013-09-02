<%@ page import="eshop.Order" %>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'paymentAmount', 'error')} required">
	<label for="paymentAmount">
		<g:message code="order.paymentAmount.label" default="Payment Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="paymentAmount" type="number" value="${fieldValue(bean: orderInstance, field: 'paymentAmount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'orderDate', 'error')} required">
	<label for="orderDate">
		<g:message code="order.orderDate.label" default="Order Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="orderDate" precision="day"  value="${orderInstance?.orderDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'requiredDate', 'error')} required">
	<label for="requiredDate">
		<g:message code="order.requiredDate.label" default="Required Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requiredDate" precision="day"  value="${orderInstance?.requiredDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'shippedDate', 'error')} required">
	<label for="shippedDate">
		<g:message code="order.shippedDate.label" default="Shipped Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="shippedDate" precision="day"  value="${orderInstance?.shippedDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="order.status.label" default="Status" />
		<span class="required-indicator"></span>
	</label>
	<g:if test="${orderInstance?.status} == 0" >
		<g:message code="order.status.new.label" default="New" />
	</g:if>
	<g:else><g:message code="order.status.shipped.label" default="Shipped" /></g:else>
</div>

<div class="fieldcontain ${hasErrors(bean: orderInstance, field: 'authentication', 'error')} required">
	<label for="authentication">
		<g:message code="order.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="name" type="id" value="${orderInstance?.authentication?.name}" required=""/>
</div>

