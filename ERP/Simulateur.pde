import java.util.*;

public class Simulateur {
    private Mobile mobile;
    private Observateur observateur;
    private Robot robot;
    private List<Mesure> mesures=new ArrayList<Mesure>();
    private double[] paramsMobileEstimes;
    public boolean _4mesures;
    
    public boolean whiteNoise = false;

    public void drawEstimatedPath(){
      if (paramsMobileEstimes!=null && paramsMobileEstimes.length>=4){
        float x0 = (float)paramsMobileEstimes[0];
        float vx = (float)paramsMobileEstimes[1];
        float y0 = (float)paramsMobileEstimes[2];
        float vy = (float)paramsMobileEstimes[3];
        stroke(255,0,0);
        drawTrajectoire(x0,y0,vx,vy);
        stroke(0);
      }
      
    }


    public Simulateur(float Te) {
        this.mobile = new Mobile(200,200,3,3,Te);
        this.observateur = new Observateur(300,250,200,PI/12,Te,atan2(mobile.getY()-200,
                                            mobile.getX()-200));
    }

    public void update() {
        this.mobile.nextPos();
        this.observateur.nextPos();
        
        this.observateur.setThetaMobile(mesureTheta(atan2(mobile.getY()-observateur.getY(),
                                            mobile.getX()-observateur.getX())));
    }
    
    
    public float mesureTheta(float mesure){
        if (whiteNoise){
          
              Random rand = new Random();

            // nextInt is normally exclusive of the top value,
            // so add 1 to make it inclusive
             float randomNum = (rand.nextFloat()-0.5)/10;

            return mesure+randomNum*mesure;
        }
        else
          return mesure;
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
            text("mesure : ("+m.xp+","+m.yp+","+m.theta+","+m.t+")",m.xp+10,m.yp-10);
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
    line(x0,y0,x0+1000.0f,y0+1000.0f*coef);
  }
  
    public void calculerParamsMobile(boolean allMesures) {       
        if (_4mesures) {
            int nbMesures;
            int listSize=mesures.size();
            if (allMesures) {
                nbMesures = listSize;
            }
            else {
                nbMesures = 4;
            }
            double[][] a = new double[nbMesures][4];
            double[] b = new double[nbMesures];
    
            for (int l=0;l<nbMesures;l++) {
                Mesure mesure = mesures.get(listSize-(l+1));
                //x0
                a[l][0]=sin(mesure.theta);
                //vx
                a[l][1]=sin(mesure.theta)*mesure.t/1000;
                //y0
                a[l][2]=-cos(mesure.theta);
                //vy
                a[l][3]=-cos(mesure.theta)*mesure.t/1000;
    
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
