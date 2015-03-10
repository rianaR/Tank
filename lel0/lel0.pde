float angle;
float jitter;
PImage img,img2;
Image image;
int Fe = 10;

void setup() {
  size(1368, 768);
  frameRate(10);
  fill(255);

  // image du canon
  // les images doivent etre dans le fichier data
   img = loadImage("lel.png");
   
  // taille de l'image
   int imSize = 50;
   
  // La classe image permet d'avoir une methode update specifique
  // en l'occurence redessinne l'image du cannon en fonction de l'angle
  // on pourait avoir plusieurs canon lel
   image = new Image (imSize,height-imSize,imSize,imSize,img);
   
   // fond d'ecran blanc
   background(255);
   
   // une autre image, on s'en fou
   img2 = loadImage("lel.png");
   
}


// Draw est appelle tous les 1/Fe secondes
// redessine le dessin en fonction de la frameRate
void draw() {
   // Repeint une toile blanche pour ne pas que les dessins
   // successifs se redessinnent
  background(225);
  
  // actualise l'angle de l'image image
  image.update(mouseX, mouseY);
  // fonction d'affichage de la classe image definie ci dessous
  image.display();
  
  // fonction d'affichage par defaut de processing
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
    // affichage des text
     text("Angle "+angle, 10, 30);
     // texte de couleur nor
     fill(0);
    text("Position "+x+";"+y, 10, 60);
    
    // pup et push matrix permette d'applique les transfo
    // uniquement aux objet dessinés entre les 2
    pushMatrix();
      // les translations permette de faire une rotation
      // par le centre
     translate(x,y);
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


 

