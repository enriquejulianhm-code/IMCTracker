package service;

import model.RegistroIMC;
import model.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IMCService {

    private static final String URL =
            "jdbc:mysql://localhost:3306/imc_db"
          + "?user=root"
          + "&password=Imcroot"
          + "&useSSL=false"
          + "&allowPublicKeyRetrieval=true"
          + "&serverTimezone=UTC";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver MySQL no encontrado", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    // ── registrarUsuario ──────────────────────────────────────────────────

    public boolean registrarUsuario(Usuario u) {
        String sql = "INSERT INTO USUARIO " +
                     "(nombre_completo, username, password_hash, edad, sexo, estatura) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getNombreCompleto());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getPasswordHash());
            ps.setInt   (4, u.getEdad());
            ps.setString(5, String.valueOf(u.getSexo()));
            ps.setDouble(6, u.getEstatura());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                return false; // username duplicado (MySQL: ER_DUP_ENTRY)
            }
            throw new RuntimeException("Error al registrar: " + e.getMessage(), e);
        }
    }

    // ── buscarPorUsername ─────────────────────────────────────────────────

    public Usuario buscarPorUsername(String username) {
        String sql = "SELECT id_usuario, nombre_completo, username, " +
                     "password_hash, edad, sexo, estatura " +
                     "FROM USUARIO WHERE username = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario     (rs.getInt    ("id_usuario"));
                u.setNombreCompleto(rs.getString ("nombre_completo"));
                u.setUsername      (rs.getString ("username"));
                u.setPasswordHash  (rs.getString ("password_hash"));
                u.setEdad          (rs.getInt    ("edad"));
                u.setSexo          (rs.getString ("sexo").charAt(0));
                u.setEstatura      (rs.getDouble ("estatura"));
                return u;
            }
            return null;

        } catch (SQLException e) {
            throw new RuntimeException("Error en login: " + e.getMessage(), e);
        }
    }

    // ── guardarIMC ────────────────────────────────────────────────────────

    public boolean guardarIMC(RegistroIMC r) {
        String sql = "INSERT INTO REGISTRO_IMC (id_usuario, peso, imc, categoria) " +
                     "VALUES (?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt   (1, r.getIdUsuario());
            ps.setDouble(2, r.getPeso());
            ps.setDouble(3, r.getImc());
            ps.setString(4, r.getCategoria());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error al guardar IMC: " + e.getMessage(), e);
        }
    }

    // ── getHistorico ──────────────────────────────────────────────────────

    public List<RegistroIMC> getHistorico(int idUsuario) {
        String sql = "SELECT id_registro, id_usuario, peso, imc, " +
                     "categoria, fecha_medicion " +
                     "FROM REGISTRO_IMC " +
                     "WHERE id_usuario = ? " +
                     "ORDER BY fecha_medicion DESC";
        List<RegistroIMC> lista = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RegistroIMC r = new RegistroIMC();
                r.setIdRegistro (rs.getInt   ("id_registro"));
                r.setIdUsuario  (rs.getInt   ("id_usuario"));
                r.setPeso       (rs.getDouble("peso"));
                r.setImc        (rs.getDouble("imc"));
                r.setCategoria  (rs.getString("categoria"));
                Timestamp ts = rs.getTimestamp("fecha_medicion");
                if (ts != null) {
                    r.setFechaMedicion(ts.toLocalDateTime());
                }
                lista.add(r);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error historial: " + e.getMessage(), e);
        }
        return lista;
    }
}