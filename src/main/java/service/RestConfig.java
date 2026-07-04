package service;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

/**
 * RestConfig — Registra la aplicación JAX-RS
 * Todas las peticiones a /api/* son manejadas por los recursos REST
 */
@ApplicationPath("/api")
public class RestConfig extends Application {
    // GlassFish detecta automáticamente los recursos anotados con @Path
}