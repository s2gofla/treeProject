package org.tree.security;


import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Component;

public class CsrfSecurityRequestMathcer implements RequestMatcher{

	
	 private Pattern allowedMethods = Pattern.compile("^(GET|HEAD|TRACE|OPTIONS)$");

	    private RegexRequestMatcher unprotectedMatcher = new RegexRequestMatcher("/board/*", null);



	    @Override
	    public boolean matches(HttpServletRequest request) {

	        if(allowedMethods.matcher(request.getMethod()).matches()){

	            return false;

	        }



	        return !unprotectedMatcher.matches(request);

	    }
	
}
