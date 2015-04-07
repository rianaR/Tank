public class Mobile {
    private float x,y;
    private float x0, y0;
    private float vx, vy;
    public Mobile(float x0, float y0, float vx, float vy) {
        this.x=x0;
        this.y=y0;
        this.x0=x0;
        this.y0=y0;
        this.vx=vx;
        this.vy=vy;
    }
    public void nextPos() {
        x=x+vx;
        y=y+vy;
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
