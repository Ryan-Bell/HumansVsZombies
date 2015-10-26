//Seeker class
//Creates an inherited Seeker object from the Vehicle class
//Due to the abstract nature of the vehicle class, the Seeker
//  must implement the following methods:  
//  calcSteeringForces() and display()

class Seeker extends Vehicle {

  //---------------------------------------
  //Class fields
  //---------------------------------------

  //seeking target
  //set to null for now
  PVector target = null;
  
  //PShape to draw the Seeker's triangle body
  PShape body;

  //overall steering force for this Seeker accumulates the steering forces
  //  of which this will be applied to the vehicle's acceleration
  PVector steeringForce;


  //---------------------------------------
  //Constructor
  //---------------------------------------
  Seeker(float x, float y, float r, float ms, float mf) {
    //call the super class' constructor
    super(x, y, r, ms, mf);

    steeringForce = new PVector(0, 0);

    //PShape initialization
    //seeker is drawn "pointing" toward 0 degrees
    body = createShape();
    body.beginShape();
    body.vertex(10, 0);
    body.vertex(-10, -5);
    body.vertex(-10, 5);
    body.endShape(CLOSE);
  }


  //--------------------------------
  //Abstract class methods
  //--------------------------------

  //Method: calcSteeringForces()
  //Purpose: Based upon the specific steering behaviors this Seeker uses, 
  //         Calculates all of the resulting steering forces
  //         Applies each steering force to the acceleration
  //         Resets the steering force
  void calcSteeringForces() {
    //reset the steering force
    steeringForce.mult(0);
    //seek the target
    PVector seekForce = seek(new PVector(mouseX, mouseY));

    //add the seeking force to this overall steering force
    steeringForce.add(seekForce); 

    //limit this seeker's steering force to a maximum force
    steeringForce.limit(maxForce);

    //apply this steering force to the vehicle's acceleration
    applyForce(steeringForce);

    
  }

  //Method: display()
  //Purpose: Finds the angle this seeker should be heading toward
  //         Draws this seeker as a triangle pointing toward 0 degreed
  //         All Vehicles must implement display
  void display() {
    //calculate the direction of the current velocity
    float angle = velocity.heading();

    //draw this vehicle
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    //Draw the PShape
    shape(body, 0, 0);
    color(#ff0000);
    line(0,0,steeringForce.x, steeringForce.y);
    popMatrix();
    if(showDebug){
      stroke(255,0,0);
      line(position.x,position.y,position.x + right.x*40, position.y + right.y*40);
      stroke(0,0,255);
      line(position.x, position.y, position.x + velocity.x*10, position.y + velocity.y*10);
      //line(position.x,position.y,position.x + forward.x*40, position.y + forward.y*40);
      stroke(0,255,0);
      line(position.x, position.y, position.x + steeringForce.x*200, position.y + steeringForce.y*200);
      stroke(100,100,100);
      line(position.x, position.y, mouseX, mouseY);
    }
  }
  
  

  //--------------------------------
  //Class methods
  //--------------------------------
}
//boolean showDebug = true;
//void mousePressed(){showDebug = !showDebug;}