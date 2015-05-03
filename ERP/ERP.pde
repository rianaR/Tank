

Simulator simulator;
boolean clic;
float Fe;
void setup() {
    size(640, 480);
    frameRate(30);
    background(255);
    Fe=60;
    simulator = new Simulator(1/Fe);
}



void draw() {
    frameRate(Fe);
    background(255);
    simulator.getObserver().drawCircle();
    simulator.drawTrajectory(simulator.getMobile().getX0(), 
    simulator.getMobile().getY0(), 
    simulator.getMobile().getVx(), 
    simulator.getMobile().getVy());
    simulator.update();
    fill(30);
    simulator.getMobile().display();
    fill(255, 0, 0);

    if (simulator.mobileEstime!=null)
        simulator.drawEstimatedMobile();

    fill(50);
    ellipse(simulator.getObserver().getX(), simulator.getObserver().getY(), 10, 10);
    if (clic) {
        text(""+simulator.getObserver().getThetaMobile(), simulator.getObserver().getX(), simulator.getObserver().getY());
        //En secondes
        simulator.addMeasure(new Measure (simulator.getObserver().getX(), simulator.getObserver().getY(), simulator.getObserver().getThetaMobile(), (float)(millis()/1000.0f)));
        simulator.calculateMobileParams(true);
        simulator.getEstimatedMobile((float)millis()/1000);

        clic=false;
    }

    simulator.displayCalculatedParams();
    simulator.displayMeasures();
    simulator.displayNbMeasures();
    simulator.drawEstimatedPath();

    if (simulator.whiteNoise)
        text(" Bruit blanc activé ", 10, 450);
    else
        text(" Bruit blanc non activé ", 10, 450);
}




void keyReleased() {
    if (keyCode == UP)
        clic = true;
    if (keyCode == DOWN) {
        simulator.whiteNoise=(!simulator.whiteNoise);
    }
    if (keyCode == ' ')
      simulator.observer.sendRobot();
}

