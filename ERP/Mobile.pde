public class Mobile {
    private float x,y;
    private float x0, y0;
    private float vx, vy;
    private float Te;
    public Mobile(float x0, float y0, float vx, float vy, float Te) {
        this.x=x0;
        this.y=y0;
        this.x0=x0;
        this.y0=y0;
        this.vx=vx;
        this.vy=vy;
        this.Te=Te;
    }
    public void nextPos() {
        x=x+vx*Te;
        y=y+vy*Te;
    }

    public float getX0() {
        return x0;
    }
    public float getY0() {
        return y0;
    }
    public float getX() {
        return x;
    }
    public float getY() {
        return y;
    }
    public float getVx() {
        return vx;
    }
    public float getVy() {
        return vy;
    }
}
