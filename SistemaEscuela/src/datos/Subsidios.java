package datos;

import java.util.ArrayList;

public class Subsidios {
	
	ArrayList<Subsidio> lista;
	
	public Subsidios() {
		lista = new ArrayList<Subsidio>();
	}
	
	public ArrayList<Subsidio> getLista() {
		return lista;
	}
	
	public void agregarSubsidio(Subsidio s) {
		lista.add(s);
	}
	
	public void listar() {
		for (Subsidio s : lista) {
			System.out.println(s);
		}
	}
}
