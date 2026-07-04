package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class RegistroIMC {
    private int           idRegistro;
    private int           idUsuario;
    private double        peso;
    private double        imc;
    private String        categoria;
    private LocalDateTime fechaMedicion;

    public RegistroIMC() {}

    public RegistroIMC(int idUsuario, double peso, double estatura) {
        this.idUsuario = idUsuario;
        this.peso      = peso;
        this.imc       = calcularIMC(peso, estatura);
        this.categoria = determinarCategoria(this.imc);
    }

    public double calcularIMC(double peso, double estatura) {
        return Math.round((peso / (estatura * estatura)) * 100.0) / 100.0;
    }

    public static String determinarCategoria(double imc) {
        if (imc < 18.5) return "Bajo peso";
        if (imc < 25.0) return "Peso normal";
        if (imc < 30.0) return "Sobrepeso";
        return "Obesidad";
    }

    public String getFechaFormateada() {
        if (fechaMedicion == null) return "";
        return fechaMedicion.format(
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    public int    getIdRegistro()                  { return idRegistro; }
    public void   setIdRegistro(int v)             { this.idRegistro = v; }

    public int    getIdUsuario()                   { return idUsuario; }
    public void   setIdUsuario(int v)              { this.idUsuario = v; }

    public double getPeso()                        { return peso; }
    public void   setPeso(double v)                { this.peso = v; }

    public double getImc()                         { return imc; }
    public void   setImc(double v)                 { this.imc = v; }

    public String getCategoria()                   { return categoria; }
    public void   setCategoria(String v)           { this.categoria = v; }

    public LocalDateTime getFechaMedicion()        { return fechaMedicion; }
    public void setFechaMedicion(LocalDateTime v)  { this.fechaMedicion = v; }
}