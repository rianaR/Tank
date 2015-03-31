Mobile mobile;
Observateur obs;

void setup() {
    size(640,480);
    frameRate(30);
    background(255);
    mobile = new Mobile(100,100,1,1);
    obs = new Observateur(200,200,100,0,0.1);
}

void draw() {
    background(255);
    mobile.calculerPos();
    obs.calculerPos();
    obs.setThetaMobile(atan2(mobile.getX()-obs.getX(),mobile.getY()-obs.getY()));
    fill(30);
    ellipse(mobile.getX(), mobile.getY(),10,10);
    fill(50);
    ellipse(obs.getX(), obs.getY(), 10,10);
}
