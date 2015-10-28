abstract class Vehicle {
  PVector position;
  PVector acceleration;
  PVector velocity;
  PVector forward;
  PVector right;
  float radius;
  float maxSpeed;
  float maxForce;
  float mass = 1;
  
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
  
  abstract void calcSteeringForces();
  abstract void display();
  
  void update() {
    forward = velocity.copy();
    forward.normalize();
    right.x = -forward.y;
    right.y = forward.x;
    calcSteeringForces();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    return steer;
  }
}