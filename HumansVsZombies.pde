//This is the main file for the program. It contains the global variables and handles the setup of the simulation as well
//as the drawing. It also sets what the keyPressed and mouseClicked action listeners do.

PVector rightForce, upForce;                                  //two vectors that will be used in adding corrective forces
float buffer;                                                 //The bounding padding where corrective forces start being applied
Zombie z;                                                     //The initial zombie
boolean hp = false;         
ArrayList<Human> humans;                                      //This will hold all of the human objects
ArrayList<Zombie> zombies;                                    //This will hold all of the zombie objects
ArrayList<Vehicle> objects;                                   //This will hold all of the obstacles as Vehicle objects
PImage zomb, hum, tree;                                       //These are the images for each of the drawn items
void setup() {
  size(1000, 700);                                            //setting window size to 1000by700
  rectMode(CENTER);                                           //positions for drawing the images will be in relation to the center not corner
  zomb = loadImage("data/Zombie.png");                        //loading in the images and saving them as the respective PImage
  hum = loadImage("data/Human.png");
  tree = loadImage("data/Tree.png");
  humans = new ArrayList<Human>(400);                         //Instantiating the ArrayLists for the various vehicles with an initial
  zombies = new ArrayList<Zombie>(400);                       //size of 400 for both the zombies and the humans to make adding more less
  objects = new ArrayList<Vehicle>();                         //laggy (up to 400 objects at which point the list will have to double)
  for (int i = 0; i < 10; i++) {                              //loop to instantiate 10 humans and objects by calling the spawn functions
    spawnHuman();
    spawnObject();}
  z = new Zombie(width/2, height/2, 2, 3, 0.1,1);             //create the initial zombie in the center of the screen
  zombies.add(z);                                             //add the zombie to the zombie arrayList
  rightForce = new PVector(1,0);                              //instantiate the two corrective forces as unit vectors or the four cardinal directions
  upForce = new PVector(0,-1);
  buffer = 90;                                                //set the value of the buffer to 90 pixels inside the 'walls'
}

void draw() {
  background(255);                                            //draw over the previous frame at the beginning of the new frame
  for(int i = 0; i < zombies.size(); i++){                    //call update then display on each zombie then pass it into the debug method to print lines
    debug(zombies.get(i).update().display());}
  for(int i = 0; i < humans.size(); i++){                     //same as above but with the humans
    debug(humans.get(i).update().display());}
  for(int i = 0; i < objects.size(); i++){                    //same as above but with the objects and without the call to debug
    objects.get(i).display();}
}

void spawnHuman(){                                            //adds a new human to a random location on the map
    humans.add(new Human(random(0, width), random(0, height), 20, 4, 0.2, true, 2));}
void spawnObject(){                                           //adds a new object to a random location on the map
    objects.add(new Human(random(0, width), random(0,height), 30,0,0, false,0));}
void debug(Vehicle subject){                                        
    if(showDebug){                                            //checks that debug is on
      pushMatrix();                                           //push a matrix on the stack and translate based on the position of the param vehicle
      translate(subject.position.x, subject.position.y);
      stroke(255,0,0);                                        //draw a red right vector
      line(0,0,subject.right.x*40, subject.right.y*40);
      stroke(0,255,0);                                        //draw a green steering vector scaled up
      line(0,0,subject.steeringForce.x*200, subject.steeringForce.y*200);
      popMatrix();                                            //pop the matrix off the stack
      stroke(0);                                              //set the color back to black
  }
}

boolean showDebug = true;                                     //instantiate the debug boolean to a start value of true
void mousePressed() {                                         //set the action
 showDebug = !showDebug;
}
void keyPressed() {

 spawnHuman();
}
