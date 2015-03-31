Mobile mobile;
Observateur obs;

void setup() {
    size(640,480);
    frameRate(30);
    background(255);
    mobile = new Mobile(100,100,1,1);
    obs = new Observateur(300,300,100,0);
}

void draw() {
    background(255);
    mobile.calculerPos();
    obs.calculerPos();
    fill(30);
    ellipse(mobile.getX(), mobile.getY(),10,10);
    fill(50);
    ellipse(obs.getX(), obs.getY(), 20,20);
}
