

class Projectile {

    //Element initiaux
    public float v0;

    //Masse de l'objet
    public float m;

    //Etat précédent de l'objet
    public float oldTheta, oldX, oldY, oldVx, oldVy;

    // Etat de l'objet
    public float theta,theta0, x, y, vx, vy, v, k,Te;


    // Elements de discretisation
    public int n;

    // Paramètres environnementaux
    public static final float g = 9.81;


    public boolean launched= false;

    Projectile (float x0, float y0, float v0, float theta0, float m, float Te) {
        this.x=x0;
        this.y=y0;
        this.v0=v0;
        this.v=v0;
        this.vx = cos(theta0)*v;
        this.vy = sin(theta0)*v;
        this.theta0 = theta0;
        this.theta=theta0;    
        this.k=0;
        this.Te=Te;
        this.m = m;
    }



    public void setK ( float k) {
        this.k=k;
    }
    
/*
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
*/

/*
    private float updateX () {

        //System.out.println("x avant "+x +"theta" + oldTheta);  
        oldX=x;
        this.x = 0.5*k*cos(oldTheta)*(2*n - 1)*Te*Te+v0*cos(theta0)*Te+oldX;
        // System.out.println("x apres "+x);
        
        return x;
    }

    private float updateY () {
        oldY= y;
        //println("y = "+ y+ "   oldTheta "+ oldTheta + " m"+m+"  Te "+Te+"  k"+k+"  n "+n);
        //println(" n="+n+" lel " +((-m*g+k*sin(oldTheta))*(2*n-1)*Te*Te));
        this.y = 0.5*(-m*g+k*sin(oldTheta))*(2*n-1)*Te*Te+v0*sin(theta0)*Te+oldY;

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
*/
    private float updateTheta() {
        if (oldVx!=0)
            theta = atan(oldVy/oldVx);
        else if (oldVy !=0)
            theta = ((oldVy)/abs(oldVy))*(PI/2);
        else
            theta = -PI/2;
        return theta;
    }
    
    
   

    public void update(){
       float [][] xTab = {{x},{vx},{y},{vy}};
    Matrix X = new Matrix(xTab);
    
    float [][] aTab = {
                       {1,Te,0,0 },
                       {0,1 ,0,0 },
                       {0,0 ,1,Te},
                       {0,0 ,0,1 }                       
                    };
    Matrix A = new Matrix(aTab);
    
    float eps = v0/m;
    
    float [][] bTab = {{eps*Te*Te/2,0},{eps*Te,0},{0,eps*Te*Te/2},{0,eps*Te}};
    
    Matrix B = new Matrix(bTab);
    
    float [][] unTab = {{0},{-g/eps}};
    
    Matrix Un = new Matrix(unTab);
    
      X = A.times(X);
      X = X.plus(B.times(Un));
      X.show();
      this.x = X.getElementAt(0,0);
      this.y = X.getElementAt(2,0);
      this.vx = X.getElementAt(1,0);
      this.vy = X.getElementAt(3,0);
      
      updateTheta();
    }
 
}

