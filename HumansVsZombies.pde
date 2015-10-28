PVector rightForce, upForce;
float buffer;
Zombie z;
boolean hp = false;
ArrayList<Human> humans;
ArrayList<Zombie> zombies;
ArrayList<Vehicle> objects;
void setup() {
  size(1000, 700);
  rectMode(CENTER);
  humans = new ArrayList<Human>(400);
  zombies = new ArrayList<Zombie>(00);
  objects = new ArrayList<Vehicle>();
  for (int i = 0; i < 10; i++) {
    spawnHuman();
    spawnObject();}
  z = new Zombie(width/2, height/2, 2, 3, 0.1);
  zombies.add(z);
  rightForce = new PVector(1,0);
  upForce = new PVector(0,-1);
  buffer = 90;
}

void draw() {
  background(255);
  for(int i = 0; i < zombies.size(); i++){ 
    debug(zombies.get(i).update().display());}
  for(int i = 0; i < humans.size(); i++){ 
    debug(humans.get(i).update().display());}
  for(int i = 0; i < objects.size(); i++){ 
    objects.get(i).display();}
}

void spawnHuman(){
    humans.add(new Human(random(0, width), random(0, height), 20, 4, 0.2, true));}
void spawnObject(){
    objects.add(new Human(random(0, width), random(0,height), 0,0,0, false));}
void debug(Vehicle subject){
    if(showDebug){
      pushMatrix();
      translate(subject.position.x, subject.position.y);
      stroke(255,0,0);
      line(0,0,subject.right.x*40, subject.right.y*40);
      stroke(0,255,0);
      line(0,0,subject.steeringForce.x*200, subject.steeringForce.y*200);
      stroke(100,100,100);
      popMatrix();
      stroke(0);
  }
}

boolean showDebug = true;
void mousePressed() {
 showDebug = !showDebug;
}
void keyPressed() {

 spawnHuman();
}