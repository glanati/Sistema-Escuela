package controlador;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesCertificado;
import conexion.AccionesCitacion;
import conexion.AccionesCuota;
import conexion.AccionesEstado;
import conexion.AccionesGrado;
import conexion.AccionesMensaje;
import conexion.AccionesNota;
import conexion.AccionesPadre;
import conexion.AccionesPlanPago;
import conexion.AccionesSancion;
import conexion.AccionesTardanza;
import conexion.AccionesUsuario;
import datos.Alumno;
import datos.Alumno_Grado;
import datos.Alumnos_Grados;
import datos.Certificado;
import datos.Certificados;
import datos.Citacion;
import datos.Citaciones;
import datos.Cuota;
import datos.Cuotas;
import datos.EstadoAlumno;
import datos.EstadoAlumnos;
import datos.Informe;
import datos.Informes;
import datos.Nota;
import datos.Notas;
import datos.Observacion;
import datos.Observaciones;
//import datos.EstadoAlumno;
import datos.Padre;
import datos.PagoPlanPago;
import datos.PagosPlanPago;
import datos.PlanPago;
import datos.PlanPagos;
import datos.Sancion;
import datos.Sanciones;
import datos.Subsidio;
import datos.Subsidios;
import datos.Tardanza;
import datos.Tardanzas;

/**
 * Servlet implementation class AlumnoEdit
 */
public class AlumnoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumnoEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		try {
			
			String accion = request.getParameter("do");
			
			//System.out.println("AlumnoEdit goGet= " + accion);
			
			int año = (Integer) sesion.getAttribute("añoAlumno");
			Integer dni_alum = Integer.valueOf(request.getParameter("dni_alum"));
						
			Alumno alumno = AccionesAlumno.getOne(dni_alum.intValue(),año);			
							
			switch(accion){
			
			case "alta":
				
				if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_edit.jsp");
				dispatcher.forward(request, response);
				
				break;
			
			case "modificar":
				
				if (AccionesUsuario.validarAcceso(tipo, "AlumnoEdit") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesPadre") != 1){							
					response.sendRedirect("Login");						
				}
				
				Padre tutor = AccionesPadre.getOne(alumno.getDni_tutor());								
				Padre madre = AccionesPadre.getOne(alumno.getDni_madre());
				
				String fecha = AccionesEstado.getFechaIngreso(alumno.getDni());
											
				String año_sys = (String)sesion.getAttribute("año_sys");
				String mes_sys = (String)sesion.getAttribute("mes_sys");
				String dia_sys = (String)sesion.getAttribute("dia_sys");
				
		        // Crear 2 instancias de Calendar
				Calendar fecha_dia = Calendar.getInstance();
				Calendar fecha_alumno = Calendar.getInstance();
												 
				// Establecer las fechas
				fecha_dia.set(Integer.parseInt(año_sys),Integer.parseInt(mes_sys),Integer.parseInt(dia_sys));
				fecha_alumno.set(Integer.parseInt(fecha.substring(0,4)), Integer.parseInt(fecha.substring(5,7)),Integer.parseInt(fecha.substring(8,10)));
			
				// calcular la diferencia en milisengundos
				long milis1 = fecha_dia.getTimeInMillis();
				long milis2 = fecha_alumno.getTimeInMillis();
					 
				// calcular la diferencia en milisengundos
				long diff = milis1 - milis2;
				
		        // calcular la diferencia en dias
				Integer diffDays = (int) (diff / (24 * 60 * 60 * 1000));
				
				request.setAttribute("tutor", tutor);				
				request.setAttribute("madre", madre);
				request.setAttribute("alumno", alumno);
				request.setAttribute("diasAlta", diffDays);
				request.setAttribute("fecha_ingreso", fecha);
				
				//System.out.println("diffDays= " + diffDays);
																		
				dispatcher = getServletContext().getRequestDispatcher("/alumno_edit.jsp");
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":
							
				if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
					response.sendRedirect("Login");						
				}
				
				
				año_sys = (String)sesion.getAttribute("año_sys");
				mes_sys = (String)sesion.getAttribute("mes_sys");
				dia_sys = (String)sesion.getAttribute("dia_sys");
				String fecha_sys = año_sys + "-" + mes_sys + "-" + dia_sys;
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesEstado") != 1){							
					response.sendRedirect("Login");						
				}
				
				AccionesEstado.desactivarAlumno(dni_alum, fecha_sys);				
				
				request.setAttribute("accion","listarAlumnos");
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(19));
				
				dispatcher = getServletContext().getRequestDispatcher("/AlumnoList");
				dispatcher.forward(request, response);
				
				break;
				
			case "promocion":
				
				if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				AccionesAlumno.promGrado(dni_alum, año);
				
				request.setAttribute("accion","listarAlumnos");
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(20));
				
				dispatcher = getServletContext().getRequestDispatcher("/AlumnoList");
				dispatcher.forward(request, response);
				
				break;

			case "repeticion":
				
				if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				AccionesAlumno.repetirGrado(dni_alum, año);
			
				request.setAttribute("accion","listarAlumnos");
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(21));
				dispatcher = getServletContext().getRequestDispatcher("/AlumnoList");
				dispatcher.forward(request, response);
			
				break;

			} 
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			
			sesion.setAttribute("mensaje",AccionesMensaje.getOne(14));
			response.sendRedirect("alumno_list.jsp");
			
		} catch (Exception e) {
			
			e.printStackTrace();
			//sesion.setAttribute("error", e.toString());
			//response.sendRedirect("alumno_edit.jsp");
		} 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
			response.sendRedirect("Login");						
		}
		
		String redirect = "/AlumnoList";
		
		try {
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1 &&
				AccionesUsuario.validarAcceso(tipo, "AccionesGrado")  != 1 &&
				AccionesUsuario.validarAcceso(tipo, "AccionesCertificado") != 1 &&
				AccionesUsuario.validarAcceso(tipo, "AccionesEstado") != 1 &&
				AccionesUsuario.validarAcceso(tipo, "AccionesPadre")  != 1){
				
				response.sendRedirect("Login");						
			}
			
			int año = 0;
			
			String año_ing = request.getParameter("año_ing");			
			
			if (año_ing == null){
				año_ing = String.valueOf(sesion.getAttribute("añoAlumno"));
			}
			
			sesion.setAttribute("año_ing", Integer.parseInt(año_ing));		
					
			if (sesion.getAttribute("añoAlumno") != null){
				año = (Integer) sesion.getAttribute("añoAlumno");	//año desde menu_alumno	
			}else{				
				
				//año = AccionesAlumno.getAñoAlumnos("MAX");	//año para nuevo alumno directo
				
				//if(año == 0){
					//año = (Integer) sesion.getAttribute("año"); //año de sistema
				//}
				año = Integer.parseInt(año_ing);
			}
				
			int dni_alum = Integer.parseInt((String)request.getParameter("dni_alum"));
			
			int dni_actual = 0;
			if (request.getParameter("dni_actual") != null){
				dni_actual = Integer.valueOf(request.getParameter("dni_actual"));
			}						
			// DATOS ALUMNO
			String apellido_alum = request.getParameter("apellido_alum");
			String nombre_alum = request.getParameter("nombre_alum");
			String lugar_nac_alum = request.getParameter("lugar_nac_alum");				
		
			String fecha_nac_alum = request.getParameter("fecha_nac_alum");			
			fecha_nac_alum = fecha_nac_alum.substring(6,10) +"-"+ fecha_nac_alum.substring(3,5) +"-"+ fecha_nac_alum.substring(0,2);
		
			
			String domicilio_alum = request.getParameter("domicilio_alum");
			String telefono_alum = request.getParameter("telefono_alum");
			String esc = request.getParameter("esc");
			String ind_grupo = request.getParameter("ind_grupo");
			String ind_subsidio = request.getParameter("ind_subsidio");
	
			//DATOS PADRE O TUTOR
			String apellido_tutor = request.getParameter("apellido_tutor");
			String nombre_tutor = request.getParameter("nombre_tutor");
			String lugar_nac_tutor = request.getParameter("lugar_nac_tutor");
			
			String fecha_nac_tutor = request.getParameter("fecha_nac_tutor");			
			fecha_nac_tutor = fecha_nac_tutor.substring(6,10) +"-"+ fecha_nac_tutor.substring(3,5) +"-"+ fecha_nac_tutor.substring(0,2);
			
			String dni_tutor_st = request.getParameter("dni_tutor");
			// en caso de no pasar un dni, se le asigna un 0 (para solucionar el problema de la pk con la tabla padres)
			int dni_tutor = 0;
			//verifica que no se pase una cadena vacia
			if ((dni_tutor_st != null) && (!dni_tutor_st.equals(""))) {
				dni_tutor = Integer.parseInt(request.getParameter("dni_tutor"));
			}
			
			String domicilio_tutor = request.getParameter("domicilio_tutor");
			String telefono_tutor = request.getParameter("telefono_tutor");
			String ocupacion_tutor = request.getParameter("ocupacion_tutor");
			String dom_lab_tutor = request.getParameter("dom_lab_tutor");
			String telefono_lab_tutor = request.getParameter("telefono_lab_tutor");
			String est_civil_tutor = request.getParameter("est_civil_tutor");
									
			//DATOS MADRE
			String apellido_madre = request.getParameter("apellido_madre");
			String nombre_madre = request.getParameter("nombre_madre");
			String lugar_nac_madre = request.getParameter("lugar_nac_madre");
			
			String fecha_nac_madre = request.getParameter("fecha_nac_madre");					
			fecha_nac_madre = fecha_nac_madre.substring(6,10) +"-"+ fecha_nac_madre.substring(3,5) +"-"+ fecha_nac_madre.substring(0,2);			
			
			String dni_madre_st = request.getParameter("dni_madre");
			// en caso de no pasar un dni, se le asigna un 0 (para solucionar el problema de la pk con la tabla padres)
			int dni_madre = 0;
			// verifica que no se pase una cadena vacia
			if ((dni_madre_st != null) && (!dni_madre_st.equals(""))) {
				dni_madre = Integer.parseInt(request.getParameter("dni_madre"));
			}
			
			String domicilio_madre = request.getParameter("domicilio_madre");
			String telefono_madre = request.getParameter("telefono_madre");
			String ocupacion_madre = request.getParameter("ocupacion_madre");
			String dom_lab_madre = request.getParameter("dom_lab_madre");
			String telefono_lab_madre = request.getParameter("telefono_lab_madre");
			String est_civil_madre = request.getParameter("est_civil_madre");
				
			//HERMANOS
			int cant_her_may = Integer.parseInt(request.getParameter("cant_her_may"));
			int cant_her_men = Integer.parseInt(request.getParameter("cant_her_men"));
						
			//IGLESIA
			String iglesia = request.getParameter("iglesia");
			
			//create a new padre object		
			Padre tutor = new Padre(dni_tutor, nombre_tutor, apellido_tutor, lugar_nac_tutor,
					fecha_nac_tutor, domicilio_tutor, telefono_tutor, ocupacion_tutor, dom_lab_tutor,
					telefono_lab_tutor, est_civil_tutor);
			//create a new padre(madre) object
			Padre madre = new Padre(dni_madre, nombre_madre, apellido_madre, lugar_nac_madre,
					fecha_nac_madre, domicilio_madre, telefono_madre, ocupacion_madre, dom_lab_madre,
					telefono_lab_madre, est_civil_madre);
			//create a new alumno object
			Alumno alumno = new Alumno(dni_alum, nombre_alum, apellido_alum, domicilio_alum, telefono_alum, 
					fecha_nac_alum, lugar_nac_alum, dni_tutor, dni_madre, cant_her_may,
					cant_her_men, iglesia, esc, ind_grupo.equals("si"),
					ind_subsidio.equals("si"));		
					
			//save the alumno to DB
			//if (!AccionesAlumno.esAlumno(dni_alum)){	//Si no esta en el sistema los datos del alumno o el dni no cambia. Es un insert
			  if (dni_actual == 0){	
			
				String fecha_insc = null;
				fecha_insc = request.getParameter("fecha_ing_alum");				
				fecha_insc = fecha_insc.substring(6,10) +"-"+ fecha_insc.substring(3,5) +"-"+ fecha_insc.substring(0,2);
				

				
				String string = "";
				String[] parts;
				String grado="", turno="";
				
				//GRADO Y TURNO AL QUE VA A INGRESAR Y AÑO ESCOLAR
				string = request.getParameter("grado_turno");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				//String turno = request.getParameter("turno");
				//String año_ing = request.getParameter("año_ing");				
				
				//insert tutor
				if (!AccionesPadre.esPadre(dni_tutor)) {	//Si no esta en el sistema los datos del tutor lo inserta. Si ya estan sus datos no hace nada.
					AccionesPadre.insertOne(tutor);
				}
				//insert madre
				if (!AccionesPadre.esPadre(dni_madre)) {	//Lo mismo con la madre.
					AccionesPadre.insertOne(madre);
				}
				//insert alumno				
				AccionesAlumno.insertOne(alumno, año);
				//lo activo
				AccionesEstado.activarAlumno(dni_alum, fecha_insc);
				//creo su lista de certificados (todos como false como valor por defecto)
				AccionesCertificado.insertOne(alumno.getDni(), año);
				//y le asigno un grado
				AccionesGrado.insertAlumnoEnGrado(grado, turno, dni_alum, Integer.parseInt(año_ing));
				
				//seteo el grado en la sesion asi me redirecciona a la lista del curso al que se inscribio
				sesion.setAttribute("grado", grado);
				sesion.setAttribute("turno", turno);
				sesion.setAttribute("año", Integer.parseInt(año_ing));
				
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(15)); //alta correcta
				
			} else {	//Si ya estan los datos del alumno, que lo modifique
				
				//en caso de modificar el grado/turno
				
				if (request.getParameter("grado_turno") != null){
					
					String string = "";
					String[] parts;
					String grado="", turno="";
					
					//GRADO Y TURNO AL QUE VA A INGRESAR Y AÑO ESCOLAR
					string = request.getParameter("grado_turno");				
					parts = string.split(" - ");				
					grado = parts[0];
					turno = parts[1];
					
					//String año_ing = request.getParameter("año_ing");					
					//sesion.setAttribute("año_ing", año_ing);
			
					if (request.getParameter("reingreso") != null){//reingreso						
						
						AccionesGrado.insertAlumnoEnGrado(grado, turno, dni_alum, Integer.parseInt(año_ing));
						
						String año_sys = (String)sesion.getAttribute("año_sys");
						String mes_sys = (String)sesion.getAttribute("mes_sys");
						String dia_sys = (String)sesion.getAttribute("dia_sys");
						String fecha_sys = año_sys + "-" + mes_sys + "-" + dia_sys;
						
						AccionesAlumno.subsidioReing(dni_alum, Integer.parseInt(año_ing));
						AccionesCertificado.insertOne(dni_alum, Integer.parseInt(año_ing));
						AccionesEstado.activarAlumno(dni_alum, fecha_sys);
						
						redirect = "/alumnoInactivo?do=listar";
						
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(16)); //reingreso correcto
						
					}else{ //Actualización de grado/turno
						AccionesAlumno.updateAlumnoGrado(dni_alum, año, grado, turno);
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(17)); //modificación correcta
					}
					
				}
				
				
				//update tutor
				AccionesPadre.updateOne(dni_tutor, nombre_tutor, apellido_tutor, lugar_nac_tutor, fecha_nac_tutor,
						domicilio_tutor, telefono_tutor, ocupacion_tutor, dom_lab_tutor, telefono_lab_tutor, est_civil_tutor);
				//update madre
				AccionesPadre.updateOne(dni_madre, nombre_madre, apellido_madre, lugar_nac_madre, fecha_nac_madre,
						domicilio_madre, telefono_madre, ocupacion_madre, dom_lab_madre, telefono_lab_madre, est_civil_madre);
				
				//System.out.println("dni_actual= " + dni_actual);
				//System.out.println("dni_alum= " + dni_alum);
				
				if (dni_actual != dni_alum){

					// inserta el alumno con el nuevo DNI
					AccionesAlumno.insertOne(alumno);
					
					//inserta subsidios con el nuevo DNI
					Subsidios subsidios = AccionesAlumno.getSubsidios(dni_actual);
					for (Subsidio s : subsidios.getLista()) {
						s.setDni(dni_alum);
						AccionesAlumno.insertSubsidio(s);
					}
					
					//inserta estados con el nuevo DNI
					EstadoAlumnos estados = AccionesEstado.getAll(dni_actual);					
					for (EstadoAlumno e : estados.getLista()) {
						e.setDni(dni_alum);
						AccionesEstado.insertEstado(e); 
					}				
					
					//inserta certificados con el nuevo DNI
					Certificados certificados = AccionesCertificado.getAllDni(dni_actual);
					for (Certificado c : certificados.getLista()) {
						c.setDni(dni_alum);
						AccionesCertificado.insertOne(c);
					}
					
					Observaciones observaciones = AccionesCertificado.getObservacionesByDni(dni_actual);
					for (Observacion o : observaciones.getLista()) {
						o.setDni(dni_alum);
						AccionesCertificado.insertObservacion(o);
					}
					
					Alumnos_Grados alumnos = AccionesAlumno.getAlumno_Grado(dni_actual);
					for (Alumno_Grado ag : alumnos.getAlumnos_Grados()) {
						ag.setDni(dni_alum);
						AccionesGrado.insertAlumnoEnGrado(ag);
					}
					
					//inserta sanciones con el nuevo DNI
					Sanciones sanciones = AccionesSancion.getAll(dni_actual);					
					for (Sancion s : sanciones.getLista()) {
						s.setDni(dni_alum);
						AccionesSancion.insertOne(s);			
					}	
					
					Tardanzas asistencias = AccionesTardanza.getAsistenciasDni(dni_actual);					
					for (Tardanza a : asistencias.getTardanzas()) {
						a.setDni(dni_alum);
						AccionesTardanza.altaTardanza(a);
					}
					
					//inserta tardanzas con el nuevo DNI
					Tardanzas tardanzas = AccionesTardanza.getAllTardanzasDni(dni_actual);					
					for (Tardanza t : tardanzas.getTardanzas()) {
						t.setDni(dni_alum);
						AccionesTardanza.altaTardanza(t);
					}
					
					//inserta informes con el nuevo DNI
					Informes informes = AccionesNota.getAllInformes(dni_actual);
					for (Informe i : informes.getLista()) {
						i.setDni(dni_alum);
						AccionesNota.insertInforme(i);
					}
					
					//inserta notas con el nuevo DNI
					Notas notas = AccionesNota.getNotas(dni_actual);
					for (Nota n : notas.getLista()) {
						n.setDni(dni_alum);
						AccionesNota.insertNota(n);
					}
					
					//inserta citaciones con el nuevo DNI
					Citaciones citaciones = AccionesCitacion.getAll(dni_actual);
					for (Citacion c : citaciones.getLista()) {
						c.setDni(dni_alum);						
						AccionesCitacion.insertOne(c);
					}
					
				    Cuotas cuotas = AccionesCuota.getPagosAll(dni_actual);
				    for (Cuota c : cuotas.getLista()) {
				    	c.setDni(dni_alum);
				    	AccionesCuota.insertOnePago(c);						
					}
					
					//inserta planes de pago con el nuevo DNI
					PlanPagos planes = AccionesPlanPago.getAllPlan(dni_actual);
					PagosPlanPago pagos = null;
					for (PlanPago pp : planes.getLista()) {
						pp.setDni(dni_alum);
						AccionesPlanPago.insertOnePlan(pp);
						//por cada plan reinsartado, obtener el nuevo cod_plan 
						//para luego utilizarlo para insertar los pagos
						PlanPago plan = AccionesPlanPago.getOnePlan(dni_alum, pp.getFecha(),pp.getPeriodoini(),pp.getPeriodofin());
						
						//reinserto los pagos con el nuevo codigo de plan
						pagos = AccionesPlanPago.getPagospp(pp.getCod_plan());
						for (PagoPlanPago pago : pagos.getLista()) {
							pago.setDni(dni_alum);
							pago.setCod_plan(plan.getCod_plan());
							AccionesPlanPago.insertOnePagopp(pago);
						}
						
						
					}
					/*
					//inserta pago planes de pago con el nuevo DNI
					PagosPlanPago pagos = AccionesPlanPago.getPagosAll(dni_actual);
					for (PagoPlanPago pago : pagos.getLista()) {
						pago.setDni(dni_alum);
						AccionesPlanPago.insertOnePagopp(pago);
					}
				      
				    */

				    if (pagos != null){
				    	AccionesPlanPago.deletePagosPlanPagoDni(dni_actual);
                    }
                   
				    if (planes != null){
				    	AccionesPlanPago.deletePlanPagoDni(dni_actual);
                    }
				    
				    if (cuotas != null){
				    	AccionesCuota.deletePagosDni(dni_actual);
                    }
				    
				    if (citaciones != null){
				    	AccionesCitacion.deleteAllDni(dni_actual);
                    }
				    
				    if (notas != null){
				    	AccionesNota.deleteNotasDni(dni_actual);
                    }
				    
				    if (informes != null){
				    	AccionesNota.deleteInformesDni(dni_actual);
                    }
				    
				    if (tardanzas != null){
				    	AccionesTardanza.bajaTardanzaDni(dni_actual);
                    }
				    
				    if (asistencias != null){
				    	AccionesTardanza.bajaAsistencia(dni_actual);
                    }
				    
				    if (sanciones != null){
				    	AccionesSancion.deleteAllDni(dni_actual);
                    }
				    
				    if (alumnos != null){
				    	AccionesAlumno.deleteAlumnoFromGrado(dni_actual);
                    }
				    
				    if (observaciones != null){
				    	AccionesCertificado.deleteObservaciones(dni_actual);
                    }
				    
				    if (certificados != null){
				    	AccionesCertificado.deleteAllDni(dni_actual);
                    }
				    
				    if (estados != null){
				    	AccionesEstado.deleteEstado(dni_actual);
                    }
				    
				    if (subsidios != null){
				    	AccionesAlumno.deleteSubsidioDni(dni_actual);
                    }
				    
				    AccionesAlumno.deleteOne(dni_actual);
  
				    //deleteAlumnoFromGrado
				}else{
				
					AccionesAlumno.updateOne(dni_alum, nombre_alum, apellido_alum, domicilio_alum, telefono_alum,
						fecha_nac_alum, lugar_nac_alum, dni_tutor, dni_madre, cant_her_may, cant_her_men,
						iglesia, esc, año, ind_grupo.equals("si"), ind_subsidio.equals("si"));
				}
				
				
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(18)); //modificación correcta
			}   
			
			request.setAttribute("accion","listarAlumnos");
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirect);
			dispatcher.forward(request, response);
			
		/*			
			if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
				response.sendRedirect("Login");						
			}	
			
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar todos los campos del alumno para poder registrarlo. Exception: " + e.toString());
					
			response.sendRedirect("alumno_edit.jsp");
			
		} catch (java.lang.NullPointerException e) {
			
			if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar los campos \"Escolaridad\", \"Grupo Familiar\" y \"Subsidio\". Exception: " + e.toString());
				
			response.sendRedirect("alumno_edit.jsp");
		*/	
		} catch (Exception e) {
			
			//if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
			//	response.sendRedirect("Login");						
			//}
			
			e.printStackTrace();
			//sesion.setAttribute("error", e.toString());
			//response.sendRedirect("alumno_edit.jsp");
		}
			
	}
	
	
}