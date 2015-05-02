import java.util.*;

public class Simulator {
    private Mobile mobile;
    private Observer observer;
    private Robot robot;
    private List<Measure> measures=new ArrayList<Measure>();
    private double[] estimatedMobileParams;
    public boolean _4measures;
    public float Te;
    public boolean whiteNoise = false;

    public Mobile mobileEstime;


    public Simulator(float Te) {
        this.mobile = new Mobile(200, 200, 3, 3, Te);
        this.observer = new Observer(300, 250, 200, PI/12, Te, atan2(mobile.getY()-200, 
        mobile.getX()-200));
        this.Te=Te;
        this.mobile = new Mobile(30, 100, 5, 5, Te);
        this.observer = new Observer(300, 250, 200, PI/5, Te, atan2(mobile.getY()-250, 
        mobile.getX()-300));
    }
    public void getEstimatedMobile(float t) {
        if (estimatedMobileParams!=null && estimatedMobileParams.length>=4) {
            float x = (float)estimatedMobileParams[0];
            float y =(float)estimatedMobileParams[2];
            float vx = (float)estimatedMobileParams[1];
            float vy = (float)estimatedMobileParams[3];
            mobileEstime= new Mobile(x+vx*t, y+vy*t, vx, vy, Te);
        }
    }

    public void drawEstimatedMobile() {
        fill(255, 0, 0);
        mobileEstime.display();
        mobileEstime.nextPos();
        ellipse(mobileEstime.x, mobileEstime.y, 10, 10); 
        fill(0);
        System.out.println("lel");
    }

    public void drawEstimatedPath() {
        if (estimatedMobileParams!=null && estimatedMobileParams.length>=4) {
            float x0 = (float)estimatedMobileParams[0];
            float vx = (float)estimatedMobileParams[1];
            float y0 = (float)estimatedMobileParams[2];
            float vy = (float)estimatedMobileParams[3];
            stroke(255, 0, 0);
            drawTrajectory(x0, y0, vx, vy);
            stroke(0);
        }
    }

    public void update() {
        this.mobile.nextPos();
        this.observer.nextPos();

        this.observer.setThetaMobile(measureTheta(atan2(mobile.getY()-observer.getY(), 
        mobile.getX()-observer.getX())));
    }


    public float measureTheta(float measure) {
        if (whiteNoise) {

            Random rand = new Random();

            // nextInt is normally exclusive of the top value,
            // so add 1 to make it inclusive
            float randomNum = (rand.nextFloat()-0.5)/10;

            return measure+randomNum*measure;
        }

        return measure;
    }


    public void displayNbMeasures() {
        fill(0);
        text("mesures prises ="+measures.size(), 20, 20); 
        if (_4measures) {
            text("Algorithme de résolution (pour epsilon nul) disponible", 20, 40);
        }
    }    

    public void displayMeasures() {
        if (measures !=null) {
            for (Measure m : measures) { 
                fill(255, 0, 0);
                ellipse(m.xp, m.yp, 10, 10);
                text("mesure : ("+m.xp+","+m.yp+","+m.theta+","+m.t+")", m.xp+10, m.yp-10);
            }
        }
    }

    public Mobile getMobile() {
        return this.mobile;
    }
    public Observer getObserver() {
        return this.observer;
    }
    public Robot getRobot() {
        return this.robot;
    }

    public void addMeasure(Measure m) {
        measures.add(m);
        if (measures.size() == 4) {
            _4measures=true;
        }
    }

    public void drawTrajectory(float x0, float y0, float vx, float vy) {
        float coef = vy/vx;
        line(x0, y0, x0+1000.0f, y0+1000.0f*coef);
    }

    public void calculateMobileParams(boolean allMeasures) {       
        if (_4measures) {
            int nbMeasures;
            int listSize=measures.size();
            if (allMeasures) {
                nbMeasures = listSize;
            } else {
                nbMeasures = 4;
            }
            double[][] a = new double[nbMeasures][4];
            double[] b = new double[nbMeasures];

            for (int l=0; l<nbMeasures; l++) {
                Measure measure = measures.get(listSize-(l+1));
                //x0
                a[l][0]=sin(measure.theta);
                //vx
                a[l][1]=sin(measure.theta)*measure.t;
                //y0
                a[l][2]=-cos(measure.theta);
                //vy
                a[l][3]=-cos(measure.theta)*measure.t;

                b[l]=sin(measure.theta)*measure.xp-cos(measure.theta)*measure.yp;
            }

            Matrix A = new Matrix(a);
            Matrix B = new Matrix(b, nbMeasures);

            Matrix res = A.solve(B);


            estimatedMobileParams = res.getColumnPackedCopy();
        }
    }
    public void displayCalculatedParams() {
        if (_4measures) {

            if (estimatedMobileParams != null) {
                text("x0 = "+estimatedMobileParams[0]+
                    "; vx = "+estimatedMobileParams[1]+
                    "; y0 = "+estimatedMobileParams[2]+
                    "; vy = "+estimatedMobileParams[3], 20, 60);
            }
        }
    }
}

