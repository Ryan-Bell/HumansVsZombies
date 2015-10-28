class Zombie extends Vehicle {
  
  Zombie(float x, float y, float r, float ms, float mf){
    super(x,y,r,ms,mf);
    fill(#333333);
    body = createShape(ELLIPSE, 0,0,20,20);
    range = 120;
  }
  void calcSteeringForces(){
    findClosest(humans);
    steeringForce.mult(0);
    steeringForce.add(seek(target)).add(correctiveForce).limit(maxForce);
    applyForce(steeringForce);
  }
}