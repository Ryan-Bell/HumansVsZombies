class Zombie extends Vehicle {
  PVector target;
  PShape body;
  PVector steeringForce;
  float range;
  Zombie(float x, float y, float r, float ms, float mf){
    super(x,y,r,ms,mf);
    steeringForce = new PVector(0,0);
    body = createShape(ELLIPSE, 0,0,20,20);
    range = 120;
    target = position.copy();
  }
  void updateTarget(){
    float minDist = width;
    float tempDist;
    for(Human h : humans){
      //if(dist(h.position.x, h.position.y, position.x, position.y) < range){
      //  target = h.position.copy();
      //  return;
      //}
      //else{
      //  target = new PVector(position.x + noise((float)millis()/1000)*10-5,position.y + noise((float)millis()/1000+100)*10-5);
      if((tempDist = dist(h.position.x, h.position.y, position.x, position.y)) < minDist)
      {
        target = h.position.copy();
        minDist = tempDist;
      }
    }
   
  }
  void calcSteeringForces(){
   steeringForce.mult(0);
   PVector seekForce = seek(target);
   steeringForce.add(seekForce);
   steeringForce.limit(maxForce);
   applyForce(steeringForce);
   if(position.x < buffer)
     applyForce(rightForce.copy());
   if(position.x > width - buffer)
     applyForce(rightForce.copy().mult(-1));
   if(position.y < buffer)
     applyForce(upForce.copy().mult(-1));
   if(position.y > height - buffer)
     applyForce(upForce.copy());
  }
  void display(){
    updateTarget();
    float angle = velocity.heading();
    pushMatrix();
    translate(position.x, position.y);
    if(showDebug){
      stroke(255,0,0);
      line(0,0,right.x*40, right.y*40);
      stroke(0,0,255);
      line(0,0,forward.x*40,forward.y*40);
      stroke(0,255,0);
      line(0,0,steeringForce.x*200, steeringForce.y*200);
      stroke(100,100,100);
      line(0,0,target.x-position.x,target.y-position.y);
    }
    rotate(angle);
    shape(body,0,0);
    popMatrix();

  }
}