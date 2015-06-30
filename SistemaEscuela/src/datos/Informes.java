package datos;

import java.util.ArrayList;

public class Informes {

	ArrayList<Informe> lista;
	
	public Informes() {
		lista = new ArrayList<Informe>();
	}
	
	public ArrayList<Informe> getLista() {
		return lista;
	}
	
	public void agregarInforme(Informe i) {
		lista.add(i);
	}
	
	public void listar() {
		for (Informe i : lista) {
			System.out.println(i);
		}
	}
	
}
