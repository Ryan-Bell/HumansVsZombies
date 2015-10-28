class Human extends Vehicle {
  float wanderRadius, wanderDistance, wanderDelta, rotation;
  Human(float x, float y, float r, float ms, float mf, boolean o, float t){
    super(x,y,r,ms,mf,t);
    fill(#ffffff);
    if(o)
      body = createShape(RECT, 0,0,r,r);
    else
      body = createShape(ELLIPSE, 0,0,30,30);
    range = 180;
    wanderRadius = 25;
    wanderDistance = 80;
    wanderDelta = .2;
    rotation = PI;
  }
  
  void getSick(){
      zombies.add(new Zombie(position.x,position.y,6,3,0.1,1));
      humans.remove(this);
  }
  void calcSteeringForces(){
    findClosest(zombies);
    if(minDist < radius){
      getSick();
      return;}
    if(minDist < range)
      target = PVector.add(position, PVector.sub(position, target));
    else
      target = wander();
    steeringForce.mult(0);
    steeringForce.add(seek(target)).add(correctiveForce.mult(5)).limit(maxForce);
    applyForce(steeringForce);
  }
  
  PVector wander(){
    rotation += random(wanderDelta*-1, wanderDelta);
    return position.copy()
      .add(velocity.copy().normalize().mult(wanderDistance))
      .add(wanderRadius*cos(rotation+velocity.heading()), 
           wanderRadius*sin(rotation+velocity.heading()));
  }
}