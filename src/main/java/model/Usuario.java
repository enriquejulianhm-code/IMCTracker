package model;

public class Usuario {
    private int idUsuario;
    private String nombreCompleto;
    private String username;
    private String passwordHash;
    private int edad;
    private char sexo;
    private double estatura;

    public Usuario() {}

    public Usuario(String nombreCompleto, String username, String passwordHash,
                   int edad, char sexo, double estatura) {
        this.nombreCompleto = nombreCompleto;
        this.username       = username;
        this.passwordHash   = passwordHash;
        this.edad           = edad;
        this.sexo           = sexo;
        this.estatura       = estatura;
    }

    public int    getIdUsuario()             { return idUsuario; }
    public void   setIdUsuario(int v)        { this.idUsuario = v; }

    public String getNombreCompleto()        { return nombreCompleto; }
    public void   setNombreCompleto(String v){ this.nombreCompleto = v; }

    public String getUsername()              { return username; }
    public void   setUsername(String v)      { this.username = v; }

    public String getPasswordHash()          { return passwordHash; }
    public void   setPasswordHash(String v)  { this.passwordHash = v; }

    public int    getEdad()                  { return edad; }
    public void   setEdad(int v)             { this.edad = v; }

    public char   getSexo()                  { return sexo; }
    public void   setSexo(char v)            { this.sexo = v; }

    public double getEstatura()              { return estatura; }
    public void   setEstatura(double v)      { this.estatura = v; }
}