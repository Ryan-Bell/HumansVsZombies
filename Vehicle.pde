abstract class Vehicle {
  PVector position, acceleration, velocity, forward, right, desired;
  float radius, maxSpeed, maxForce, mass = 1;
  
  Vehicle(float x, float y, float r, float ms, float mf) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);
    desired = position.copy();
    radius = r;
    maxSpeed = ms;
    maxForce = mf;
    forward = new PVector(0, 0);
    right = new PVector(0, 0);
  }
  
  abstract void calcSteeringForces();
  abstract void display();
  
  Vehicle update() {
    forward = velocity.copy().normalize();
    right.x = -forward.y;
    right.y = forward.x;
    calcSteeringForces();
    velocity.add(acceleration).limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    return this;
  }

  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }
  
  PVector seek(PVector target) {
    desired = PVector.sub(target, position).normalize().mult(maxSpeed);
    return PVector.sub(desired, velocity);
  }
}