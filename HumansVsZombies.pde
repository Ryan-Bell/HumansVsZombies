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
  buffer = 50;
}

void draw() {
  background(255);
  fill(#E5D302);
  stroke(0);
  strokeWeight(2);

  for(int i = 0; i < zombies.size(); i++){ 
    zombies.get(i).update().display();}
//    zombies.get(i).display();}
  for(int i = 0; i < humans.size(); i++){ 
    humans.get(i).update();
    humans.get(i).display();}
}
boolean showDebug = true;
void mousePressed() {
  showDebug = !showDebug;
}