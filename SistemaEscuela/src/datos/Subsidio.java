package datos;

public class Subsidio {
	private int a�o;
	private int dni;
	private boolean ind_grupo;
	private boolean ind_subsidio;
	
	public Subsidio(int a�o, int dni, boolean ind_grupo, boolean ind_subsidio) {
		this.a�o = a�o;
		this.dni = dni;
		this.ind_grupo = ind_grupo;
		this.ind_subsidio = ind_subsidio;
	}
	
	public int getA�o() {
		return a�o;
	}
	
	public int getDni() {
		return dni;
	}
	
	public boolean isInd_grupo() {
		return ind_grupo;
	}
	
	public boolean isInd_subsidio() {
		return ind_subsidio;
	}
	
	public void setDni(int dni) {
		this.dni = dni;
	}
	
}
