public class Mobile {
    private int x,y;
    private int x0, y0;
    private int vx, vy;
    public Mobile(int x0, int y0, int vx, int vy) {
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
    public int getX() {
        return x;
    }
    public int getY() {
        return y;
    }
    public int getVx() {
        return vx;
    }
    public int getVy() {
        return vy;
    }
}
