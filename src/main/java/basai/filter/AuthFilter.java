package basai.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;

        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        String path = req.getRequestURI();
        System.out.println(">>>FILTER HIT: " + path);
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isLogin = path.endsWith("login.jsp");
        boolean isRegister = path.endsWith("register.jsp");
        boolean isIndex = path.endsWith("index.jsp");
        boolean isVerificationPending = path.endsWith("verificationPending.jsp");
        boolean isAuth = path.contains("user-auth");
        boolean isRootUrl = path.equals(req.getContextPath() + "/") || path.equals(req.getContextPath());
        boolean isStatic = path.endsWith(".css") ||
                path.endsWith(".js") ||
                path.endsWith(".jpg") ||
                path.endsWith(".jpeg") ||
                path.endsWith(".png");

        boolean isPublic = isLogin || isRegister || isIndex || isVerificationPending || isAuth || isRootUrl;

        if (isLoggedIn && (isLogin || isRegister)) {
            String role = (String) session.getAttribute("role");
            res.sendRedirect(req.getContextPath() + getRoleHomePage(role));
            return;
        }

        if (!isLoggedIn && !(isPublic || isStatic)) {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
            return;
        }
        filterChain.doFilter(req, res);
    }

    private String getRoleHomePage(String role) {
        if (role == null) return "/views/login.jsp";
        switch (role.toLowerCase()) {
            case "admin":  return "/views/admin/dashboard.jsp";
            case "owner":  return "/views/owner/dashboard.jsp";
            case "renter": return "/views/renter/dashboard.jsp";
            default:       return "/views/login.jsp";
        }
    }
}