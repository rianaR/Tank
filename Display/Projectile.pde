import java.util.*;

class Projectile {

  //Element initiaux
  public float v0;

  //Masse de l'objet
  public float m;

  //Etat précédent de l'objet
  public float oldTheta; 
  public float oldX, oldY, oldVx, oldVy;

  // Etat de l'objet
  public float theta, theta0, x, y, vx, vy, v, k, Te, eps;

  public Matrix a;
  public  int iterator = 0;

  public Target target;

  // Elements de discretisation
  public int n;

  // Paramètres environnementaux
  public static final float g = 9.81;


  public  Matrix X, X0, A, B, Un;

  public int nbPeriodes=15;


  public boolean manuel= true;

  Projectile (float x0, float y0, float v0, float theta0, float m, float Te, boolean manuel) {
    this.manuel=manuel;
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
    // coefficient de poussé 
    //eps = v0/m;
    eps=1;
    text("X0 : +"+x0+" "+vx+" "+y+" "+vy, 10, 100);

    double[][]  xTab = {
      {
        x
      }
      , {
        vx
      }
      , {
        y
      }
      , {
        vy
      }
    };
    X0 = new Matrix(xTab);


    double[][] bTab = {
      {
        eps*Te*Te/2, 0
      }
      , {
        eps*Te, 0
      }
      , {
        0, eps*Te*Te/2
      }
      , {
        0, eps*Te
      }
    };
    B = new Matrix(bTab);
    //B.print(4,3);

    setBoucle();
  }


  public void setTarget(Target target) {
    this.target= target;
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
    if (vx!=0)
      theta = atan(vy/vx);
    else if (vy !=0)
      theta = ((vy)/abs(vy))*(PI/2);
    else
      theta = -PI/2;
    return theta;
  }

  public void setBoucle() {

    Matrix G = new Matrix(4, 2*nbPeriodes);

    double[][] aTab = {
      {
        1, Te, 0, 0
      }
      , 
      {
        0, 1, 0, 0
      }
      , 
      {
        0, 0, 1, Te
      }
      , 
      {
        0, 0, 0, 1
      }
    };

    Matrix aP = new Matrix(aTab);
    Matrix A = new Matrix(aTab);
    Matrix aPbD= new Matrix(4, 4);
    //aP.print(4,3);
    //B.print(4,2);
    for (int i=2*nbPeriodes-4; i>=0; i-=2) {

      for (int j=0; j<4; j++) {
        aPbD = aP.times(B);
        G.set(j, i, aPbD.get(j, 0));
        G.set(j, i+1, aPbD.get(j, 1));
      }

      //println(i);
      // aP.print(4,3);
      aP=aP.times(A);
      //aPbD.print(4,2);
    }
    for (int j=0; j<4; j++) {

      aPbD = aP.times(B);
      G.set(j, 2*nbPeriodes-2, B.get(j, 0));
      G.set(j, 2*nbPeriodes-1, B.get(j, 1));
    }

    //  G.print(4,3);


    Matrix U = new Matrix(2, nbPeriodes);

    double [][] cTab = {
      {
        20
      }
      , {
        0
      }
      , {
        1
      }
      , {
        0
      }
    };
    Matrix C = new Matrix(cTab);

    Matrix Y = C.minus(aP.times(X0));
    //Y.print(4,3);

    //G.print(4,3);
    Matrix Gt = G.transpose();
    //Gt.print(4,2);
    U = (Gt.times((G.times(Gt)).inverse())).times(Y);

    a = U;
    //U.print(4,3);
    /*
      for(int j=0;j<a.getRowDimension();j+=2){
     a.set(j,0,a.get(j,0)-g/eps);
     } */


    //a.print(4,3);

    /*
        double[][] provTab ={
     { 67.5},                 
     { - 65.9090909090908923},  
     {50.8333333333333428  },
     {- 54.1515151515151487  },
     { 34.1666666666666714  },
     {- 42.3939393939393838  },
     {  17.4999999999999822},  
     {- 30.6363636363636154  },
     {0.83333333333330195  },
     {- 18.8787878787878576  },
     {- 15.8333333333333712  },
     {- 7.12121212121208558  },
     {- 32.5000000000000355  },
     { 4.6363636363636616   },
     {- 49.1666666666667140  },
     { 16.3939393939394265  },
     {- 65.8333333333333854  },
     { 28.1515151515151700  },
     {- 82.5000000000000568},  
     {39.909090909090942 }
     
     };
     
     a = new Matrix(provTab);
     */
  }




  // Application of the formula Xn+1 = A Xn + Ba
  // With A defined in the constructor
  // B
  public void update() {

    double[][]  xTab = {
      {
        x
      }
      , {
        vx
      }
      , {
        y
      }
      , {
        vy
      }
    };
    X = new Matrix(xTab);


    if (manuel) {
      double[][] unTab = {
        {
          0
        }
        , {
          -g/eps
        }
      };
      Un = new Matrix(unTab);
    }
    //a.print(4,2);
    else {
      double[][] unTab = new double[2][1];
      if (2*iterator < a.getRowDimension()) {
        unTab[0][0] = a.get(2*iterator, 0);
        unTab[1][0] =a.get(2*iterator+1, 0);//-g/eps;
      }
      Un = new Matrix(unTab);
    }



    //Un = a;
    println(iterator);
    iterator++;
    Un.print(4, 2);

    double[][] aTab = {
      {
        1, Te, 0, 0
      }
      , 
      {
        0, 1, 0, 0
      }
      , 
      {
        0, 0, 1, Te
      }
      , 
      {
        0, 0, 0, 1
      }
    };
    A = new Matrix(aTab);

    X = A.times(X);
    X = X.plus(B.times(Un));

    /*
      float [][] kTab = {
     {1,0,0,0},          
     {0,1,0,0},
     };
     
     float [][] cTab = { {20},{0},{1},{0}};
     Matrix C = new Matrix(cTab);
     Matrix K = new Matrix(kTab);
     
     Matrix _1em = (A.minus(B.times(K))).times(X);
     
     Matrix _2em = (B.times(K)).times(C);
     
     float[][] aTab = {{0},{-g/eps}};
     Matrix a = new Matrix(aTab);
     Matrix _3em = (B.times(a));
     
     X = (_1em.plus(_2em)).minus(_3em);
     */

    //X.show();
    this.x = (float)X.get(0, 0);
    this.y = (float)X.get(2, 0);
    this.vx = (float)X.get(1, 0);
    this.vy = (float)X.get(3, 0);

    updateTheta();
  }
}

