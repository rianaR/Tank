import java.util.*;

public class Simulateur {
    private Mobile mobile;
    private Observateur observateur;
    private Robot robot;
    private Set<Mesure> mesures=new HashSet<Mesure>();
    
    public Simulateur() {
        this.mobile = new Mobile(200,200,1,1);
        this.observateur = new Observateur(300,300,100,0);
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

}
