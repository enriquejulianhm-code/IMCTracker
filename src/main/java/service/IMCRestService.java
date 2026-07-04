package service;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import model.RegistroIMC;

import java.util.List;

/**
 * IMCRestService — Servicio REST (JAX-RS)
 * URL base: /api/imc
 * Endpoint: GET /api/imc/{id_usuario}
 */
@Path("/imc")
public class IMCRestService {

    private final IMCService dao = new IMCService();

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getHistorico(@PathParam("id") int idUsuario) {
        try {
            List<RegistroIMC> lista = dao.getHistorico(idUsuario);
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < lista.size(); i++) {
                RegistroIMC r = lista.get(i);
                json.append("{")
                    .append("\"idRegistro\":").append(r.getIdRegistro()).append(",")
                    .append("\"peso\":").append(r.getPeso()).append(",")
                    .append("\"imc\":").append(r.getImc()).append(",")
                    .append("\"categoria\":\"").append(r.getCategoria()).append("\",")
                    .append("\"fecha\":\"").append(r.getFechaFormateada()).append("\"")
                    .append("}");
                if (i < lista.size() - 1) json.append(",");
            }
            json.append("]");
            return Response.ok(json.toString()).build();
        } catch (Exception e) {
            return Response.serverError()
                           .entity("{\"error\":\"" + e.getMessage() + "\"}")
                           .build();
        }
    }

    @GET
    @Path("/categoria/{valor}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCategoria(@PathParam("valor") double valor) {
        String cat = RegistroIMC.determinarCategoria(valor);
        return Response.ok(
            "{\"imc\":" + valor + ",\"categoria\":\"" + cat + "\"}"
        ).build();
    }
}