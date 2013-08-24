<%@ page import="authentication.*" %>


<div class="fieldcontain required">
	<label for="login">
		<g:message code="authentication.userId.message" default="Login" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="login" required="" value="${flash.signupForm?.login?.encodeAsHTML()}"/>
	<g:hasErrors bean="${flash.signupFormErrors}" field="login"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/></g:hasErrors>
</div>

<div class="fieldcontain required">
	<label for="login">
		<g:message code="authentication.email.message" default="Email" />
		<span class="required-indicator">*</span>
	</label>
    <g:textField name="email" required="" value="${flash.signupForm?.email?.encodeAsHTML()}"/>
    <g:hasErrors bean="${flash.signupFormErrors}" field="email"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/></g:hasErrors>
</div>

<div class="fieldcontain required">
	<label for="password">
		<g:message code="authentication.password.message" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<input name="password" required="" value="" type="password"/>
	<g:hasErrors bean="${flash.signupFormErrors}" field="password"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="password"/></g:hasErrors>
</div>

<div class="fieldcontain required">
	<label for="confirmpassword">
		<g:message code="authentication.confirmpassword.message" default="Confirm Password" />
		<span class="required-indicator">*</span>
	</label>
	<input name="passwordConfirm" required="" value="" type="password"/>
	<g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm"><g:renderErrors bean="${flash.signupFormErrors}" as="list" field="passwordConfirm"/></g:hasErrors> 
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		
	</label>
	<g:textField name="name" maxlength="50" value="${userInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'creditcardID', 'error')} required">
	<label for="creditcardID">
		<g:message code="user.creditcardID.label" default="Creditcard ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="creditcardID" type="number" value="${userInstance.creditcardID}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')} required">
	<label for="phone">
		<g:message code="user.phone.label" default="Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phone" maxlength="11" required="" value="${userInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'addressline1', 'error')} required">
	<label for="addressline1">
		<g:message code="user.addressline1.label" default="Addressline1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="addressline1" maxlength="20" required="" value="${userInstance?.addressline1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'addressline2', 'error')} ">
	<label for="addressline2">
		<g:message code="user.addressline2.label" default="Addressline2" />
		
	</label>
	<g:textField name="addressline2" maxlength="20" value="${userInstance?.addressline2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="user.city.label" default="City" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="city" maxlength="20" required="" value="${userInstance?.city}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'stateregion', 'error')} ">
	<label for="stateregion">
		<g:message code="user.stateregion.label" default="Stateregion" />
		
	</label>
	<g:textField name="stateregion" maxlength="50" value="${userInstance?.stateregion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'postalcode', 'error')} required">
	<label for="postalcode">
		<g:message code="user.postalcode.label" default="Postalcode" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="postalcode" maxlength="10" required="" value="${userInstance?.postalcode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="user.country.label" default="Country" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="country" maxlength="10" required="" value="${userInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'creditlimit', 'error')} required">
	<label for="creditlimit">
		<g:message code="user.creditlimit.label" default="Creditlimit" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="creditlimit" type="double" value="${fieldValue(bean: userInstance, field: 'creditlimit')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'role', 'error')} ">
	<label for="role">
		<g:message code="user.role.label" default="Role" />
		
	</label>
	<g:textField name="role" maxlength="10" value="user"/>
</div>
