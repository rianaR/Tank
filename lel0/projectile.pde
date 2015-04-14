

class Projectile {

    //Element initiaux
    public float v0;
    
    //Masse de l'objet
    public float m;

    //Etat précédent de l'objet
    public float oldTheta, oldX, oldY, oldVx, oldVy;
    
    // Etat de l'objet
    public float theta, x, y, vx, vy, v, k;

    // Elements de discretisation
    public int n, Te;

    // Paramètres environnementaux
    public static final float g = 9.81;

    // Affichage
    public Image image;
    
    public boolean launched= false;

    Projectile (float x0, float y0, float v0, float theta0, float m, Image image, int Te) {
        this.x=x0;
        this.y=y0;
        this.v0=v0;
        this.v=v0;
        this.vx = cos(theta0)*v;
        this.vy = sin(theta0)*v;
        this.theta=theta0;    
        this.image= image;
        this.k=0;
        this.Te=Te;
    }


  public void displayTrajectoire(){
    Dot d;
    Projectile p = new Projectile(x,y,v,theta,m,image,Te);
  println(theta);
    for (int i = 0; i< 1000 ; i++){
      d = new Dot(p.x,p.y);
      d.display();
      p.update();
      //System.out.println("point tracé "+ x+ " " + y+" "+n+" "+Te+" "+v+" "+vx+" "+vy);
    }  
    
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
        
        //update(image);
    }


//    public void update(Image image) {
//        image.x=x;
//        image.y=y;
//        image.angle=theta;
//    }

    private float updateX () {
      //System.out.println("x avant "+x +"theta" + oldTheta);  
      this.x = 0.5*k*cos(oldTheta)*(2*n - 1)*Te*Te+v0*cos(oldTheta)*Te+oldX;
       // System.out.println("x apres "+x);
        return x;
    }

    private float updateY () {
        this.y = 0.5*(-m*g+k*sin(oldTheta))*(2*n-1)*Te*Te+v0*sin(oldTheta)*Te+oldY;
        return y;
    }


    private float updateVx () {
        this.vx = k*cos(oldTheta)*Te+oldVx;
        return vx;
    }


    private float updateVy () {
        this.vy = (-m*g+k*sin(oldTheta))*Te+oldVy;
        return vy;
    }

    private float updateV () {
        v= cos(oldTheta)*oldVx + sin(oldTheta)*oldVy;
        return v;
    }

    private float updateTheta() {
        theta = atan(oldVy/oldVx);
        return theta;
    }
  
    //Orientation du projectile en fonction des coordonnées de la souris sur l'image  
    public void setOrientation(int mx, int my) {
        theta= atan2(my-yToDisplay(y),mx-xToDisplay(x));
    }

    public void display() {
        text("Position projectile en pixels : " + xToDisplay(x) + " "+ xToDisplay(y),600,0);
        image.display(xToDisplay(x),yToDisplay(y),theta);
        displayTrajectoire();
    }
}

