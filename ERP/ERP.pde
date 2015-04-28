

Simulateur simulateur;
boolean clic;
float Fe;
void setup() {
    size(640,480);
    frameRate(30);
    background(255);
    Fe=100;
    simulateur = new Simulateur(1/Fe);
}



void draw() {
    frameRate(Fe);
    background(255);
    simulateur.getObservateur().drawCircle();
    simulateur.drawTrajectoire(simulateur.getMobile().getX0(),
                                simulateur.getMobile().getY0(),
                                simulateur.getMobile().getVx(),
                                simulateur.getMobile().getVy());
    simulateur.update();
    fill(30);
    simulateur.getMobile().display();
    fill(255,0,0);
   
   if(simulateur.mobileEstime!=null)
      simulateur.drawEstimatedMobile();
      
    fill(50);
    ellipse(simulateur.getObservateur().getX(), simulateur.getObservateur().getY(), 10,10);
    if (clic) {
        text(""+simulateur.getObservateur().getThetaMobile(),simulateur.getObservateur().getX(), simulateur.getObservateur().getY());
        simulateur.addMesure(new Mesure (simulateur.getObservateur().getX(),simulateur.getObservateur().getY(),simulateur.getObservateur().getThetaMobile(),(float)millis()));
        simulateur.calculerParamsMobile(true);
        simulateur.getEstimatedMobile((float)millis());

        clic=false;
    }
    
    simulateur.afficherParamsCalcules();
    simulateur.displayMesures();
    simulateur.displayMesuresPrises();
    simulateur.drawEstimatedPath();
    
    if (simulateur.whiteNoise)
      text(" Bruit blanc activé ", 10, 450);
   else
      text(" Bruit blanc non activé ", 10, 450);  
    
}




void keyReleased() {
  if (keyCode == UP)
    clic = true;
  if (keyCode == DOWN){
   simulateur.whiteNoise=(!simulateur.whiteNoise);
  }
}
