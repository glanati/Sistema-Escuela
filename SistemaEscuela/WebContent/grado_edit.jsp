<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesGrado"%>
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

    <title>Cursos</title>
    
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


	<%
		// modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "grado_edit.jsp") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		} 
		
	  
	  	Grado grado = (Grado) session.getAttribute("grado_edit");
	  	Grados grados = (Grados) request.getAttribute("grados_alta"); //agregado
	    Maestros maestros = (Maestros) request.getAttribute("maestros_list");
	  	Maestro titular = (Maestro)request.getAttribute("maestro_tit");
	  	Maestro paralelo = (Maestro)request.getAttribute("maestro_par"); 	
	 	
	  	int año;
	  	
	  	if (grado != null){
	  	 	año = AccionesGrado.getCurrentYear(grado.getGrado(), grado.getTurno());
	  	}else{
	  		//año = -1;
	  		año = 0;
	  	}
	
	if (grado != null){
	%>

				<!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Edición de curso <small><%= grado.getGrado() + " - Turno " + grado.getTurno().toLowerCase() %></small>
                        </h1>
                        <ol class="breadcrumb">
                        	<li>
                               <a href="homepage.jsp"><i class="fa fa-home"></i> Home</a>
                            </li>
                            <li class="active">
                                <a href="GradoList?listar=<%= grado.getTurno().toLowerCase() %>"><i class="fa fa-clock-o"></i> Cursos turno <%= grado.getTurno().toLowerCase() %></a>
                            </li>
                            <li>
                           		<i class="fa fa-edit"> </i> Edición de curso
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

	<%
	
	} else {
		String turno = (String) session.getAttribute("listar");
	%>
	
				<!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">				
                        <h1 class="page-header">
                            Alta de curso
                        </h1>
                        <ol class="breadcrumb">
                        	<li>
                               <a href="homepage.jsp"><i class="fa fa-home"></i> Home</a>
                            </li>
                            <li class="active">
                                <a href="GradoList"><i class="fa fa-clock-o"></i> Cursos turno <%= turno %></a>
                            </li>
                            <li>
                           		<i class="fa fa-edit"> </i> Alta de curso
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
	
	<% } %>
		
				<div class="form-group">
				 <form action="GradoEdit" method="post">
				<%if (grado != null){
				   	if (maestros != null){%>
					<input type="hidden" name="action" value="update">
					<%}else{%>
					<input type="hidden" name="action" value="update">
					<%
					}
				}else{%>
				<input type="hidden" name="action" value="insert">
				<%}%>
				<table class="table table-hover table-bordered">
				<% 
					if (grado == null){
				%>
					<tr>
						<td><label for="input">Grado/Turno</label></td>
						<td>
							<div class="col-xs-4">
							<select name=anio_grado_turno class="form-control" autofocus>
				<% 			
							
							for (Grado g : grados.getLista()){ %>
				
							 <option value="<%=g.getGrado() + "-" + g.getTurno()%>"><%=g.getGrado() + "-" + g.getTurno()%></option>
							   
				<%          } %>		 	   		 
				 			 </select> 
				 			 </div>
				 		</td>
					</tr>
				<%}%>
					<tr>
						<td><label for="input">Tipo de Calificación</label></td>
						<td>
							<% 
							   String ck_bim = "";
							   String ck_tri = "";			   
							   
							   if (grado != null && grado.getBimestre()) {
								   ck_bim = "checked";
							   } else {
								   ck_tri = "checked";
							   }			           
							 	
							 %>
							 <div class="col-xs-6">
								<label class="radio-inline"> 
									<input type="radio" name="bimestral" value="si" <%=ck_bim%> /> Bimestral
								</label>
								<label class="radio-inline">
									<input type="radio" name="bimestral" value="no" <%=ck_tri%>/> Trimestral
								</label>
							</div>
						</td>
					</tr>
						<tr>
						<td><label for="input">Tipo de Evaluación</label></td>
						<td>
							<% 
							   String ck_informe = "";
							   String ck_cualitaviva = "";
							   String ck_numerica = "";
							   
							   ck_informe = "checked";
							   
							   if (grado != null && grado.getEvaluacion() == 0) {
								   ck_informe = "checked";
								   ck_cualitaviva = "";
								   ck_numerica = "";
							   }
							   
							   if (grado != null && grado.getEvaluacion() == 1) {
								   ck_cualitaviva = "checked";
								   ck_informe = "";
								   ck_numerica = "";
							   }
							   
							   if (grado != null && grado.getEvaluacion() == 2) {
								   ck_informe = "";
								   ck_cualitaviva = "";
								   ck_numerica = "checked"; 
					
							   }			           
							 	
							 %>
							 <div class="col-xs-6">
							<label class="radio-inline"> 
							<input type="radio" name="evaluacion" value=0 <%=ck_informe%> /> Informe
							</label>
							<label class="radio-inline">
							<input type="radio" name="evaluacion" value=1 <%=ck_cualitaviva%>/> Cualitativa
							</label>
							<label class="radio-inline">
							<input type="radio" name="evaluacion" value=2 <%=ck_numerica%>/> Numérica
							</label>
							</div>
						</td>
					</tr>
					<tr>
						<td><label for="input">Salón</label></td>
						<td>
							<div class="col-xs-2">
							<input class="form-control" type="text" placeholder="Salón" name="salon_grado" required value="<%=grado!=null? grado.getSalon() : ""%>">
							</div>
						</td>
					</tr>
					<tr>
						<td><label for="input">Maestro Titular</label></td>
				<% if (año > 0){%>
						<td>
						<div class="col-xs-6">
						<select name="maestro_tit_grado" class="form-control">
						<% if (grado != null && titular != null){ %>
							<option value="<%= titular.getDni()%>"><%=titular.getNombre()+ " " + titular.getApellido()%> </option>
							<%
							for (Maestro m : maestros.getLista()){
								
								if (m.getDni() != titular.getDni()){ //elimina el maestro titular duplicado de la lista
							 		
				 			 %>   
				 			  
				   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
				   			  <%   			
							 	}
							}
							
						}else{
							
							for (Maestro m : maestros.getLista()){			 		
				 			%>   
				 			  
				   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
				   			 <%
							}
						}	
							 %>
							 </select>
							 </div>
				<%}else{%>
						<td class="warning">
							<div class="col-xs-6">
								<strong> Asignar alumnos antes <i class="glyphicon glyphicon-warning-sign"></i></strong>
							</div>
						</td>
				<%}%>	
					</tr>
					<tr>
						<td><label for="input">Maestro Paralelo</label></td>
				<% if (año > 0){%>
						<td>
						<div class="col-xs-6">
						<select name="maestro_par_grado" class="form-control">
						<% if (grado != null && paralelo != null){ %>
							<option value="<%= paralelo.getDni()%>"><%=paralelo.getNombre()+ " " + paralelo.getApellido()%> </option>						
							<%
							for (Maestro m : maestros.getLista()){			 	
								if (m.getDni() != paralelo.getDni()){	//elimina el maestro titular suplente de la lista
				 			 %>
				   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
				   			 <%
							 	}
							}
						}else{			
							for (Maestro m : maestros.getLista()){		
				 			 %>
				   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
				   			 <%			 
							}
						}
						%>
						</select>
						</div>
				<%}else{%>
						<td class="warning">
							<div class="col-xs-6">
								<strong> Asignar alumnos antes <i class="glyphicon glyphicon-warning-sign"></i></strong>
							</div>
						</td>
				<%}%>		 
					</tr>
				</table>
				
					<button type="submit" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="fa fa-save"></i> Guardar</button>
					<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="fa fa-remove"></i> Cancelar</button>
						
				</form>
				</div>
				
				<br>
				<%if (año == 0 && grado != null){%>
				<!-- MENSAJE DE WARNING -->
					<%Mensaje m = AccionesMensaje.getOne(28);%>
					<div class="alert <%=m.getTipo() %>" role="alert">
					  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				      <%=m.getMensaje()%> <a href="GradoEdit?do=baja" class="alert-link" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>> Borrar grado <i class="glyphicon glyphicon-trash"></i></a>
				    </div>
				<br>
				<%}%>
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