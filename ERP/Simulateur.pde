import java.util.*;

public class Simulateur {
    private Mobile mobile;
    private Observateur observateur;
    private Robot robot;
    private List<Mesure> mesures=new ArrayList<Mesure>();
    private double[] paramsMobileEstimes;
    public boolean _4mesures;

    public Simulateur() {
        this.mobile = new Mobile(300,100,0.3,0.3);
        this.observateur = new Observateur(300,250,200,0);
        this.observateur.setThetaMobile(atan2(mobile.getY()-observateur.getY(),
                                            mobile.getX()-observateur.getX()));
        //this.paramsMobileEstimes=new double[0];
    }

    public void update() {
        this.mobile.nextPos();
        this.observateur.nextPos();
        this.observateur.setThetaMobile(atan2(mobile.getY()-observateur.getY(),
                                            mobile.getX()-observateur.getX()));
    }
    
    public void displayMesuresPrises(){
      fill(0);
     text("mesures prises ="+mesures.size(),20,20); 
     if (_4mesures){
         text("Algorithme de résolution (pour epsilon nul) disponible",20,40);
     }
 }    

    public void displayMesures(){
      if (mesures !=null) {
          for (Mesure m : mesures){ 
            fill(255,0,0);
            ellipse(m.xp,m.yp,10,10);
            text("mesure : ("+m.xp+","+m.yp+")",m.xp+10,m.yp-10);
          }
      } 
    }
    
    public Mobile getMobile() {
        return this.mobile;
    }
    public Observateur getObservateur() {
        return this.observateur;
    }
    public Robot getRobot() {
        return this.robot;
    }
    
    public void addMesure(Mesure m){
        mesures.add(m);
        if (mesures.size() == 4) {
            _4mesures=true;
        }
    }

  public void drawTrajectoire(float x0, float y0,float vx, float vy){
    float coef = vy/vx;
    System.out.println(coef);
    line(x0,y0,x0+1000.0f,y0+1000.0f*coef);
  }
  
    public void calculerParamsMobile(boolean allMesures) {       
        if (_4mesures) {
            int nbMesures;
            if (allMesures) {
                nbMesures = mesures.size();
            }
            else {
                nbMesures = 4;
            }
            double[][] a = new double[nbMesures][4];
            double[] b = new double[nbMesures];
    
            for (int l=0;l<nbMesures;l++) {
                Mesure mesure = mesures.get(l);
                //x0
                a[l][0]=sin(mesure.theta);
                //vx
                a[l][1]=sin(mesure.theta)*mesure.t;
                //y0
                a[l][2]=-cos(mesure.theta);
                //vy
                a[l][3]=-cos(mesure.theta)*mesure.t;
    
                b[l]=sin(mesure.theta)*mesure.xp-cos(mesure.theta)*mesure.yp;
            }
    
            Matrix A = new Matrix(a);
            Matrix B = new Matrix(b,nbMesures);
    
            Matrix res = A.solve(B);
            System.out.println("\nCalcul\n");
    
            paramsMobileEstimes = res.getColumnPackedCopy();
        }
        
    }
    public void afficherParamsCalcules() {
        if (_4mesures) {
            
            if (paramsMobileEstimes != null) {
                text("x0 = "+paramsMobileEstimes[0]+
                    "; vx = "+paramsMobileEstimes[1]+
                    "; y0 = "+paramsMobileEstimes[2]+
                    "; vy = "+paramsMobileEstimes[3],20,60); 
            }
        }
    }

}
