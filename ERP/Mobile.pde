public class Mobile {
    private float x,y;
    private float x0, y0;
    private int vx, vy;
    public Mobile(float x0, float y0, int vx, int vy) {
        this.x=x0;
        this.y=y0;
        this.x0=x0;
        this.y0=y0;
        this.vx=vx;
        this.vy=vy;
    }
    public void calculerPos() {
        x=x+vx;
        y=y+vy;
    }
    public float getX() {
        return x;
    }
    public float getY() {
        return y;
    }
    public int getVx() {
        return vx;
    }
    public int getVy() {
        return vy;
    }
}
