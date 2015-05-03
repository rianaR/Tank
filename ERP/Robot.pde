import java.util.*;

class Robot {


  //Masse de l'objet
  public float m;

  // Etat de l'objet
  public float theta,x, y, vx, vy, v, k, Te, eps;

  public Matrix a;
  public  int iterator = 0;

  public float xMobile,yMobile;


  // Paramètres environnementaux
  public static final float g = 9.81;


  public  Matrix X, X0, A, B, Un;

  public int nbPeriodes;


  public boolean manuel= true;

  Robot (float x0, float y0,float Te, int nbPeriode,Mobile mobile) {
    this.manuel=manuel;
    this.x=x0;
    this.y=y0;
    
    this.nbPeriodes=nbPeriode;
    this.Te=Te;
    //this.m = m;
    // coefficient de poussé 
    //eps = v0/m;
    eps=1;
    text("X0 : +"+x0+" "+vx+" "+y+" "+vy, 10, 100);

    double[][]  xTab = {
      {
        x
      }
      , {
        0
      }
      , {
        y
      }
      , {
        0
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

    xMobile = mobile.getX()+mobile.getVx()*Te*nbPeriode;
    yMobile = mobile.getY()+mobile.getVy()*Te*nbPeriode;


    setBoucle();
    
  }


  


  public void setK ( float k) {
    this.k=k;
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
G.print(4,3);
      //println(i);
      // aP.print(4,3);
      aP=aP.times(A);
      //aPbD.print(4,2);
    }
    for (int j=0; j<4; j++) {

      aPbD = aP.times(B);
      
      //B.print(4,3);
      G.set(j, 2*nbPeriodes-2, B.get(j, 0));
      G.set(j, 2*nbPeriodes-1, B.get(j, 1));
    }

    //  G.print(4,3);


    Matrix U = new Matrix(2, nbPeriodes);

    double [][] cTab = {
      {
        xMobile
      }
      , {
        0
      }
      , {
        yMobile
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


  }



  public void update() {


    
      double[][] unTab = new double[2][1];
      if (2*iterator < a.getRowDimension()) {
        unTab[0][0] = a.get(2*iterator, 0);
        unTab[1][0] =a.get(2*iterator+1, 0);//-g/eps;
      }
      else{
       vx=0;
       vy=0; 
      }

      Un = new Matrix(unTab);
    

      
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



    this.x = (float)X.get(0, 0);
    this.y = (float)X.get(2, 0);
    this.vx = (float)X.get(1, 0);
    this.vy = (float)X.get(3, 0);

  }
  
  
  public void display() {
        fill(0,255,0);
        rect(x, y, 10, 10);
        text(iterator,x+10,y+10);
        ellipse(xMobile,yMobile,10,10);
    }
}

