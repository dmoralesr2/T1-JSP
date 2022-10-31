/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class Sangre {
    private int id_tipo_sangre;
    private String sangre;
    Conexion cn;
    public Sangre(){}
    public Sangre(int id_tipo_sangre, String sangre) {
        this.id_tipo_sangre = id_tipo_sangre;
        this.sangre = sangre;
    }

    public int getIdTipoSangre() {
        return id_tipo_sangre;
    }

    public void setId_tipo_sangre(int id_tipo_sangre) {
        this.id_tipo_sangre = id_tipo_sangre;
    }

    public String getSangre() {
        return sangre;
    }

    public void setSangre(String sangre) {
        this.sangre = sangre;
    }
    
    public HashMap drop_sangre(){
    HashMap<String,String> drop = new HashMap();
        try{
            String query ="SELECT id_tipo_sangre AS id, sangre FROM tipos_sangre;";
            cn = new Conexion();
            cn.abrir_conexion();
                ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
                while (consulta.next()){
                drop.put(consulta.getString("id"),consulta.getString("sangre") );
            }
            cn.cerrar_conexion();
        } catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return drop;
    }
}
