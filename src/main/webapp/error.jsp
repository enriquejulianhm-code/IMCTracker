<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>IMC Tracker — Error</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">⚡ IMC Tracker</a>
    </div>
</nav>

<div class="container py-5 text-center">
    <div class="card shadow-sm border-0 d-inline-block px-5 py-4">
        <h1 class="display-1 text-danger">⚠</h1>
        <h4 class="fw-bold mb-3">Error del servidor</h4>
        <% if (exception != null) { %>
            <div class="alert alert-danger small text-start">
                <strong>Detalle:</strong> <%= exception.getMessage() %>
            </div>
        <% } else { %>
            <p class="text-muted">Ocurrió un error inesperado.</p>
        <% } %>
        <a href="index.jsp" class="btn btn-primary mt-2">
            ← Volver al inicio
        </a>
    </div>
</div>

<footer class="text-center text-muted py-3 border-top mt-5">
    © 2025 IMC Tracker · Universidad Tecmilenio ·
    LTTI4020 – Computación Avanzada en Java
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>