		 	$(function () {
			    
		 		var anio = document.getElementById('anio').value;	 		
		 		var myDate = new Date();			 		
		 		prettyDate = ('0' + myDate.getDate()).slice(-2) + '/' + ('0' + (myDate.getMonth()+1)).slice(-2);
			 		
			 	//alert (prettyDate);
			 	
		 		var range = "'"+ anio + ":" + anio + "'";
		 		
		 		$("#datepicker").val(prettyDate);
		 		
		 		$("#datepicker").datepicker({ 		 	   
		 		   dateFormat: "dd/mm",	
  			 	   yearRange: ""+range,
 		 		   changeMonth: true,
		 		   beforeShowDay: $.datepicker.noWeekends
		 		});
		});