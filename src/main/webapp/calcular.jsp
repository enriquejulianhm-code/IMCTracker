<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@page import="model.Usuario, model.RegistroIMC, jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>IMC Tracker — Dashboard</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .imc-hero {
            background: linear-gradient(135deg, #0d6efd, #0a58ca);
            color: white; border-radius: 12px; padding: 30px;
        }
        .imc-number {
            font-size: 4rem; font-weight: 900; line-height: 1;
        }
        .badge-normal    { background: #198754; color: white; }
        .badge-bajo      { background: #0dcaf0; color: #212529; }
        .badge-sobrepeso { background: #ffc107; color: #212529; }
        .badge-obesidad  { background: #dc3545; color: white; }
    </style>
</head>
<body class="bg-light">

<%
    // ── Verificar sesión ──────────────────────────────────────────────────
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Usuario u = (Usuario) sesion.getAttribute("usuario");
    RegistroIMC ultimoIMC = (RegistroIMC) sesion.getAttribute("ultimoIMC");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">⚡ IMC Tracker</a>
        <div class="navbar-nav ms-auto align-items-center">
            <span class="navbar-text text-white me-3">
                Hola, <strong>
                    <%= u.getNombreCompleto().split(" ")[0] %>
                </strong>
            </span>
            <a href="logout" class="btn btn-outline-light btn-sm">
                Cerrar sesión
            </a>
        </div>
    </div>
</nav>

<div class="container py-4">

    <%-- Tarjeta IMC actual --%>
    <% if (ultimoIMC != null) {
        String cat = ultimoIMC.getCategoria();
        String badgeClass =
            cat.equals("Peso normal") ? "badge-normal"  :
            cat.equals("Bajo peso")   ? "badge-bajo"    :
            cat.equals("Sobrepeso")   ? "badge-sobrepeso" :
                                        "badge-obesidad";
    %>
    <div class="imc-hero mb-4 d-flex flex-wrap align-items-center gap-4">
        <div>
            <div class="imc-number"><%= ultimoIMC.getImc() %></div>
            <div class="small">kg/m²</div>
            <span class="badge mt-2 px-3 py-2 <%= badgeClass %>">
                ✓ <%= ultimoIMC.getCategoria() %>
            </span>
        </div>
        <div class="flex-grow-1">
            <p class="mb-1">
                <strong>Peso registrado:</strong>
                <%= ultimoIMC.getPeso() %> kg
            </p>
            <p class="mb-1">
                <strong>Estatura:</strong> <%= u.getEstatura() %> m
            </p>
            <p class="mb-0">
                <strong>Última medición:</strong>
                <%= ultimoIMC.getFechaFormateada() %>
            </p>
        </div>
    </div>
    <% } %>

    <div class="row g-4">

        <%-- Panel izquierdo: Formulario --%>
        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom
                            fw-bold text-muted small">
                    CALCULAR NUEVO IMC
                </div>
                <div class="card-body">

                    <%
                        String errorIMC =
                            (String) request.getAttribute("errorIMC");
                        if (errorIMC != null) {
                    %>
                        <div class="alert alert-danger small">
                            ⚠ <%= errorIMC %>
                        </div>
                    <% } %>

                    <form method="post" action="calcular">
                        <label class="form-label fw-semibold small">
                            MASA CORPORAL (KG) — mayor a 0
                        </label>
                        <input type="number" name="peso"
                               class="form-control mb-3"
                               step="0.1" min="0.1"
                               placeholder="70" required>
                        <button type="submit"
                                class="btn btn-primary w-100 fw-bold">
                            Calcular IMC →
                        </button>
                    </form>

                    <div class="mt-3 p-3 bg-light rounded small">
                        <strong>Fórmula aplicada:</strong><br>
                        <code>IMC = peso (kg) / estatura² (m)</code>
                    </div>

                    <div class="mt-3 small">
                        <strong>Categorías OMS:</strong>
                        <ul class="list-unstyled mt-1 mb-0">
                            <li>🔵 Bajo peso: &lt; 18.5</li>
                            <li>🟢 Normal: 18.5 – 24.9</li>
                            <li>🟡 Sobrepeso: 25 – 29.9</li>
                            <li>🔴 Obesidad: ≥ 30</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <%-- Panel derecho: Historial via REST --%>
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom
                            fw-bold text-muted small">
                    HISTORIAL DE MEDICIONES
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Fecha</th>
                                    <th>Peso (KG)</th>
                                    <th>IMC</th>
                                    <th>Categoría</th>
                                </tr>
                            </thead>
                            <tbody id="bodyHistorial">
                                <tr>
                                    <td colspan="5"
                                        class="text-center text-muted py-4">
                                        Cargando historial...
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="p-2 text-muted" style="font-size:11px;">
                        ⓘ Datos cargados mediante servicio REST:
                        <code>GET /api/imc/<%= u.getIdUsuario() %></code>
                        → respuesta JSON consumida con
                        <code>fetch()</code> desde calcular.jsp
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted py-3 border-top mt-4">
    © 2025 IMC Tracker · Universidad Tecmilenio ·
    LTTI4020 – Computación Avanzada en Java
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// ── Cargar historial vía servicio REST ─────────────────────────────────────
const idUsuario = <%= u.getIdUsuario() %>;

function badgeClass(cat) {
    if (cat === 'Peso normal') return 'bg-success text-white';
    if (cat === 'Bajo peso')   return 'bg-info text-dark';
    if (cat === 'Sobrepeso')   return 'bg-warning text-dark';
    return 'bg-danger text-white';
}

fetch('api/imc/' + idUsuario)
    .then(res => res.json())
    .then(data => {
        const tbody = document.getElementById('bodyHistorial');
        if (!data || data.length === 0) {
            tbody.innerHTML =
                '<tr><td colspan="5" class="text-center ' +
                'text-muted py-4">Aún no hay mediciones ' +
                'registradas.</td></tr>';
            return;
        }
        let html = '';
        data.forEach((r, i) => {
            html += `<tr>
                <td>${i + 1}</td>
                <td>${r.fecha}</td>
                <td>${r.peso}</td>
                <td><strong>${r.imc}</strong></td>
                <td>
                    <span class="badge ${badgeClass(r.categoria)}">
                        ${r.categoria}
                    </span>
                </td>
            </tr>`;
        });
        tbody.innerHTML = html;
    })
    .catch(() => {
        document.getElementById('bodyHistorial').innerHTML =
            '<tr><td colspan="5" class="text-danger text-center">' +
            'Error al cargar historial.</td></tr>';
    });
</script>
</body>
</html>