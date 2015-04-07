float angle;
float jitter;
PImage imageSocle;
float posSocleX;
float posSocleY;

Image imageLanceur;
float posLanceurX;
float posLanceurY;
float angleLanceur;
int Fe = 20;

int xOrigin = 10;
int yOrigin = height-10;

Image imageProjec;
float masseProjec;
float theta0, x0, y0, v0;

int tauxMPix = 50;

boolean launched;

Projectile projectile;

public static final float MAX_ANGLE = 0.2;
public static final float MIN_ANGLE = -0.3;

void updateYOrigin() {
    yOrigin = height-10;
}

// conversion pixels en metres
float pixToMetres ( int pix) {
    return pix/tauxMPix;
}

// conversion metres en pixels
int metresToPix ( float m) {
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
    frameRate(Fe);
    fill(255);
    // fond d'ecran blanc
    background(255);

    //Image du socle
    imageSocle = loadImage("socle.png");

    posSocleX = pixToMetres(10);
    posSocleY = pixToMetres(height-160);

    posLanceurX=pixToMetres(86);
    posLanceurY= pixToMetres(height-110);

    // La classe image permet d'avoir une methode update specifique
    // en l'occurence redessinne l'image du cannon en fonction de l'angle
    // on pourait avoir plusieurs canon lel
    // arguments : postitionx positiony taillex tailley, image

    masseProjec=5;

    // image du canon
    // les images doivent etre dans le fichier data
    //imageLanceur = new Image (86, height-110,loadImage("lanceur.png"),150, 25);
    imageLanceur = new Image (loadImage("lanceur.png"),150, 25);
    angleLanceur=0;
    //imageProjec= new Image(86, height-110, 100, 30, loadImage("projectile.png"));
    imageProjec= new Image(loadImage("projectile.png"),100, 30);

    //TODO
    //Position initiale : embouchure du lanceur
    x0=pixToMetres(86);
    y0=pixToMetres(height-110);
    //x0=100;
    //y0=height-100;
    System.out.println(x0);
    System.out.println(y0);
    v0=1;
    theta0=0;
    


    projectile = new Projectile(x0, y0, v0, theta0, masseProjec, imageProjec, 1/Fe);
}


// Draw est appelle tous les 1/Fe secondes
// redessine le dessin en fonction de la frameRate
void draw() {
    // Repeint une toile blanche pour ne pas que les dessins
    // successifs se redessinnent
    background(225);


    //actualise l'angle de lancement du canon en fonction de la souris
    angleLanceur=atan2(mouseY-metresToPix(posLanceurY), mouseX-metresToPix(posLanceurX));
    // fonction d'affichage de la classe image definie ci dessous
    imageLanceur.display(metresToPix(posLanceurX),metresToPix(posLanceurY),angleLanceur);

    //Obligé de passer des pixels (des entiers en fait) à la méthode atan2
    projectile.setOrientation(mouseX, mouseY);

    projectile.display();

    // image du socle du tank
    image(imageSocle, metresToPix(posSocleX), metresToPix(posSocleY), 150, 150);

    
    //Dot d = new Dot(3, 3);
    //d.display();
}

//Pour différencier la phase de choix d'angle de lancement et la phase de lancer de projectile
void mousePressed() {
    launched=true;
}



class Dot {
    public static final int sizeOfDot = 10;
    public int x, y;
    public Dot (float x, float y) {
        this.x=xToDisplay(x);
        this.y=yToDisplay(y);
    }
    void display() {
        ellipse(x, y, 5, 5);
        //text("x ="+x+" y="+y,x, y);
    }
}


class Image {
    //public int x, y;
    int sizex, sizey;
    //public float angle = 0.0;
    PImage img;
    //        Image (int tx, int ty, int sizex, int sizey, PImage im) {
    //            x = tx;
    //            y = ty;
    //            this.sizex = sizex;
    //            this.sizey = sizey;
    //            img=im;
    //        }
    Image(PImage im, int sizex, int sizey) {
        this.img=im;
        this.sizex=sizex;
        this.sizey=sizey;
    }

    /*void display() {
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
        translate(x, y);
        if (angle >=MAX_ANGLE)
            angle = MAX_ANGLE;
        if (angle <= MIN_ANGLE)
            angle = MIN_ANGLE;
        rotate(angle);
        //translate(-img.width/2, -img.height/2);
        image(img, -sizex/2, -sizey/2, sizex, sizey);
        popMatrix();
    }*/
    
    //  !!!TOUT EST EN PIXELS!!!
    void display(int x, int y, float angle) {
        System.out.println(angle);
        // pop et push matrix permette d'applique les transfo
        // uniquement aux objet dessinés entre les 2
        pushMatrix();
        // les translations permette de faire une rotation
        // par le centre

        translate(x, y);
        if (angle >=MAX_ANGLE)
            angle = MAX_ANGLE;
        if (angle <= MIN_ANGLE)
            angle = MIN_ANGLE;
        
        rotate(angle);
        // translate(-img.width/2, -img.height/2);
        image(img, -sizex/2, -sizey/2, sizex, sizey);
        popMatrix();
    }

}


