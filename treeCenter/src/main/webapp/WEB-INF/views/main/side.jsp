<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>     
<!-- Sidebar -->
<div id="sidebar">
	<div class="inner">

		<!-- Search -->
		<section id="search" class="alt">
			<form method="post" action="#">
				<input type="text" name="query" id="query" placeholder="Search" />
			</form>
		</section>
		
		<!-- login/logout-->
		<section>
			<header class="major">
				<h2>Login</h2>
			</header>
			<div class="mini-posts">
				<!-- <article>
					<a href="#" class="image"><img src="/resources/images/pic07.jpg" alt="" /></a>
					<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper
						dolore aliquam.</p>
				</article> -->
			</div>
			<ul class="actions">
				<li>
				<sec:authorize access="isAnonymous()">
				<a href="/member/login" class="button">Login</a>				
				<a href="/member/signUp" class="button">SignUp</a>			
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
				<form action="/member/logout" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button class="button">logout</button>
				</form>
				
				</sec:authorize>
				</li>
			</ul>
		</section>
		
		
		<!-- Menu -->
		<nav id="menu">
			<header class="major">
				<h2>Menu</h2>
			</header>
			<ul>
				<li><a href="/">Homepage</a></li>
				<li><a href="/notice/list">Notice</a></li>
				<li><a href="/lecture/list">Lecture Reservation</a></li>
				<li><span class="opener">Community</span>
					<ul>
						<li><a href="/review/list">Lecture Review</a></li>
						<li><a href="/board/list">Board</a></li>
					</ul></li>
				<li><a href="/myPage/list">MyPage</a></li>
		</nav>

		
		<!-- Section -->
		<section>
			<header class="major">
				<h2>Get in touch</h2>
			</header>
			<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare
				velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed
				aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus
				aliquam.</p>
			<ul class="contact">
				<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
				<li class="icon solid fa-phone">(000) 000-0000</li>
				<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
					Nashville, TN 00000-0000
				</li>
			</ul>
		</section>

		<!-- Footer -->
		<footer id="footer">
			<p class="copyright">
				&copy; Untitled. All rights reserved. Demo Images: <a
					href="https://unsplash.com">Unsplash</a>. Design: <a
					href="https://html5up.net">HTML5 UP</a>.
			</p>
		</footer>

	</div>
</div>

