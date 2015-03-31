Simulateur simulateur;

void setup() {
    size(640,480);
    frameRate(30);
    background(255);
    simulateur = new Simulateur();
}

void draw() {
    background(255);
    simulateur.update();
    fill(30);
    ellipse(simulateur.getMobile().getX(), simulateur.getMobile().getY(),10,10);
    fill(50);
    ellipse(simulateur.getObservateur().getX(), simulateur.getObservateur().getY(), 10,10);
}
