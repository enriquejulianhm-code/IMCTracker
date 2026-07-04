<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>IMC Tracker — Inicio</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f8f9fa; }
        .hero { background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                color: white; padding: 80px 0; }
        .card-feature { border: none; border-radius: 12px;
                        box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">⚡ IMC Tracker</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link active" href="index.jsp">Inicio</a>
            <a class="nav-link" href="registro.jsp">Registrarse</a>
            <a class="nav-link" href="login.jsp">Iniciar sesión</a>
        </div>
    </div>
</nav>

<section class="hero text-center">
    <div class="container">
        <h1 class="display-4 fw-bold mb-3">
            Monitorea tu IMC a través del tiempo
        </h1>
        <p class="lead mb-4">
            Calcula tu Índice de Masa Corporal, lleva un historial
            de tus mediciones y toma el control de tu salud.
        </p>
        <a href="registro.jsp" class="btn btn-light btn-lg me-3 fw-bold">
            Crear cuenta →
        </a>
        <a href="login.jsp" class="btn btn-outline-light btn-lg">
            Iniciar sesión
        </a>
    </div>
</section>

<section class="container my-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card card-feature p-4 h-100">
                <h5 class="fw-bold text-primary">🔒 Registro seguro</h5>
                <p class="text-muted">
                    Crea tu cuenta con tu nombre, edad, sexo y estatura.
                    Tu contraseña se almacena con hash SHA-256.
                </p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-feature p-4 h-100">
                <h5 class="fw-bold text-primary">📊 Cálculo preciso</h5>
                <p class="text-muted">
                    Ingresa tu peso corporal y obtén tu IMC al instante
                    con su categoría según la OMS.
                </p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-feature p-4 h-100">
                <h5 class="fw-bold text-primary">📈 Historial en tiempo real</h5>
                <p class="text-muted">
                    Consulta todas tus mediciones anteriores cargadas
                    dinámicamente vía servicio REST.
                </p>
            </div>
        </div>
    </div>

    <div class="card card-feature mt-5 p-4">
        <h5 class="fw-bold text-primary mb-3">
            Categorías IMC según la OMS
        </h5>
        <div class="table-responsive">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-primary">
                    <tr>
                        <th>Rango IMC (kg/m²)</th>
                        <th>Categoría</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td>Menos de 18.5</td><td>🔵 Bajo peso</td></tr>
                    <tr><td>18.5 – 24.9</td> <td>🟢 Peso normal</td></tr>
                    <tr><td>25.0 – 29.9</td> <td>🟡 Sobrepeso</td></tr>
                    <tr><td>30.0 o más</td>  <td>🔴 Obesidad</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</section>

<footer class="text-center text-muted py-3 border-top">
    © 2025 IMC Tracker · Universidad Tecmilenio ·
    LTTI4020 – Computación Avanzada en Java
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>