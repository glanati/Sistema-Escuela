<%@page import="datos.Grado"%>
<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@page import="datos.Mensaje"%>
<%@page import="datos.MateriasGrado"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "grados");%>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Listado de Materias</title>
    
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
	// modulo de seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "materias_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>


	<div id="wrapper">
  		<!-- masterpage -->
  	</div>

		<%	
			MateriasGrado mat_grado = new MateriasGrado();
				
			if(session.getAttribute("materias_grado") != null) {			
				mat_grado = (MateriasGrado) session.getAttribute("materias_grado");
			}
				
			Materias materias  = (Materias) session.getAttribute("materias");		
				
			Grado grado  = (Grado) session.getAttribute("grado_materias");
		%>
		
			<div id="page-wrapper">
  		
  		<!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <%= grado.getGrado()%> <small> Turno  <%= grado.getTurno().toLowerCase() %> - Año <%= grado.getAño() %></small>
                        </h1>
                        <ol class="breadcrumb">
                        	 <li>
                               <a href="homepage.jsp"><i class="fa fa-home"></i> Home</a>
                            </li>
                            <li class="active">
                                <a href="GradoList?listar=<%= grado.getTurno().toLowerCase() %>"><i class="fa fa-clock-o"></i> Cursos turno <%= grado.getTurno().toLowerCase() %></a>
                            </li>
                            <li class="active">
                               <i class="fa fa-eye"></i> Ver Materias
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row --> 
		
				<%		
				if(mat_grado.getLista().isEmpty()){
				%>
					<!-- MENSAJE DE INFORMATIVO -->
					<%Mensaje m = AccionesMensaje.getOne(29);%>
						<div class="alert <%=m.getTipo()%>" role="alert">
						  	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					      <%=m.getMensaje()%>
					    </div>		
				<%}else{%>
				
				
					
				<div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Listado de materias asignadas
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Nombre</th>
                                            <th>&nbsp;</th>
                                        </tr>
                                    </thead>
                                  <%	
                                  	int i = 0;
									for (Materia m : mat_grado.getLista()) {
										++i;
									%>
                                    <tbody>
                                        <tr>
                                            <td><%= i %></td>
                                            <td><%= m.getMateria() %></td>
                                            <td><strong><a href="MateriaGradoList?do=desasignar&materia=<%=m.getMateria()%>" onclick="return confirm('Esta seguro que desea desasignar?');"> Desasignar</a></strong></td>
                                        </tr>        
                                    </tbody>
                                  <%
									}
									%>
                                </table>
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
					
				<%}%>
				
				<!-- <br> -->	
			<%
				if ((materias.getLista().size() - mat_grado.getLista().size()) != 0){
			%>

				<div class="row">
                	<div class="col-lg-6">
                		<div class="form-group">
                			<form action="MateriaGradoList" method="post">
                				<!--  	<label>Resto de materias</label>	-->
									<select name="materia_asignar" class="form-control">
										<%
										for (Materia m : materias.getLista()){
											
											if (!mat_grado.contains(m)){ //evita que se muestren las materias ya asignadas				
										
										%>	 			  
							   				<option value="<%= m.getMateria()%>"><%= m.getMateria() %> </option>   			  
							   			<%				
											}
								 				    			
										}			
										%>
							 		</select>

								<br>
								
								<!-- MENSAJE -->
								 <%	Mensaje mensaje;	
									if (session.getAttribute("mensaje") != null) {
										mensaje = (Mensaje) session.getAttribute("mensaje");
										session.setAttribute("mensaje", null);
								 %>
								   <div class="bs-example">
								    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
								     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								     	 <%=mensaje.getMensaje()%>
								     	 </div>
								  </div>
								  <br>
								 <%}%>
								<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%> >Asignar Materia</button>
                			
                			</form>
                		</div>
                	</div>
                	<!-- /.col-lg-6 -->
             	</div>
             	<!-- /.row -->
             	<%}%>
					

					<br> 
					<!-- 
					<div class="form-group">				
						<form action="GradoList" method="get">
							<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
						</form>
					</div>
					 -->
					 
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