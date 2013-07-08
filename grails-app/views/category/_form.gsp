<%@ page import="eshop.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="category.name.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="20" required="" value="${categoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'parent', 'error')} ">
	<label for="parent">
		<g:message code="category.parent.label" default="Parent" />
		
	</label>
	<g:if test="${eshop.Category.list()}">
	<g:select id="parent" name="name" from="${eshop.Category.list()}" optionKey="id" optionValue="name" value="${categoryInstance?.parent?.id}" class="many-to-one" noSelection=""/>
	</g:if>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="good.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="20" value="${categoryInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'good', 'error')} ">
	<label for="good">
		<g:message code="category.good.label" default="Good" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.good?}" var="g">
    <li><g:link controller="good" action="show" id="${g.id}">${g?.name}</g:link></li>
</g:each>

</ul>

</div>

