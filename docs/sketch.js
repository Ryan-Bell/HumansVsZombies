let rightForce, upForce;
let buffer;
let humans = [];
let zombies = [];
let objects = [];
let imgZombie, imgHuman, imgTree;
let showDebug = true;

function preload() {
  imgZombie = loadImage('data/Zombie.png');
  imgHuman = loadImage('data/Human.png');
  imgTree = loadImage('data/Tree.png');
}

function setup() {
  createCanvas(1000, 700);
  rectMode(CENTER);
  buffer = 90;
  rightForce = createVector(1, 0);
  upForce = createVector(0, -1);
  for (let i = 0; i < 10; i++) {
    spawnHuman();
    spawnObject();
  }
  let z = new Zombie(width / 2, height / 2, 2, 3, 0.1, 1);
  zombies.push(z);
}

function draw() {
  background(255);
  for (let z of zombies) {
    debug(z.update().display());
  }
  for (let h of humans) {
    debug(h.update().display());
  }
  for (let o of objects) {
    o.display();
  }
}

function spawnHuman() {
  humans.push(new Human(random(0, width), random(0, height), 20, 4, 0.2, true, 2));
}

function spawnObject() {
  objects.push(new Human(random(0, width), random(0, height), 30, 0, 0, false, 0));
}

function debug(subject) {
  if (showDebug) {
    push();
    translate(subject.position.x, subject.position.y);
    stroke(255, 0, 0);
    line(0, 0, subject.right.x * 40, subject.right.y * 40);
    stroke(0, 255, 0);
    line(0, 0, subject.steeringForce.x * 200, subject.steeringForce.y * 200);
    pop();
    stroke(0);
  }
}

function mousePressed() {
  showDebug = !showDebug;
}

function keyPressed() {
  spawnHuman();
}
