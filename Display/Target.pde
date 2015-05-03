
public class Target {



  //metres
  float x, y;

  public Target(float x, float ground) {
    this.x=x;
    this.y=ground;
  }

  public void display() {
    displayTarget(x, y);
  }
}

