<html>
<head>
<title>Web Store - Homepage</title>
<meta name="layout" content="main" />
<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
</head>
<body>
	<div class="nav" role="navigation">			
		<ul>
			<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link>
		</li>
		<auth:ifLoggedIn>
		<li><g:link controller="good" action="list"><g:message code="default.showproduct.label"/></g:link>
		</li>
		<li><g:link controller="category" action="list"><g:message code="default.showcategory.label"/></g:link>
		</li>
		<li><g:link controller="authentication" action="list"><g:message code="default.showuser.label"/></g:link>
		</li>
		<li><g:link controller="order" action="list"><g:message code="default.showorder.label"/></g:link></li>
		</auth:ifLoggedIn>
		</ul>
	</div>
	<div id="wrapper">
		<h1><g:message code="default.categoryList.label"/></h1>
		<div id="list-category">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn controller="category" property="name" title="${message(code: 'index.name.label', default: 'Title')}" />
						<g:sortableColumn controller="category" property="description" title="${message(code: 'index.description.label', default: 'Description')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${categories}" var="category" status="i">
					<g:if test="${category.parent == null}" >
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link controller="category" action="show" id="${category.id}">${category.name}</g:link></td>
					
						<td>${category.description}</td>
					</tr>
					</g:if>
				</g:each>
				</tbody>
			</table>
		</div>
	
	</div>
	<br></br>
	<div id="wrapper">
		<div id="list-good">
		<h1><g:message code="default.productList.label"/></h1>
		<table>
			<thead>
				<tr>
					<g:sortableColumn controller="good" property="name" title="${message(code: 'index.name.label', default: 'Title')}" />
					<g:sortableColumn controller="good" property="description" title="${message(code: 'index.description.label', default: 'Description')}" />
					<g:sortableColumn controller="good" property="category" title="${message(code: 'index.category.label', default: 'Category')}" />
					<g:sortableColumn controller="good" property="price" title="${message(code: 'index.price.label', default: 'Price')}" />
				</tr>
			</thead>
			<tbody>
				<g:each in="${products}" var="product"> 
					<tr>
						<td><g:link controller="good" action="show"
								id="${product.id}">${product.name}</g:link>
						</td>
						<td>
							${product.manufacturer}
							${product.characteristics}
						</td>
						<td>
							${product.category.name}
						</td>
						<td>
							${product.price}
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		</div>
	</div>
</body>
</html>
