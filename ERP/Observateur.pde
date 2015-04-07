public class Observateur {
    private float x, y;
    private float x0, y0;
    private float thetaMobile;
    private float rayon;
    private float rotationStep=PI/120;
    
    
    
    public Observateur(float x0, float y0, float rayon, float theta0) {
        this.x0=x0;
        this.y0=y0;
        this.rayon=rayon;
        this.x=x0+rayon;
        this.y=y0;
       drawCircle();
        this.thetaMobile=theta0;
    }

    public void setThetaMobile(float thetaMobile) {
        this.thetaMobile=thetaMobile;
    }
    
    public float getX0() {
        return x0;
    }
    public float getY0() {
        return y0;
    }
    
    public float getX() {
        return x;
    }
    public float getY() {
        return y;
    }
    public float getRayon() {
        return rayon;    
    }
    public float getThetaMobile() {
        return thetaMobile;
    }

    public void drawCircle() {
      
      ellipseMode(CENTER);  // Set ellipseMode to CENTER
      fill(255);  // Set fill to gray
      ellipse(x0,y0,2*rayon,2*rayon);  // Draw gray ellipse using CENTER mode
    }


  
    public void nextPos() {
        float oldX=x;
        float oldY=y;
        x=cos(rotationStep)*(oldX-x0)-sin(rotationStep)*(oldY-y0) + x0;
        y=sin(rotationStep)*(oldX-x0)+cos(rotationStep)*(oldY-y0) + y0;
    }
}
