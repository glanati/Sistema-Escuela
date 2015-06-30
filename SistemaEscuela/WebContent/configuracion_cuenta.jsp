<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuenta");%>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Configuración</title>
    
    <link rel="icon" href="icono/favicon.ico">

    <!-- Bootstrap Core CSS -->
    <link href="style/bootstrap2.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> 
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="style/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="style/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="style/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

	<%
	String usuario = (String) session.getAttribute("user");

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "admin_pass.jsp") != 1){			//MODIFICAR A configuracion_cuenta.jsp					
		response.sendRedirect("Login");						
	}
	
	Integer dni_maestro = (Integer) session.getAttribute("dni_maestro");
	%>

	<div id="wrapper">
  		<!-- masterpage -->
  	</div>
  	
        <div id="page-wrapper">
                 
            <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Configuración general de la cuenta
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                               <i class="fa fa-cog"></i> Configuración
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
				<div class="form-group">
					<form action="AdminUser?do=pass" method="post">
						<table class="table table-hover">
							<thead>
							<tr>
								<td>
									<label for="input">Nombre</label>
								</td>
								<td>
									<div class="col-xs-6">
										<%			
											String nombre = "";
											String apellido = "";
											
											if (dni_maestro != null ){		
												Maestro maestro = (Maestro)session.getAttribute("maestro");
												nombre = maestro.getNombre();
												apellido = maestro.getApellido();
										%>
												<label for="input"><%= nombre + " " + apellido %></label>
										<%		
											} else {
										%>		
												<label for="input">Administrador</label>
										<%		
											}	
										%>	
									</div>
								</td> 
								<td>&nbsp;</td>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>
									<label for="input">Nombre de usuario</label>
								</td>
								<td>
									<div class="col-xs-6">
										<label for="input"><%= usuario %></label>	
									</div>		
								</td>
								<td>
									<div class="col-xs-6">
										<strong><a href="admin_user.jsp"><i class="fa fa-pencil"></i> Editar </a></strong>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="input">Contraseña</label>
								</td>
								<td>
									<div class="col-xs-6">
										<label for="input">***************</label>
									</div>
								</td>
								<td>
									<div class="col-xs-6">
										<strong><a href="admin_pass.jsp"><i class="fa fa-pencil"></i> Editar </a></strong>
									</div>
								</td>
							</tr>
							</tbody>
						</table>
					</form>
				</div>
                
        </div>
        <!-- /#page-wrapper -->
 
    <!-- jQuery -->
    <script src="js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap2.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/metisMenu.min.js"></script>

	
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>
  
    
    <!-- masterpage -->
	<script src="js/load-masterpage.js"></script> 

</body>
</html>