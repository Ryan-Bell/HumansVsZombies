class Human extends Vehicle {
  Human(float x, float y, float r, float ms, float mf){
    super(x,y,r,ms,mf);
    fill(#ffffff);
    body = createShape(RECT, 0,0,20,20);
    range = 180;
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
      target = position.copy(); //will replace with wander later
    steeringForce.mult(0);
    steeringForce.add(seek(target)).add(correctiveForce.mult(5)).limit(maxForce);
    applyForce(steeringForce);
  }
}