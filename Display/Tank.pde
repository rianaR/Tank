import java.io.File;

public class Tank {

    // metres
    float tankHeight = 2;
    float tankWidth = 3;


    float cannonAbs, cannonOrd;

    //metres
    float x, y;

    Cannon cannon;

    public PImage tankImage;


    //Environment.metersToPixels(tankHeight),Environment.metersToPixels(tankWidth));

    public void updateCannonCoord() {
        cannonAbs = x+tankHeight/4;
        cannonOrd = y+9*tankWidth/24;
        cannon.x=cannonAbs;
        cannon.y=cannonOrd;
    }

    public Tank(float x, float ground) {
        this.x=x;
        this.y=ground;
        cannon  = new Cannon(x+tankHeight/4, y+9*tankWidth/24, tankHeight/5, 3*tankWidth/4, y);

        //println(""+abs+","+ord);
    }


    public void display() {
        //println(y+tankWidth*(4/5));
        cannon.display();
        displayImage(tankImage, x, y, tankWidth, tankHeight, 0);
    }

    public void varyX(float dx) {
        x+=dx;
        updateCannonCoord();
        cannon.cannonHeight=tankHeight/5;
        cannon.cannonWidth=3*tankWidth/4;
        cannon.ground0=y;
    }
}

