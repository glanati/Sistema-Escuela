<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
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

    <title>Administración de Usuario</title>
    
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
	
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "admin_user.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	String nombre = "";
	String apellido = "";

%>

	<div id="wrapper">
  		<!-- masterpage -->
  	</div>
  	
        <div id="page-wrapper">
                 
            <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Administración de Usuario
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <a href="configuracion_cuenta.jsp"><i class="fa fa-cog"></i> Configuración</a>
                            </li>
                            <li>
                           		<i class="fa fa-user"> </i> Administración de Usuario
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                

				<div class="row">
	                <div class="col-lg-6">
	                    <div class="panel panel-default">
	                    <!--  
	                        <div class="panel-heading">
	                            Basic Form Elements
	                        </div>
	                    -->    
	                        <div class="panel-body">
	                            <div class="row">
	                                <div class="col-lg-6">
	                                    <form role="form" action="AdminUser?do=user" method="post">
	                                        <div class="form-group">
	                                            <label>Contraseña</label>
	                                            <input type="password" class="form-control" name="contraseña_actual" required autofocus>
	                                         <!--     <p class="help-block">Example block-level help text here.</p>		-->
	                                         	<label>Nuevo usuario</label>
	                                            <input type="text" class="form-control" name="usuario_nuevo" required>
	                                            <label>Vuelve a escribir el nuevo usuario</label>
	                                            <input type="text" class="form-control" name="usuario_nuevo_r" required>
	                                        </div>
	                                        <button type="submit" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(2).getMensaje()%>><i class="fa fa-save"></i> Guardar</button>
											<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="fa fa-remove"></i> Cancelar</button>
	                                     </form>
	                                 </div>
	                             </div>
	                         </div>
	                      </div>
	                 </div> 
                 </div>                      
				
				
			<!-- 
				<br>
						 
				<div class="form-group">
					<form action="configuracion_cuenta.jsp" method="get">
					<button type="submit" class="btn btn-primary"  value="Volver a configuración"><i class="fa fa-share-alt"></i> Volver</button>
					</form>
				</div>
				
				<br>
			-->
				 <!-- MENSAJE -->
				 <%	
					Mensaje mensaje = null;
					if (session.getAttribute("mensaje") != null) {
						mensaje = (Mensaje) session.getAttribute("mensaje");
						session.setAttribute("mensaje", null);
				 %>
				 <br>
				   <div class="bs-example">
				    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
				     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				     	 <%= mensaje.getMensaje()%>
				  	  </div>
				  </div><!-- /example -->
				<br>
				 <%}%>
                
                
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