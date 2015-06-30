<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding ="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "grados");%>

<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Listado de Cursos</title>
    
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
	if (AccionesUsuario.validarAcceso(tipo, "grado_tarde_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

		 
	Grados grados = (Grados)session.getAttribute("grados_alta");
	Grados gradosp = (Grados)session.getAttribute("grados_pendientes"); //aca debe ser grados pendiente mañana
	session.removeAttribute("grado_edit");
%>

	<div id="wrapper">
  		<!-- masterpage -->
  	</div>
  	
        <div id="page-wrapper">
                 
            <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Cursos <small> Turno mañana</small>
                        </h1>
                        <ol class="breadcrumb">
                        	 <li>
                               <a href="homepage.jsp"><i class="fa fa-home"></i> Home</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-clock-o"></i> Cursos Turno mañana
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

				<%   
				if (grados.getListaTM().isEmpty()){
				%> 
				<br>
				  	<%Mensaje m = AccionesMensaje.getOne(26);%>
					<!-- MENSAJE INFORMATIVO -->
				     <div class="bs-example">
				    	<div class="alert <%=m.getTipo()%> fade in" role="alert">
				     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				     	 <%=m.getMensaje()%> <a href="GradoEdit?do=alta" class="alert-link"> Nuevo curso <i class="fa fa-edit"></i></a>
				  	  	</div>
				  	</div>
				<%}else{%>
				
				<!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                     <!--
                        <div class="panel-heading">
                            Grilla
                        </div>
                   	 -->  
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Grado</th>				
											<th>Tipo</th>
											<th>Evaluación</th>
											<th>Salón</th>
											<th>Maestro Titular</th>
											<th>Maestro Paralelo</th>
											<th>Ciclo Lectivo</th>
											<th>Materias</th>
											<th>Promoción</th>
											<th>&nbsp;</th>
                                        </tr>
                                    </thead>
								<% 
									for (Grado g : grados.getListaTM()) {
									
									Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
									Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());
									
									int dni1=1;			
									if(m1 != null) dni1=m1.getDni();
										
									String ciclo = "No hay alumnos cargados";
									int año = AccionesGrado.getCurrentYear(g);
									
									if (año != 0){		
										ciclo = Integer.toString(año);
									}												
								%>
								<tbody>
								<tr class="odd gradeX">
									<td><%= g.getGrado() %></td>		
									<td><%= g.getEvaluacionNombre() %></td>
									<td><%= g.getPeriodo() %></td>
									<td><%= g.getSalon() %></td>
									<%if (m1 != null){ %> 
									<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
									<%}else{%>
									<td class="warning"> No hay maestro asignado <i class="fa fa-warning"></i></td>
									<%}%>
									<%if (m2 != null){ %> 
									<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
									<%}else{%>
									<td class="warning"> No hay maestro asignado <i class="fa fa-warning"></i></td>
									<%}%>
									<td><%= ciclo %></td>		
									<%if(g.getGrado().equals("Sala 4") || g.getGrado().equals("Sala 5")){%>
									<td class="info">Grado con áreas de trabajo <i class="fa fa-exclamation"></i></td>
									<%}else{
									 if (año == 0){%>		
									<td class="warning"> Debe asignar alumnos primero <i class="fa fa-warning"></i></td>
									<%}else{ 
									if(dni1 == 1){%>
									<td class="warning"> Debe asignar Maestro titular primero <i class="fa fa-warning"></i></td>
									<%}else{%>		
									<td><strong><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_año=<%=año%>" ><i class="fa fa-eye"></i> Ver Materias</a></strong></td>
									<%}}}%>
									<% if ((g.getGrado().equals("7mo") || año == 0) || m1 == null){%>
									<td class="warning">No se puede promocionar</td>
									<%}else{ %>
									<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&año=<%=año%>" onclick="<%="return confirm('Esta seguro que desea promocionar "+  g.getGrado() + "-" + g.getTurno()  +"?');"%>"><strong>Promocionar</strong></a></td>		
									<% } %>	
									<td><strong><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>"><i class="fa fa-pencil"></i> Editar</a></strong></td>			
								</tr>
								<tbody>
								<%	 
									}	
								%>
							</table>
							 <%
							 	}
							 %>
							</div>
                            <!-- /.table-responsive -->
                       </div>
                        <!-- /.panel-body -->     
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->

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
  </div>
 <%}%>
<% if (!gradosp.getLista().isEmpty() && !grados.getListaTM().isEmpty()){ %>
<br>
    <p><strong><a href="GradoEdit?do=alta"><i class="fa fa-edit"></i> Nuevo Curso</a></strong></p>
<%}else if (gradosp.getLista().isEmpty() && !grados.getListaTM().isEmpty() ){%>
<br>
	<%Mensaje m1 = AccionesMensaje.getOne(27);%>
	<!-- MENSAJE INFORMATIVO -->
     <div class="bs-example">
    	<div class="alert <%=m1.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m1.getMensaje()%>
  	  	</div>
  	</div>
<%}%>

	</div>
	<!-- /#page-wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap2.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/metisMenu.min.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="js/jquery.dataTables.min.js"></script>
    <script src="js/dataTables.bootstrap.min.js"></script>
	
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>
    
    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
                responsive: true
        });
    });
    </script>
    
    <!-- menú superior -->
	<script src="js/load-masterpage.js"></script> 
	
</body>
</html>