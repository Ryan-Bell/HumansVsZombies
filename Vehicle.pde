//Vehicle class
//Specific autonomous agents will inherit from this class 
//Abstract since there is no need for an actual Vehicle object
//Implements the stuff that each auto agent needs: movement, steering force calculations, and display

abstract class Vehicle {

  //--------------------------------
  //Class fields
  //--------------------------------
  //vectors for moving a vehicle
  PVector position;
  PVector acceleration;
  PVector velocity;

  //no longer need direction vector - will utilize forward and right
  //orientation vectors provide a local point of view for the vehicle
  PVector forward;
  PVector right;

  //floats to describe vehicle movement and size
  float radius;
  float maxSpeed;
  float maxForce;
  float mass = 1;

  //--------------------------------
  //Constructor
  //--------------------------------
  Vehicle(float x, float y, float r, float ms, float mf) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);
    radius = r;
    maxSpeed = ms;
    maxForce = mf;

    forward = new PVector(0, 0);
    right = new PVector(0, 0);
  }

  //--------------------------------
  //Abstract methods
  //--------------------------------
  //every sub-class Vehicle must use these functions
  abstract void calcSteeringForces();
  abstract void display();

  //--------------------------------
  //Class methods
  //--------------------------------

  //Method: update()
  //Purpose: Calculates the overall steering force within calcSteeringForces()
  //         Applies movement "formula" to move the position of this vehicle
  //         Zeroes-out acceleration 
  void update() {
    //update this Seeker's forward and right vectors
    forward = velocity.copy();
    forward.normalize();
    right.x = -forward.y;
    right.y = forward.x;

    //calculate the necessary steering forces
    calcSteeringForces();

    //apply the movement "formula"
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);

    //zero out acceleration
    acceleration.mult(0);
  }


  //Method: applyForce(force vector)
  //Purpose: Divides the incoming force by the mass of this vehicle
  //         Adds the force to the acceleration vector
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }


  //--------------------------------
  //Steering Methods
  //--------------------------------

  //Method: seek(target's position vector)
  //Purpose: calculates the steering force toward a target
  PVector seek(PVector target) {
    //calculate the desired velocity from this vehicle's position
    //  toward the target's position
    PVector desired = PVector.sub(target, position);

    //normalize that desired velocity vector
    desired.normalize();

    //move the vehicle at its maximum speeed toward the target
    desired.mult(maxSpeed);

    //calculate the resulting force to move this vehicle toward the target
    PVector steer = PVector.sub(desired, velocity);

    //return this steering force
    return steer;
  }
}