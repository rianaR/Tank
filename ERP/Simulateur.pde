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

    public double[] calculerParamsMobile() {
        Mesure[] mesuresTab = (Mesure[])mesures.toArray();
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

}
