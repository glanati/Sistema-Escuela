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
<title>Reseteo de contrase�a</title>

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
                        <h3 class="panel-title">�Olvid� su contrase�a?</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="login.jsp" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" name=usuario placeholder="Ingrese su correo electr�nico" type="text" required autofocus>
                                </div>
                                <button type="submit" class="btn btn-outline btn-primary">Enviar</button>			  
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>  
            
    </div>
<br>
<br>    
     
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