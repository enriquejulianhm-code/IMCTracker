
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>IMC Tracker — Registro</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">⚡ IMC Tracker</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="index.jsp">Inicio</a>
            <a class="nav-link active fw-bold" href="registro.jsp">Registrarse</a>
            <a class="nav-link" href="login.jsp">Iniciar sesión</a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">

        <%-- Formulario principal --%>
        <div class="col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0 fw-bold">Crear cuenta</h5>
                    <small>
                        Completa tu información para comenzar a
                        monitorear tu IMC a través del tiempo.
                    </small>
                </div>
                <div class="card-body p-4">

                    <%-- Mensaje de error del servidor --%>
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <div class="alert alert-danger">
                            ⚠ <%= error %>
                        </div>
                    <% } %>

                    <form method="post" action="registrar">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                NOMBRE COMPLETO
                            </label>
                            <input type="text" name="nombre"
                                   class="form-control"
                                   placeholder="Ej. Ana García López"
                                   required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    NOMBRE DE USUARIO
                                </label>
                                <input type="text" name="username"
                                       class="form-control"
                                       placeholder="anagarcia" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    CONTRASEÑA
                                </label>
                                <input type="password" name="password"
                                       class="form-control" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    EDAD
                                    <small class="text-muted fw-normal">
                                        (mínimo 15 años)
                                    </small>
                                </label>
                                <input type="number" name="edad"
                                       class="form-control"
                                       min="15" max="120" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    SEXO
                                </label>
                                <select name="sexo" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                ESTATURA
                                <small class="text-muted fw-normal">
                                    (metros — entre 1.00 y 2.50)
                                </small>
                            </label>
                            <input type="number" name="estatura"
                                   class="form-control"
                                   step="0.01" min="1.00" max="2.50"
                                   placeholder="1.65" required>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100 fw-bold">
                            Crear cuenta →
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <a href="login.jsp"
                           class="text-primary text-decoration-none">
                            ¿Ya tienes cuenta? Inicia sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%-- Panel lateral informativo --%>
        <div class="col-lg-4 mt-4 mt-lg-0">
            <div class="card border-0 shadow-sm mb-3">
                <div class="card-body">
                    <h6 class="fw-bold text-primary">
                        REQUISITOS DEL SISTEMA
                    </h6>
                    <ul class="small text-muted mb-0">
                        <li>Edad mínima: <strong>15 años</strong></li>
                        <li>Estatura válida:
                            <strong>1.00 m – 2.50 m</strong></li>
                        <li>El username debe ser único en el sistema</li>
                        <li>La contraseña se almacena con hash SHA-256</li>
                    </ul>
                </div>
            </div>
            <div class="alert alert-success small">
                <strong>Flujo:</strong> Al registrarte correctamente,
                serás redirigido a la pantalla de inicio de sesión
                para acceder a tu perfil.
            </div>
            <div class="alert alert-warning small">
                <strong>Nota técnica:</strong> El
                <code>RegistroServlet</code> valida estatura y edad
                antes de persistir en SQL Server.
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