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
     if ( mesures.size() >= 4){
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

}
