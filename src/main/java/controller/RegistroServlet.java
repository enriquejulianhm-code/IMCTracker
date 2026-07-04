package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import service.IMCService;

import java.io.IOException;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registrar"})
public class RegistroServlet extends HttpServlet {

    private final IMCService dao = new IMCService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ── 1. Leer parámetros ──────────────────────────────────────────
        String nombre   = request.getParameter("nombre").trim();
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String edadStr  = request.getParameter("edad");
        String sexoStr  = request.getParameter("sexo");
        String estStr   = request.getParameter("estatura");

        // ── 2. Validar campos vacíos ────────────────────────────────────
        if (nombre.isEmpty() || username.isEmpty() || password.isEmpty()
                || edadStr == null || sexoStr == null || estStr == null) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        // ── 3. Parsear valores ──────────────────────────────────────────
        int    edad;
        double estatura;
        char   sexo;

        try {
            edad     = Integer.parseInt(edadStr);
            estatura = Double.parseDouble(estStr);
            sexo     = sexoStr.charAt(0);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos numéricos inválidos.");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        // ── 4. Validar reglas de negocio ────────────────────────────────
        if (edad < 15) {
            request.setAttribute("error",
                "La edad mínima para registrarse es 15 años.");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        if (estatura < 1.00 || estatura > 2.50) {
            request.setAttribute("error",
                "La estatura debe estar entre 1.00 m y 2.50 m.");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        // ── 5. Hashear contraseña ───────────────────────────────────────
        String passwordHash = hashPassword(password);

        // ── 6. Crear usuario y persistir ────────────────────────────────
        Usuario u = new Usuario(nombre, username, passwordHash,
                                edad, sexo, estatura);
        boolean ok = dao.registrarUsuario(u);

        if (!ok) {
            request.setAttribute("error",
                "El nombre de usuario ya existe. Elige otro.");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        // ── 7. Redirigir a login con mensaje de éxito ───────────────────
        response.sendRedirect(
            request.getContextPath() + "/login.jsp?registrado=true");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/registro.jsp");
    }

    private String hashPassword(String password) {
        try {
            java.security.MessageDigest md =
                java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error al hashear contraseña", e);
        }
    }
}