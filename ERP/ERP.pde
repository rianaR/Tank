

Simulateur simulateur;
boolean clic;
void setup() {
    size(640,480);
    frameRate(30);
    background(255);
    simulateur = new Simulateur();
}



void draw() {
  frameRate(10);
    background(255);
    simulateur.getObservateur().drawCircle();
    simulateur.getObservateur().drawTrajectoire(200,200,1,1);
    simulateur.update();
    fill(30);
    ellipse(simulateur.getMobile().getX(), simulateur.getMobile().getY(),10,10);
    fill(50);
    ellipse(simulateur.getObservateur().getX(), simulateur.getObservateur().getY(), 10,10);
    
      if (clic) {
      text(""+simulateur.getObservateur().getThetaMobile(),simulateur.getObservateur().getX(), simulateur.getObservateur().getY());
      simulateur.addMesure(new Mesure (simulateur.getObservateur().getX(),simulateur.getObservateur().getY(),simulateur.getObservateur().getThetaMobile(),(float)millis()));
      clic=false;
    }
    
    simulateur.displayMesures();

}




void keyReleased() {
  
  clic = true;

}
