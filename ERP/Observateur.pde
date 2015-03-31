public class Observateur {
    private float x, y;
    private float x0, y0;
    private float thetaMobile;
    private int rayon;
    private static final float rotationStep=PI/12;
    public Observateur(float x0, float y0, int rayon, float theta0) {
        this.x0=x0;
        this.y0=y0;
        this.rayon=rayon;
        this.x=x0+rayon;
        this.y=y0;
       
        this.thetaMobile=theta0;
    }

    public void setThetaMobile(float thetaMobile) {
        this.thetaMobile=thetaMobile;
    }
    
    public float getX() {
        return x;
    }
    public float getY() {
        return y;
    }
    public int getRayon() {
        return rayon;    
    }
    public float getThetaMobile() {
        return thetaMobile;
    }

    public void calculerPos() {
        System.out.println("Avant : "+x+" "+y);
        x=cos(rotationStep)*(x-x0)-sin(rotationStep)*(y-y0) + x0;
        y=sin(rotationStep)*(x-x0)+cos(rotationStep)*(y-y0) + y0;
        System.out.println("Après : "+x+" "+y);
    }
}
