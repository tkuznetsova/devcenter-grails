<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails" /></title>
		<link rel="stylesheet" href="${resource(dir:'css',file:'index.css')}" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>
		<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'shop_logo.png')}" alt="Grails"/></a>
		
		
			<div id="login">
				<auth:ifNotLoggedIn>
				<p>
					<g:link controller="authentication" action="login_form"><g:message code="default.clickhere.label"/>
					<g:message code="default.login.label"/></g:link>
					<g:message code="default.or.label"/>
					<g:link controller="authentication" action="signup_form"><g:message code="default.register.label"/></g:link>
				</p>
				</auth:ifNotLoggedIn>
			</div>
			<auth:ifNotLoggedIn>
				
			<div id="login">
			<div id="bag">	
				<p>
				<br><g:link controller="authentication" action="login_form"><g:message code="default.login.label"/>,</g:link><g:message code="default.shoppingbag.label"/>
				</p>
			</div>
			</div>
			</auth:ifNotLoggedIn>

			<auth:ifLoggedIn>
			<div id="login">
				<div id="logout">
					<table>
						<tr>
						<td><g:message code="default.hello.label"/> ${session?.user.login}</td>
						<td><auth:form authAction="logout" success="[controller:'main', action:'index']" error="[controller:'authentication', action:'index']">
						     <g:actionSubmit value="Log out"/>
						</auth:form></td></tr>
						</table>
						<table>
						<tr>
						<td><g:link controller="basket" action="show" id="${session?.user.id}"><g:message code="default.bag.label"/></g:link>
						(${session?.basket?.itemCount == null? 0 : session?.basket?.itemCount} <g:message code="default.items.label"/>)
						</td></tr>
					</table>
				</div>
			</div>
			</auth:ifLoggedIn>
		</div>
	
		
		<div class="nav" role="navigation">			
			<ul>
			<li><g:link class="home" controller="main" action="index"><g:message code="default.home.label"/></g:link>
			</li>
			<auth:ifLoggedIn>
			<li><g:link controller="good" action="list"><g:message code="default.showproduct.label"/></g:link>
			</li>
			<li><g:link controller="category" action="list"><g:message code="default.showcategory.label"/></g:link>
			</li>
			<li><g:link controller="user" action="list"><g:message code="default.showuser.label"/></g:link>
			</li>
			<li><g:link controller="order" action="list"><g:message code="default.showorder.label"/></g:link></li>
			</auth:ifLoggedIn>
			</ul>
		</div>
		<!-- END #nav -->

		<div id="content">
			<g:layoutBody />
		</div>
		<!-- END #content -->
		<div class="buttons">
		<ul>
			<g:link controller="main" action="index"><g:message code="default.home.label"/></g:link>
		</ul>
		</div>
	<div class="footer" role="contentinfo">
		
	</div>
	</body>
</html>
