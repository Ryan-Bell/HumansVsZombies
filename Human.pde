class Human extends Vehicle {
  float wanderRadius, wanderDistance, wanderDelta, rotation;
  Human(float x, float y, float r, float ms, float mf, boolean o){
    super(x,y,r,ms,mf);
    fill(#ffffff);
    if(o)
      body = createShape(RECT, 0,0,20,20);
    else
      body = createShape(RECT, 0,0,20,10);
    range = 180;
    wanderRadius = 25;
    wanderDistance = 80;
    wanderDelta = .2;
    rotation = random(0,2*PI);
  }
  
  void getSick(){
      zombies.add(new Zombie(position.x,position.y,6,3,0.1));
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