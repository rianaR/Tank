


public static final int windowHeight = 700;
public static final int windowWidth = 1024;

public Environment environment = new Environment();

public static int ratioPixelsByMeters = 30;

public float pixelToMetres(int pixel) {
    return ((float)pixel/ratioPixelsByMeters);
}

public int metersToPixels(float meters) {
    return (int) (meters*ratioPixelsByMeters);
}



void setup() {
    size(windowWidth, windowHeight);
    fill(255);
    background(255);

    environment.tank.tankImage = loadImage("socle.png");
    environment.tank.cannon.cannonImage = loadImage("cannon.png");
}

// METERS INPUT
public void displayImage (PImage image, float x, float y, float sizeX, float sizeY, float angle) {


    int imageHeight = metersToPixels(sizeY);
    int imageWidth = metersToPixels(sizeX);

    int xDisplay = metersToPixels(x);
    int yDisplay = windowHeight-metersToPixels(y)-imageHeight;
    //print("avant "+sizeY);
    //println("apres "+imageHeight);


    pushMatrix();
    translate(xDisplay, yDisplay);
    rotate(angle);
    //rect(0,0,imageWidth,imageHeight);
    image(image, 0, 0, imageWidth, imageHeight);

    popMatrix();
    //println(" "+metersToPixels(x)+","+(windowHeight-metersToPixels(y)-imageHeight)+" "+metersToPixels(sizeX)+" "+imageHeight+" "+angle);
} 


// meters again
public void displayDot(float x, float y) {


    int xDisplay = metersToPixels(x);
    int yDisplay = windowHeight-metersToPixels(y);


    fill(0, 0, 255);
    stroke(0, 0, 255);
    ellipse(xDisplay, yDisplay, 10, 10);
    //text("Cannon Mouth :"+xDisplay+" "+yDisplay,10,60);
}


public void displayFloor() {
    fill(50, 0, 50);
    rect(0, windowHeight-metersToPixels(environment.tank.y), windowWidth, windowHeight);
}


public void displayLine(float x, float y, float x2, float y2) {


    int xDisplay = metersToPixels(x);
    int yDisplay = windowHeight-metersToPixels(y);


    int x2Display = metersToPixels(x2);
    int y2Display = windowHeight-metersToPixels(y2);


    line (xDisplay, yDisplay, x2Display, y2Display);
}

void draw() {
    fill(255);
    background(225);
    stroke(255);
    rect(0, 0, windowWidth, windowHeight);



    environment.tank.display();

    int imageHeight = metersToPixels(environment.tank.cannon.cannonHeight);
    int imageWidth = metersToPixels(environment.tank.cannon.cannonWidth);
    // to calculate the angle between the cursor and the cannon
    int yCannon = windowHeight-metersToPixels(environment.tank.cannon.y)-imageHeight/2;
    int xCannon = metersToPixels(environment.tank.cannon.x);

    float angle=atan2(mouseY-yCannon, mouseX-xCannon);

    angle = environment.tank.cannon.setAngle(angle);


    // Calulate position of the cannon mouth
    fill(255, 0, 0);

    float dX = imageWidth*cos(angle);
    float dY = sqrt(imageWidth*imageWidth-dX*dX);

    float nextX = xCannon+dX;
    float nextY = yCannon-dY;
    environment.tank.cannon.setCannonMouth(pixelToMetres((int)nextX), pixelToMetres((int)(windowHeight-nextY)));
    //ellipse(nextX,nextY,10,10);
    displayFloor();
}

void keyPressed() {
    float step = 0.1;
    if (keyCode == LEFT)
        environment.tank.varyX(-step);
    if (keyCode == RIGHT)
        environment.tank.varyX(step); 
    if (keyCode == UP)
        environment.tank.cannon.varyInitialSpeed(step);
    if (keyCode == DOWN)
        environment.tank.cannon.varyInitialSpeed(-step);
}

void keyReleased() {
    if (keyCode == UP)
        environment.tank.cannon.sendProjectile();
}

