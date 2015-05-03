
public class Trajectory {

  Projectile projectile;
  float ground0;

  public Trajectory (float x0, float y0, float v0, float theta0, float m, float Te, float ground0, boolean manuel) {

    projectile = new Projectile(x0, y0, v0, theta0, m, Te, manuel);
    this.ground0=ground0;
  }

  public void displayTrajectory() {

    float x0 = projectile.x;
    float y0 = projectile.y;
    float xf=x0, yf=y0;
    for (int i=0; projectile.y>=ground0 && i<=100; i++) {
      fill(0, 0, 255);

      float x = projectile.x;
      float y = projectile.y;
      displayDot(x, y, 10);
      // println(i+")"+projectile.x+","+projectile.y);

      projectile.update();
      xf = projectile.x;
      yf = projectile.y;
      displayLine(x, y, xf, yf);
      //println("jalon");
    }

    text("last point : "+xf+","+yf, 160, 20);
    text("range "+(xf-x0)+" m", 10, 60);
    fill(0);
    strokeWeight(5);
    //println(ground0);
    displayLine(x0, ground0, xf, ground0);
    strokeWeight(1);
  }
}

