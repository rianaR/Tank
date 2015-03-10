

class Projectile {
  
  public double theta,m,x,y,vx,vy,v;
  public PImage image;
 Projectile (double theta0, double m, double x0, double y0,double v0,PImage image){
  this.x=x0;
  this.y=y0;
  this.v=v0;
  this.theta=theta0;
  this.vx = cos(theta)*v;
  this.vy = sin(theta)*v;
  this.image= image;
 }
  
  
  
}
