<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>IMC Tracker — Iniciar sesión</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">⚡ IMC Tracker</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="index.jsp">Inicio</a>
            <a class="nav-link" href="registro.jsp">Registrarse</a>
            <a class="nav-link active fw-bold" href="login.jsp">
                Iniciar sesión
            </a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0 fw-bold">Iniciar sesión</h5>
                    <small>
                        Debes iniciar sesión para calcular tu IMC.
                    </small>
                </div>
                <div class="card-body p-4">

                    <%-- Registro exitoso --%>
                    <%
                        if ("true".equals(request.getParameter("registrado"))) {
                    %>
                        <div class="alert alert-success">
                            ✅ Cuenta creada exitosamente.
                            Inicia sesión para continuar.
                        </div>
                    <% } %>

                    <%-- Credenciales incorrectas --%>
                    <%
                        if ("true".equals(request.getParameter("error"))) {
                    %>
                        <div class="alert alert-danger">
                            ⊗ Usuario o contraseña incorrectos.
                            Intenta de nuevo.
                        </div>
                    <% } %>

                    <form method="post" action="login">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                NOMBRE DE USUARIO
                            </label>
                            <input type="text" name="username"
                                   class="form-control"
                                   placeholder="anagarcia"
                                   required autofocus>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                CONTRASEÑA
                            </label>
                            <input type="password" name="password"
                                   class="form-control" required>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100 fw-bold">
                            Entrar →
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <a href="registro.jsp"
                           class="text-primary text-decoration-none">
                            ¿No tienes cuenta? Regístrate
                        </a>
                    </div>
                </div>
            </div>

            <%-- Panel de flujo técnico --%>
            <div class="card border-0 shadow-sm mt-3">
                <div class="card-body small">
                    <h6 class="fw-bold text-primary">FLUJO TÉCNICO</h6>
                    <ol class="text-muted mb-0">
                        <li>Usuario envía credenciales (POST)</li>
                        <li><code>LoginServlet</code> llama a
                            <code>IMCService.buscarPorUsername()</code></li>
                        <li>Se consulta MySQL con el username</li>
                        <li>Se verifica el hash SHA-256 de la contraseña</li>
                        <li>Si válido: crea <code>HttpSession</code>
                            → redirige a <code>calcular.jsp</code></li>
                        <li>Si inválido: redirige a
                            <code>login.jsp?error=true</code></li>
                    </ol>
                </div>
            </div>

        </div>
    </div>
</div>

<footer class="text-center text-muted py-3 border-top">
    © 2025 IMC Tracker · Universidad Tecmilenio ·
    LTTI4020 – Computación Avanzada en Java
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>