package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import service.IMCService;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final IMCService dao = new IMCService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ── 1. Validar que no vengan vacíos ─────────────────────────────
        if (username == null || password == null
                || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=true");
            return;
        }

        // ── 2. Buscar usuario en BD ──────────────────────────────────────
        Usuario u = dao.buscarPorUsername(username.trim());

        // ── 3. Verificar contraseña ──────────────────────────────────────
        if (u == null || !verificarPassword(password, u.getPasswordHash())) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=true");
            return;
        }

        // ── 4. Crear sesión HTTP ─────────────────────────────────────────
        HttpSession sesion = request.getSession(true);
        sesion.setAttribute("usuario",       u);
        sesion.setAttribute("idUsuario",     u.getIdUsuario());
        sesion.setAttribute("nombreUsuario", u.getNombreCompleto());

        // ── 5. Redirigir al dashboard ────────────────────────────────────
        response.sendRedirect(
            request.getContextPath() + "/calcular.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    private boolean verificarPassword(String password, String hashAlmacenado) {
        try {
            java.security.MessageDigest md =
                java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) sb.append(String.format("%02x", b));
            return sb.toString().equals(hashAlmacenado);
        } catch (Exception e) {
            return false;
        }
    }
}