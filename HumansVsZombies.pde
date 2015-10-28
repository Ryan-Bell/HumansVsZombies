//current bugs:
//Human targeting of zombies doesn't seem to be working. occasionally they sit up to the point of contact

PVector rightForce, upForce;
float buffer;
Zombie z;
boolean hp = false;
ArrayList<Human> humans;
ArrayList<Zombie> zombies;
void setup() {
  size(1000, 700);
  humans = new ArrayList<Human>();
  zombies = new ArrayList<Zombie>();
  for (int i = 0; i < 10; i++) {
    Human h = new Human(random(0, width), random(0, height), 6, 4, 0.1);
    humans.add(h);
  }
  z = new Zombie(width/2, height/2, 4, 3, 0.1);
  zombies.add(z);
  rightForce = new PVector(1,0);
  upForce = new PVector(0,-1);
  buffer = 90;
}

void draw() {
  background(255);
  fill(#E5D302);
  stroke(0);
  strokeWeight(2);

  for(int i = 0; i < zombies.size(); i++){ 
    debug(zombies.get(i).update().display());}
  for(int i = 0; i < humans.size(); i++){ 
    debug(humans.get(i).update().display());}
  //display debug method that will be called on all of the objects    
  //debug(humans.get(i).update().display();)} as an example
}

void debug(Vehicle subject){
    if(showDebug){
      pushMatrix();
      translate(subject.position.x, subject.position.y);
      stroke(255,0,0);
      line(0,0,subject.right.x*40, subject.right.y*40);
      stroke(0,0,255);
      line(0,0,subject.forward.x*40,subject.forward.y*40);
      stroke(0,255,0);
      line(0,0,subject.steeringForce.x*200, subject.steeringForce.y*200);
      stroke(100,100,100);
      line(0,0,subject.target.x - subject.position.x,subject.target.y-subject.position.y);
      popMatrix();
  }
}

boolean showDebug = true;
void mousePressed() {
  showDebug = !showDebug;
}