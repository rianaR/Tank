

class Projectile {
  
  //Element initiaux
  public float v0;
  
  // Etat de l'objet
  public float theta,m,x,y,vx,vy,v,k;
  
  // Elements de discretisation
  public int n,Te;
  
  // Paramètres environnementaux
   public static final float g = 9.81;
  
  // Affichage
  public Image image;
  
 Projectile (float theta0, float m, float x0, float y0,float v0,Image image, int Te){
  this.v0=v0;
  this.x=x0;
  this.y=y0;
  this.v=v0;
  this.theta=theta0;
  this.vx = cos(theta)*v;
  this.vy = sin(theta)*v;
  this.image= image;
  this.k=0;
  this.Te=Te;
 }

public void setK ( float k){
  this.k=k;
}
  
public float updateX (){
     this.x = 0.5*k*cos(theta)*(2*n - 1)*Te*Te+v0*cos(theta)*Te+x;
     return x;
  }

public float updateY (){
     this.y = 0.5*(-m*g+k*sin(theta))*(2*n-1)*Te*Te+v0*sin(theta)*Te+y;
     return y;
  }
  
  
  public float updateVx (){
     this.vx = k*cos(theta)*Te+vx;
     return vx;
  }
  
  
  public float updateVy (){
     this.vy = (-m*g+k*sin(theta))*Te+vy;
     return vy;
  }

  public float updateV (){
   v= cos(theta)*vx + sin(theta)*vy;
   return v;
  }
 
 public float updateTheta(){
  theta = atan(vx/vy);
  return theta;
 }

  
}
