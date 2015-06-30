<%@page import="datos.Mensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Login</title>

<link rel="icon" href="icono/favicon.ico">

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
	
</head>
<body>

<div class="container">
    <div class="row"> 

        <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Login</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="login" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" name=usuario placeholder="Usuario" type="text" required autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="contraseña" placeholder="Contraseña" required type="password" value="">
                                </div>                             
                                <button class="btn btn-outline btn-primary" type="submit"> Ingresar</button>
                                 <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="remember-me">Recordarme
                                    </label>
                                    <a href="password_reset.jsp" class="pull-right need-help">¿Necesita ayuda? </a><span class="clearfix"></span>
                                </div>	  
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            
    </div>
<br>
<br>    
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
<br>
 <%}%>
     
</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	
	<!-- jQuery -->
    <script src="js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap2.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/metisMenu.min.js"></script>
	
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>