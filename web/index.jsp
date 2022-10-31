<%@page import="Modelo.Sangre" %>
<%@page import="Modelo.Estudiante" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Estudiantes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light ">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">JSP</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Estudiantes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Tipos de Sangre</a>
                    </li>
                </ul>

            </div>
        </div>
    </nav>

    <div class="container">
        <br>
        <h3 style="text-align:center;">Estudiantes</h3>
        <br>
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"
            onclick="limpiar()">
            Agregar
        </button>

        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Estudiante</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="sr_estudiante" method="post" id="formulario">
                        <div class="modal-body">
                            <div class="form-group">
                                <input type="text" name="id_estudiante" id="id_estudiante" class="form-control" value="0" readonly>
                                <label for="carne">Carnet:</label>
                                <input type="text" class="form-control" id="carne" placeholder="Ingrese carnet" name="carne">
                            </div>
                            <div class="form-group">
                                <label for="nombres">Nombres:</label>
                                <input type="text" class="form-control" id="nombres" placeholder="Ingrese los nombres" name="nombres">
                            </div>
                            <div class="form-group">
                                <label for="apellidos">Apellidos:</label>
                                <input type="text" class="form-control" id="apellidos" placeholder="Ingrese los apellidos" name="apellidos">
                            </div>
                            <div class="form-group">
                                <label for="direccion">Direccion:</label>
                                <input type="text" class="form-control" id="direccion" placeholder="Ingrese la direccion" name="direccion">
                            </div>
                            <div class="form-group">
                                <label for="telefono">Telefono:</label>
                                <input type="number" class="form-control" id="telefono" placeholder="Ingrese numero de telefono" name="telefono">
                            </div>
                            <div class="form-group">
                                <label for="correo_electronico">Correo Electronico:</label>
                                <input type="text" class="form-control" id="correo_electronico" placeholder="Ingrese correo electronico" name="correo_electronico">
                            </div>
                            <div class="form-group">
                                <label for="fecha_nacimiento">Fecha de Nacimiento:</label>
                                <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento">
                            </div>
                            <div class="form-group">
                                <label for="id_tipo_sangre">Tipo de Sangre:</label>
                                <select class="form-control" id="drop_sangre" name="drop_sangre">
                                    <option value=0>--- Eliga el tipo de sangre ---</option>
                                    <% Sangre sangre=new Sangre(); HashMap<String,String> drop = sangre.drop_sangre();
                                        for (String i:drop.keySet()){
                                            out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                        } %>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" name="btn_agregar" id="btn_agregar" value="agregar">Crear</button>
                            <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn" value="modificar">Modificar</button>
                            <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn" value="eliminar" onclick="javascript:if(!confirm('¿Desea Eliminar?'))return false">Eliminar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <br>
        <br>
        <table class="table table-hover">
            <thead style="background-color: #e3f2fd;">
                <tr>
                    <th>Carne</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Direccion</th>
                    <th>Telefono</th>
                    <th>Correo</th>
                    <th>Fecha de nacimiento</th>
                    <th>Tipo de sangre</th>
                </tr>
            </thead>
            <tbody id="tbl_estudiantes">
                <% Estudiante estudiante=new Estudiante(); DefaultTableModel tabla=new DefaultTableModel();
                    tabla=estudiante.leer(); for (int t=0;t<tabla.getRowCount();t++){ out.println("<tr
                    data-id_estudiante=" + tabla.getValueAt(t,0) + " data-id_tipos_sangre=" + tabla.getValueAt(t,9) + ">
                    ");
                      out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,2) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,4) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,5) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,6) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,7) + "</td>");
                      out.println("<td>" + tabla.getValueAt(t,8) + "</td>");
                      out.println("</tr>");
                    }
                    %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script>

        const formulario = document.getElementById('formulario');
        const inputs = document.querySelectorAll('#f-input');
        const expresion = { carne: /^[E]+[0-9]{3}$/ };
      
        // Para validar la expresion regular
        const validar = (e) => {
            switch (e.target.name) {
                case "carne":
                    if (expresion.carne.test(e.target.value)) {
                        return true;
                    } else {
                        confirm("Formato valido: E001 al E999");
                        return false;
                    }
                    break
            }
        }
        inputs.forEach((input) => {
            input.addEventListener('blur', validar)
        })

        // Funcion para limpiar los inputs
        function limpiar() {
            $("#id_estudiante").val(0);
            $("#carne").val('');
            $("#nombres").val('');
            $("#apellidos").val('');
            $("#direccion").val('');
            $("#telefono").val('');
            $("#correo_electronico").val('');
            $("#fecha_nacimiento").val('');
            $("#drop_sangre").val(0);
        }

        //Para mostrar el contenido de los inputs
        $('#tbl_estudiantes').on('click', 'tr td', function (evt) {
            var target, id_estudiante, id_tipo_sangre, carne, nombres, apellidos, direccion, telefono, correo_electronico, fecha_nacimiento;
            target = $(event.target);

            id_estudiante = target.parent().data('id_estudiante');
            id_tipo_sangre = target.parent().data('id_tipos_sangre');
            carne = target.parents("tr").find("td").eq(0).html();
            nombres = target.parents("tr").find("td").eq(1).html();
            apellidos = target.parents("tr").find("td").eq(2).html();
            direccion = target.parents("tr").find("td").eq(3).html();
            telefono = target.parents("tr").find("td").eq(4).html();
            correo_electronico = target.parents("tr").find("td").eq(5).html();
            fecha_nacimiento = target.parents("tr").find("td").eq(6).html();

            $("#id_estudiante").val(id_estudiante);
            $("#carne").val(carne);
            $("#nombres").val(nombres);
            $("#apellidos").val(apellidos);
            $("#direccion").val(direccion);
            $("#telefono").val(telefono);
            $("#correo_electronico").val(correo_electronico);
            $("#drop_sangre").val(id_tipo_sangre);
            $("#fecha_nacimiento").val(fecha_nacimiento);
            $("#exampleModal").modal('show');
        });
    </script>
</body>

</html>
