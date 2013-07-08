<html>
<head>
<title>Web Store - Homepage</title>
<meta name="layout" content="main" />
<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
</head>
<body>
	<div id="wrapper">
		<h1><g:message code="default.categoryList.label"/></h1>
		<div id="list-category">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn controller="category" property="name" title="Name" />
						<g:sortableColumn controller="category" property="description" title="Description" />
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
					<g:sortableColumn controller="good" property="name" title="Name" />
					<g:sortableColumn controller="good" property="description" title="Description" />
					<g:sortableColumn controller="good" property="category" title="Category" />
					<g:sortableColumn controller="good" property="price" title="Price" />
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
