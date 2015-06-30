<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="conexion.AccionesUsuario"%>
<!DOCTYPE html>
<html>
<head>
	 <!-- Bootstrap Core CSS -->
    <link href="style/bootstrap2.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> 
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="style/metisMenu.min.css" rel="stylesheet">

    <!-- Timeline CSS -->
    <link href="style/timeline.css" rel="stylesheet">

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

	String modulo = (String) session.getAttribute("modulo");
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	
	String nombre_usuario = "Admin";
	String apellido_usuario = "";
	
	if (tipo == 1){ 	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		nombre_usuario = maestro.getNombre();
		apellido_usuario = maestro.getApellido();
	}
%>

<div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="homepage.jsp">Sistema Escuela "Príncipe de Paz"</a>
            </div>
            <!-- /.navbar-header -->
            <ul class="nav navbar-top-links navbar-right">  
             <!--
                <li class="dropdown">
                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="fa fa-user"></i> Admin <span class="caret"></span></a>
                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
                        <li><a href="tables2.html"><i class="fa fa-cog"></i> Settings</a></li>
                    </ul>
                </li>
             -->   
                <!-- /.dropdown --> 
                <li><a href="#"><i class="fa fa-user"></i> <%= nombre_usuario + " " + apellido_usuario%> </a></li>   
                <li><a href="configuracion_cuenta.jsp"><i class="fa fa-cog"></i> Configuración</a></li>       
                <li><a href="cerrarSesion"><i class="fa fa-lock"></i> Cerrar sesión</a></li>
            </ul>
            <!-- /.navbar-top-links -->
            
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                    	<li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Buscar...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                    	<li>
                            <a href="homepage.jsp"><i class="fa fa-home"></i> Home</a>
                        </li>
                       
<% // si es admin 
	if(tipo == 0){ %>                         
                          <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                            </div>
                            <!-- /input-group -->
                        </li>
                       
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                   				<a href="#"><strong><i class="fa fa-user"></i> Administrador</strong></a>
                            </div>
                            <!-- /input-group -->
                        </li>     
                        <li>
                            <a href="#"><i class="fa fa-child"></i> Alumnos <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nuevo alumno</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-list-alt"></i> Registro de bajas</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-group"></i> Cursos <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="GradoList?listar=mañana"><i class="fa fa-clock-o"></i> Turno mañana</a>
                                </li>
                                <li>
                                    <a href="GradoList?listar=tarde"><i class="fa fa-clock-o"></i> Turno tarde</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-male"></i> Maestros <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                				<li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nuevo maestro</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-list-alt"></i> Registro de bajas</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-book"></i> Materias <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                       				<li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nueva materia</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa  fa-times-circle"></i> Materias inactivas</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                         <li>
                            <a href="#"><i class="fa fa-edit"></i> Tardanzas</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-comments"></i> Entrevistas <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nueva entrevista</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-money"></i> Cuotas</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-users"></i> Usuarios</a>
                        </li>
                        
 <% // si es maestro
 	}  if (tipo == 1){ 
 %>                              
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                            </div>
                            <!-- /input-group -->
                        </li>
                     
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                   				<a href="#"><strong><i class="fa fa-user"></i> Maestro</strong></a>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-list-alt"></i> Asistencias</a>
                        </li>                 
                        <li>
                            <a href="#"><i class="fa fa-calendar"></i> Citaciones<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nueva citación</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-file-text-o"></i> Sanciones<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#"><i class="fa fa-list"></i> Listado </a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-edit"></i> Nueva sanción</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-comments"></i> Entrevistas</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-clipboard"></i> Notas</a>
                        </li>
<% } %>                        
                        
                       <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                            
                            </div>
                       </li>   
                    </ul>
                </div>
                <!-- /.sidebar-collapse --> 
            </div>
            <!-- /.navbar-static-side -->
        </nav>
        
</div>
<!-- /#wrapper -->    

<!--
        <div id="page-wrapper">
 -->       
             <!-- Page Heading -->
             <!--
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Home <small>Welcome Again</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-home"></i> Home
                            </li>
                        </ol>
                    </div>
                </div>
               --> 
                <!-- /.row -->
       		
       		
       		
       		<!-- CONTENIDO DE LA PAGINA -->
       		
       		
       		
  <!--     		
        </div>
 -->        
        <!-- /#page-wrapper -->

   
    
    <!-- jQuery -->
    <script src="js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap2.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/metisMenu.min.js"></script>
	
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>

</body>

</html>
