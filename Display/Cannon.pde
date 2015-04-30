
public class Cannon {
 
    public PImage cannonImage;
  // metres
float cannonHeight = 2;
float cannonWidth = 3;

float ground0;

private float initialSpeed = 1.5;

private static final float LIMIT_ANGLE_MIN = -PI/4;
private static final float LIMIT_ANGLE_MAX =  0;
private float angle;

//metres
float x,y;


// cannon extremity
float cannonMouthX,cannonMouthY;



public void setCannonMouth(float cannonMouthX,float cannonMouthY){
 this.cannonMouthX = cannonMouthX;
this.cannonMouthY = cannonMouthY; 
}


public void varyInitialSpeed(float dx){
   initialSpeed+=dx; 
}


//Environment.metersToPixels(tankHeight),Environment.metersToPixels(tankWidth));
  
public Cannon(float x,float y, float cannonHeight, float cannonWidth,float ground0) {
  this.x=x;
  
  this.y=y;
  
  this.cannonHeight = cannonHeight;
  this.cannonWidth = cannonWidth;
  this.angle=0;
}


public float setAngle(float angle){
 this.angle = angle ;
 if(angle<=LIMIT_ANGLE_MIN)
   this.angle = LIMIT_ANGLE_MIN;
  if(angle>=LIMIT_ANGLE_MAX)
     this.angle = LIMIT_ANGLE_MAX;
     
   return this.angle;
}

public void display(){
  fill(0);
  
  float angleDegres = -angle*180/PI;
  text("Cannon angle : "+angleDegres+"°",10,20);
  text("Initial Speed : "+initialSpeed+" m/s",10,40);
  
  //println(" "+x+","+y+" "+cannonWidth+" "+cannonHeight+" "+angle);
  displayImage(cannonImage,x,y,cannonWidth,cannonHeight,angle);
   
  displayDot(cannonMouthX,cannonMouthY);
  //text("Cannon Mouth :"+cannonMouthX+" "+cannonMouthY,10,40);

  Trajectory t = new Trajectory(cannonMouthX,cannonMouthY,initialSpeed,-angle,0.01,1,ground0);
 t.displayTrajectory(); 
}



public void sendProjectile(){}


}
