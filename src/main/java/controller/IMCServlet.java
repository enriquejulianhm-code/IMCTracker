package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.RegistroIMC;
import model.Usuario;
import service.IMCService;

import java.io.IOException;

@WebServlet(name = "IMCServlet", urlPatterns = {"/calcular"})
public class IMCServlet extends HttpServlet {

    private final IMCService dao = new IMCService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ── 1. Verificar sesión activa ───────────────────────────────────
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        // ── 2. Obtener usuario de la sesión ──────────────────────────────
        Usuario u = (Usuario) sesion.getAttribute("usuario");

        // ── 3. Leer y validar peso ───────────────────────────────────────
        String pesoStr = request.getParameter("peso");
        double peso;

        try {
            peso = Double.parseDouble(pesoStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorIMC",
                "El peso debe ser un número válido.");
            request.getRequestDispatcher("/calcular.jsp")
                   .forward(request, response);
            return;
        }

        if (peso <= 0) {
            request.setAttribute("errorIMC",
                "El peso debe ser mayor a 0 kg.");
            request.getRequestDispatcher("/calcular.jsp")
                   .forward(request, response);
            return;
        }

        // ── 4. Calcular IMC y persistir en BD ────────────────────────────
        RegistroIMC registro = new RegistroIMC(
            u.getIdUsuario(), peso, u.getEstatura());
        dao.guardarIMC(registro);

        // ── 5. Guardar en sesión para mostrarlo en la vista ──────────────
        sesion.setAttribute("ultimoIMC", registro);

        response.sendRedirect(
            request.getContextPath() + "/calcular.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }
        response.sendRedirect(
            request.getContextPath() + "/calcular.jsp");
    }
}