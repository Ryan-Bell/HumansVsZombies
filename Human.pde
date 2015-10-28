class Human extends Vehicle {
  Human(float x, float y, float r, float ms, float mf){
    super(x,y,r,ms,mf);
    body = createShape(RECT, 0,0,20,20);
    range = 180;
    target = position.copy();
  }
  void updateTarget(){
    target = position.copy();
    //findclosest(array of objects to sort through) method to replace this 
  for(Zombie z : zombies){
    if(dist(z.position.x, z.position.y, position.x, position.y) < 10)
    {
      getSick();
      return;
    }
    if(dist(z.position.x, z.position.y, position.x, position.y) < range)
      target.add(PVector.sub(position, z.position));
    else
      target = position.copy();
  }
  }
  void getSick(){
      Zombie newZed = new Zombie(position.x,position.y,6,3,0.1);
      zombies.add(newZed);
      humans.remove(this);
  }
  void calcSteeringForces(){
    steeringForce.mult(0);
    steeringForce.add(seek(target)).add(correctiveForce.mult(5)).limit(maxForce);
    applyForce(steeringForce);
    //this will be adjusted so that multiple forces are not applied
    //applyForce(correctiveForce);
  }
  void display(){
    updateTarget();
    float angle = velocity.heading();
    pushMatrix();
    translate(position.x, position.y);
    //This debug will be moved into the main class
    if(showDebug){
      stroke(255,0,0);
      line(0,0,right.x*40, right.y*40);
      stroke(0,0,255);
      line(0,0,forward.x*40,forward.y*40);
      stroke(0,255,0);
      line(0,0,steeringForce.x*200, steeringForce.y*200);
      stroke(100,100,100);
      line(0,0,target.x - position.x,target.y-position.y);
    }
    rotate(angle);
    shape(body,0,0);
    popMatrix();
  }
}