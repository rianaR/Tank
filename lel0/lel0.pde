float angle;
float jitter;
PImage img,img2;
Image imageLanceur;
int Fe = 10;

int xOrigin = 10;
int yOrigin = height-10;

Image imageProjec;
float m;
float theta0, x0, y0, v0;

int tauxMPix = 50;

boolean launched;

Projectile projectile;

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
  return (int)(height-yOrigin-metresToPix(y));
}

void setup() {
  size(800, 600);
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
  
  m=5;
  
   imageLanceur = new Image (86,height-110,150,25,img);
   imageProjec= new Image(86,height-110,100,30,loadImage("projectile.png"));
   
   //TODO
   //Position initiale : embouchure du lanceur
   x0=pixToMetres(86);
   y0=pixToMetres(height-110);
   v0=1;
   theta0=0;
   // fond d'ecran blanc
   background(255);
   
   //Image du socle
   img2 = loadImage("socle.png");
  
   
   projectile = new Projectile(theta0,m,x0,y0,v0,imageProjec,1/Fe);
}


// Draw est appelle tous les 1/Fe secondes
// redessine le dessin en fonction de la frameRate
void draw() {
   // Repeint une toile blanche pour ne pas que les dessins
   // successifs se redessinnent
  background(225);
  
  // image du socle du tank
  image(img2,10,height-160,150,150);
  // actualise l'angle de l'image du canon
  imageLanceur.update(mouseX, mouseY);
  // fonction d'affichage de la classe image definie ci dessous
  imageLanceur.display();
  
  if (!launched) {
      projectile.image.update(mouseX,mouseY);
  }
  else {
      projectile.updateX();
      projectile.updateY();
      projectile.updateVx();
      projectile.updateVy();
      projectile.updateV();
      projectile.updateTheta();
  }
  projectile.image.display();
  
  Dot d = new Dot(3,3);
  d.display();
  
}

void mousePressed() {
    launched=true;
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


 

