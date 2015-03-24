float angle;
float jitter;
PImage img,img2;
Image image;
int Fe = 10;

int xOrigin = 10;
int yOrigin = height-10;

int tauxMPix = 200;


void updateYOrigin(){
yOrigin = height-10; 
}

// conversion pixels en metres
float pixToMetres ( int pix){
 return pix/tauxMPix; 
}

// conversion metres en pixels
int metresToPix ( float m){
 return (int)(m*tauxMPix); 
}


// Conversion metres en pixels  
int xToDisplay (float x) {
  return (int)(metresToPix(x)+xOrigin);  
}

int yToDisplay (float y) {
  return (int)(yOrigin-metresToPix(y));
}

void setup() {
  size(1368, 768);
  updateYOrigin();
  frameRate(10);
  fill(255);

  // image du canon
  // les images doivent etre dans le fichier data
   img = loadImage("lanceur.png");
   
  
  // La classe image permet d'avoir une methode update specifique
  // en l'occurence redessinne l'image du cannon en fonction de l'angle
  // on pourait avoir plusieurs canon lel
  // arguments : postitionx positiony taillex tailley, image
   image = new Image (86,height-110,150,25,img);
   
   // fond d'ecran blanc
   background(255);
   
   // une autre image, on s'en fou
   img2 = loadImage("socle.png");
   
}


// Draw est appelle tous les 1/Fe secondes
// redessine le dessin en fonction de la frameRate
void draw() {
   // Repeint une toile blanche pour ne pas que les dessins
   // successifs se redessinnent
  background(225);
  
  // image du socle du tank
  image(img2,10,height-160,150,150);
  // actualise l'angle de l'image image
  image.update(mouseX, mouseY);
  // fonction d'affichage de la classe image definie ci dessous
  image.display();
  
  Dot d = new Dot(3,3);
  d.display();
  
}


class Dot {
  public static final int sizeOfDot = 10;
  public int x, y;
 public Dot (float x,float y){
  this.x=xToDisplay(x);
 this.y=yToDisplay(y); 
 }
   void display(){
     ellipse(x,y,5,5);
     //text("x ="+x+" y="+y,x, y);
   } 
}

class Image {
  public static final float MAX_ANGLE = 0.2;
  public static final float MIN_ANGLE = -0.3;
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
    // affichage des text
     text("Angle "+angle, 10, 30);
     // texte de couleur nor
     fill(0);
    text("Position "+mouseX+";"+(height-mouseY), 10, 60);
    
    // pup et push matrix permette d'applique les transfo
    // uniquement aux objet dessinés entre les 2
    pushMatrix();
      // les translations permette de faire une rotation
      // par le centre
     translate(x,y);
     if (angle >=MAX_ANGLE)
       angle = MAX_ANGLE;
     if (angle <= MIN_ANGLE)
       angle = MIN_ANGLE;
       rotate(angle);
     //translate(-img.width/2, -img.height/2);
     image(img,-sizex/2,-sizey/2,sizex,sizey);
      popMatrix();
  }
  
  // actualise l'angle en fonction de la position de la souris
  // par rapport au cannon
  void update(int mx, int my) {
    
    angle = atan2(my-y, mx-x);
    //if (angle<0)
      //angle=0;
  }

  
}


 

