

class Projectile {

    //Element initiaux
    public float v0;
    
    //Masse de l'objet
    public float m;

    //Etat précédent de l'objet
    public float oldTheta, oldX, oldY, oldVx, oldVy;
    
    // Etat de l'objet
    public float theta, x, y, vx, vy, v, k,Te;

    // Elements de discretisation
    public int n;

    // Paramètres environnementaux
    public static final float g = 9.81;

    
    public boolean launched= false;

    Projectile (float x0, float y0, float v0, float theta0, float m,float Te) {
        this.x=x0;
        this.y=y0;
        this.v0=v0;
        this.v=v0;
        this.vx = cos(theta0)*v;
        this.vy = sin(theta0)*v;
        this.theta=theta0;    
        this.k=0;
        this.Te=Te;
        this.m = m;
    }


  
    public void setK ( float k) {
        this.k=k;
    }

    public void update () {
        this.oldX=x;
        this.oldY=y;
        this.oldVx=vx;
        this.oldVy=vy;
        this.oldTheta=theta;
        updateX();
        updateY();
        updateVx();
        updateVy(); 
        updateV();
        updateTheta();
        n++;
        
    }


    private float updateX () {
      //System.out.println("x avant "+x +"theta" + oldTheta);  
      oldX=x;
      this.x = 0.5*k*cos(oldTheta)*(2*n - 1)*Te*Te+v0*cos(oldTheta)*Te+oldX;
       // System.out.println("x apres "+x);
        return x;
    }

    private float updateY () {
      oldY= y;
      //println("y = "+ y+ "   oldTheta "+ oldTheta + " m"+m+"  Te "+Te+"  k"+k+"  n "+n);
      //println(" n="+n+" lel " +((-m*g+k*sin(oldTheta))*(2*n-1)*Te*Te));
        this.y = 0.5*(-m*g+k*sin(oldTheta))*(2*n-1)*Te*Te+v0*sin(oldTheta)*Te+oldY;
        //println("y' = "+ y);
        return y;
    }


    private float updateVx () {
      oldVx = vx;
        this.vx = k*cos(oldTheta)*Te+oldVx;
        return vx;
    }


    private float updateVy () {
      oldVy = vy;
        this.vy = (-m*g+k*sin(oldTheta))*Te+oldVy;
        return vy;
    }

    private float updateV () {
        v= cos(oldTheta)*oldVx + sin(oldTheta)*oldVy;
        return v;
    }

    private float updateTheta() {
      if (oldVx!=0)
        theta = atan(oldVy/oldVx);
      else if (oldVy !=0)
        theta = ((oldVy)/abs(oldVy))*(PI/2);
       else
         theta = -PI/2;
        return theta;
    }
  

}
