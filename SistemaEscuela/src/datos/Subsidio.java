package datos;

public class Subsidio {
	private int año;
	private int dni;
	private boolean ind_grupo;
	private boolean ind_subsidio;
	
	public Subsidio(int año, int dni, boolean ind_grupo, boolean ind_subsidio) {
		this.año = año;
		this.dni = dni;
		this.ind_grupo = ind_grupo;
		this.ind_subsidio = ind_subsidio;
	}
	
	public int getAño() {
		return año;
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
