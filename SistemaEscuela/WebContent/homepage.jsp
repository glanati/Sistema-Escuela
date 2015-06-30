<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="conexion.AccionesUsuario"%> 
<!DOCTYPE html>
<html>

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "homepage.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	String nombre_usuario = "Admin";
	String apellido_usuario = "";
	
	if (tipo == 1){ 	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		nombre_usuario = maestro.getNombre();
		apellido_usuario = maestro.getApellido();
	}
%>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Home</title>
    
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

	<div id="wrapper">
  		<!-- masterpage -->
  	</div>
  	
        <div id="page-wrapper">
                 
            <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Home <small> Bienvenido/a <%= nombre_usuario + " " + apellido_usuario%></small>
                        </h1>
                    <!--    
                        <ol class="breadcrumb">
                            <li class="active">
                               <i class="fa fa-home"></i> Home
                            </li>
                        </ol>
                    -->    
                    </div>
                </div>
                <!-- /.row -->
                
                
                
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-cubes"></i> Módulos del sistema
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <ul class="timeline">
                                <li>
                                    <div class="timeline-badge primary"><i class="fa fa-child"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestíon de Alumnos</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar los alumnos de la institución realizando las actividades de alta, baja, modificación, activación y visualización.</p>
                                        	<p>Se podrá gestionar los certificados entregados por los alumnos, modificando el estado de los mismo (entregado o no).</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-badge primary"><i class="fa fa-group"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Cursos</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar los grados realizando las actividades de alta, baja, modificación, promoción, asignación y des asignación de materias.</p>                                           
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-badge primary"><i class="fa fa-male"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Maestros</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar los maestros pertenecientes a la institución realizando las actividades de alta, baja, modificación y activación de los mismos.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                	<div class="timeline-badge primary"><i class="fa fa-book"></i>
                                	</div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Materias</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar las materias dictadas en la institución realizando las actividades de alta, baja, modificación y activación de las mismas.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-badge primary"><i class="fa fa-edit"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Tardanzas</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar las tardanzas de los alumnos realizando las actividades de alta, baja y modificación.</p>           
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                               		<div class="timeline-badge primary"><i class="fa fa-comments"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Entrevistas</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá gestionar las entrevistas realizadas a los aspirantes a ingresar a la institución realizando las actividades de alta, baja y modificación de las mismas.</p>
                                        	<p>El usuario maestro podrá gestionar las entrevistas cargadas al mismo realizando las actividades de baja y modificación.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-badge primary"><i class="fa fa-money"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Cuotas (a futuro)</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario administrador podrá realizar la gestión de cuotas realizando las actividades de alta, baja y modificación de las mismas. Así como también modificar precios y planes de pago.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-badge primary"><i class="fa fa-list-alt"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Asistencias</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario maestro podrá gestionar las asistencias de sus alumnos realizando las actividades de alta, baja y modificación de las mismas.</p>
                                        </div>
                                    </div>
                                </li>
                                  <li>
                                    <div class="timeline-badge primary"><i class="fa fa-calendar"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Citaciones</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario maestro podrá gestionar las citaciones realizadas a los padres de sus alumnos realizando las actividades de alta, baja y modificación de las mismas.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-badge primary"><i class="fa fa-file-text-o"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Sanciones</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario maestro podrá gestionar las sanciones de sus alumnos realizando las actividades de alta, baja y modificación de las mismas.</p>
                                        </div>
                                    </div>
                                </li>
                                 <li>
                                    <div class="timeline-badge primary"><i class="fa fa-clipboard"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Gestión de Notas</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>El usuario maestro podrá gestionar las notas de sus grados asignados realizando las actividades de alta, baja y modificación de las mismas.</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
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