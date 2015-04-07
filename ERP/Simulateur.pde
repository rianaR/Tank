import java.util.*;

public class Simulateur {
    private Mobile mobile;
    private Observateur observateur;
    private Robot robot;
    private Set<Mesure> mesures=new HashSet<Mesure>();
    
    public Simulateur() {
        this.mobile = new Mobile(200,200,1,1);
        this.observateur = new Observateur(300,250,200,0);
        this.observateur.setThetaMobile(atan2(mobile.getY()-observateur.getY(),
                                            mobile.getX()-observateur.getX()));
    }

    public void update() {
        this.mobile.calculerPos();
        this.observateur.calculerPos();
        this.observateur.setThetaMobile(atan2(mobile.getY()-observateur.getY(),
                                            mobile.getX()-observateur.getX()));
    }
    
    public void displayMesuresPrises(){
      fill(0);
     text("mesures prises ="+mesures.size(),20,20); 
     if ( mesures.size() == 4){
       text("Algorithme de résolution (pour epsilon nul) disponible",20,40);
       observateur._4mesures=true;
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
    }

  public void drawTrajectoire(float x0, float y0,float vx, float vy){
    float coef = vy/vx;
    line(x0,y0,1000,1000*coef);
  }
  
    public double[] calculerParamsMobile() {       
        Mesure[] mesuresTab = new Mesure[4];
        if (mesures.size() >= 4) {
            int i=0;
            for (Mesure m : mesures) {
                if (i < 4) {
                    mesuresTab[i] = m;
                    i++;
                }
            }
            double[][] a = new double[4][4];
            double[] b = new double[4];
    
            for (int l=0;l<4;l++) {
                Mesure mesure = mesuresTab[l];
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
            Matrix B = new Matrix(b,4);
    
            Matrix res = A.solve(B);
    
            double[] paramsMobile = res.getColumnPackedCopy();
            return paramsMobile;
        }
        else {
            return null;
        }
        
    }
    public void afficherPositionsCalculees() {
        if (observateur._4mesures) {
            double[] params = calculerParamsMobile();
            if (params.length !=0l) {
                text("x0 = "+params[0]+"; vx = "+params[1]+"; y0 = "+params[2]+"; vy = "+params[3],20,60); 
            }
        }
    }

}
