abstract class Vehicle {
  
  PVector position, acceleration, velocity, forward, right, desired, target, steeringForce, correctiveForce, vecToCenter;
  float radius, maxSpeed, maxForce, range, minDist, type, mass = 1;
  PShape body;
  Vehicle(float x, float y, float r, float ms, float mf, float t) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);
    desired = position.copy();
    steeringForce = new PVector(0,0);
    correctiveForce = new PVector(0,0);
    target = position.copy();
    radius = r;
    maxSpeed = ms;
    maxForce = mf;
    forward = new PVector(0, 0);
    right = new PVector(0, 0);
    type = t;
  }
  
  abstract void calcSteeringForces();
  Vehicle display(){
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    if(type == 0)image(tree, -radius/2,-radius/2,radius,radius);
    else if(type == 1)image(zomb, -radius/2,-radius/2,radius,radius);
    else image(hum, -radius/2,-radius/2,radius,radius);
    popMatrix();
    return this;
  }
  
  Vehicle update() {
    forward = velocity.copy().normalize();
    right.x = -forward.y;
    right.y = forward.x;
    correctiveForce.mult(0);
    if(position.x < buffer)
      correctiveForce.x = 1;
    if(position.x > width - buffer)
      correctiveForce.x = -1;
    if(position.y < buffer)
      correctiveForce.y = 1;
    if(position.y > height - buffer)
      correctiveForce.y = -1;
    avoidObject();
    calcSteeringForces();
    velocity.add(acceleration).limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    return this;
  }

  void findClosest(ArrayList subjects){
    float tempDist;
    minDist = width;
    for(Vehicle v : (ArrayList<Vehicle>)subjects){
      if((tempDist = dist(v.position.x, v.position.y, position.x, position.y)) < minDist){
        target = v.position.copy().add(PVector.mult(v.velocity, 7));
        if(showDebug)ellipse(target.x, target.y, 5,5);
        minDist = tempDist;
      }
    }
  }
  
  void avoidObject(){
    float tempDist, safeDistance = 30;
    for(Vehicle v : objects){
      if((vecToCenter = PVector.sub(v.position, position)).mag() > safeDistance)
        {continue;}
      if(vecToCenter.dot(forward) < 0)
        continue;
      if(Math.abs(tempDist = vecToCenter.dot(right)) > 45)
        continue;
      if(tempDist < 0)
        applyForce(right.copy().mult(maxSpeed *.5));
      else
        applyForce(right.copy().mult(maxSpeed * -.5));
    }
     
  }

  Vehicle applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
    return this;
  }
  
  PVector seek(PVector target) {
    desired = PVector.sub(target, position).normalize().mult(maxSpeed);
    return PVector.sub(desired, velocity);
  }
}