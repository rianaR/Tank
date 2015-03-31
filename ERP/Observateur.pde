public class Observateur {
    private int x, y;
    private float theta,rayon;
    private static final float rotationStep=QUARTER_PI/3;
    public Observateur(int x0, int y0, float rayon, float theta0) {
        this.x=x0;
        this.y=y0;
        this.rayon=rayon;
        this.theta=theta0;
    }

    public void setTheta(float theta) {
        this.theta=theta;
    }
    
    public int getX() {
        return x;
    }
    public int getY() {
        return y;
    }
    public float getRayon() {
        return rayon;    
    }
    public float getTheta() {
        return theta;
    }

    public void calculerPos() {
        x=cos(rotationStep)*x-sin(rotationStep)*y;
        y=sin(rotationStep)*x+cos(rotationStep)*y;
    }
}
