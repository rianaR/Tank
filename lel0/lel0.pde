float angle;
float jitter;
PImage img,img2;
Image image;

void setup() {
  size(1368, 768);
  
  fill(255);

  
   img = loadImage("lel.png");
   int imSize = 50;
   image = new Image (imSize,height-imSize,imSize,imSize,img);
   background(255);
   
   img2 = loadImage("lel.png");
   
}

void draw() {
 
  background(225);
  image.update(mouseX, mouseY);
  image.display();
  image(img2,500,500,50,50);
}


class Image {
  public int x, y;
  int sizex,sizey;
  public float angle = 0.0;
  PImage img;
  Image (int tx, int ty, int sizex,int sizey,PImage im) {
    x = tx;
    y = ty;
    this.sizex = sizex;
    this.sizey = sizey;
    img=im;
  }
  
  void display(){
     text("Angle "+angle, 10, 30);
     fill(0);
    text("Position "+x+";"+y, 10, 60);
    pushMatrix();
     translate(x,y);
     rotate(angle);
     //translate(-img.width/2, -img.height/2);
     image(img,-sizex/2,-sizey/2,sizex,sizey);
      popMatrix();
  }
  
  void update(int mx, int my) {
    
    angle = atan2(my-y, mx-x);
    //if (angle<0)
      //angle=0;
  }

  
}


 

