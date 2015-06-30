		 	$(function () {
			    
		 		//$("#guardar").tooltip();
		 		
		 		//fecha de alumno
		 		var fecha = document.getElementById('fecha1').value; 		
		 		var myDate = new Date();
		 		var prettyDate = prettyDate = ('0' + myDate.getDate()).slice(-2) + '/' + ('0' + (myDate.getMonth()+1)).slice(-2) + '/' + myDate.getFullYear();
		 		
		 		if (fecha != 0){		 			
		 			 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 				 		
		 		$("#datepicker").val(prettyDate);
		 		
		 		$("#datepicker").datepicker({
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de tutor		 		
		 		fecha = document.getElementById('fecha2').value;		 		
		 		//prettyDate;
		 		
		 		prettyDate = "";
		 		
		 		if (fecha != 0){		 		
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 				 		
		 		$("#datepicker2").val(prettyDate);
		 		
		 		$("#datepicker2").datepicker({		 			
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de madre		 		
		 		fecha = document.getElementById('fecha3').value;		 		
		 		//prettyDate;
		 		
		 		prettyDate = "";
		 		
		 		if (fecha != 0){		 		
			 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 						
		 				 		
		 		$("#datepicker3").val(prettyDate);
		 		//$("#datepicker3").val();		 		
		 		
		 		$("#datepicker3").datepicker({
		 		   defaultDate: '01-01-0001',
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de ingreso		 		
		 		fecha = document.getElementById('fecha4').value;		 		
		 		//prettyDate;
		 		
		 		prettyDate = "";
		 		
		 		if (fecha != 0){		 		
			 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}	 		
		 				 		
		 		$("#datepicker4").val(prettyDate);
		 		
		 		$("#datepicker4").datepicker({
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});


		});