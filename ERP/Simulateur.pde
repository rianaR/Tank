public class Simulateur {
    private Mobile mobile;
    private Observateur observateur;
    private Robot robot;

    public Simulateur() {
        this.mobile = new Mobile(50,50,1,1);
        this.observateur = new Observateur(300,300,100,0);
        this.observateur.setThetaMobile(atan2(mobile.getX()-observateur.getX(),
                                                mobile.getY()-observateur.getY()));
    }

    public void update() {
        this.mobile.calculerPos();
        this.observateur.calculerPos();
        this.observateur.setThetaMobile(atan2(mobile.getX()-observateur.getX(),
                                                mobile.getY()-observateur.getY()));
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
    
}
