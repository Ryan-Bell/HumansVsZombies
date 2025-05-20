class Vehicle {
  constructor(x, y, r, ms, mf, type) {
    this.position = createVector(x, y);
    this.velocity = createVector();
    this.acceleration = createVector();
    this.forward = createVector();
    this.right = createVector();
    this.desired = this.position.copy();
    this.steeringForce = createVector();
    this.correctiveForce = createVector();
    this.target = this.position.copy();
    this.radius = r;
    this.maxSpeed = ms;
    this.maxForce = mf;
    this.type = type;
    this.mass = 1;
  }

  display() {
    push();
    translate(this.position.x, this.position.y);
    rotate(this.velocity.heading());
    if (this.type === 0) image(imgTree, -this.radius/2, -this.radius/2, this.radius, this.radius);
    else if (this.type === 1) image(imgZombie, -this.radius/2, -this.radius/2, this.radius, this.radius);
    else image(imgHuman, -this.radius/2, -this.radius/2, this.radius, this.radius);
    pop();
    return this;
  }

  update() {
    this.forward = this.velocity.copy().normalize();
    this.right.x = -this.forward.y;
    this.right.y = this.forward.x;
    this.correctiveForce.mult(0);
    if (this.position.x < buffer) this.correctiveForce.x = 1;
    if (this.position.x > width - buffer) this.correctiveForce.x = -1;
    if (this.position.y < buffer) this.correctiveForce.y = 1;
    if (this.position.y > height - buffer) this.correctiveForce.y = -1;
    this.avoidObject();
    this.calcSteeringForces();
    this.velocity.add(this.acceleration).limit(this.maxSpeed);
    this.position.add(this.velocity);
    this.acceleration.mult(0);
    return this;
  }

  applyForce(f) {
    this.acceleration.add(p5.Vector.div(f, this.mass));
    return this;
  }

  seek(target) {
    this.desired = p5.Vector.sub(target, this.position).normalize().mult(this.maxSpeed);
    return p5.Vector.sub(this.desired, this.velocity);
  }

  findClosest(subjects) {
    let tempDist;
    this.minDist = width;
    for (let v of subjects) {
      if ((tempDist = dist(v.position.x, v.position.y, this.position.x, this.position.y)) < this.minDist) {
        this.target = v.position.copy().add(p5.Vector.mult(v.velocity, 7));
        if (showDebug) ellipse(this.target.x, this.target.y, 5, 5);
        this.minDist = tempDist;
      }
    }
  }

  avoidObject() {
    let tempDist, safeDistance = 30;
    for (let v of objects) {
      let vecToCenter = p5.Vector.sub(v.position, this.position);
      if (vecToCenter.mag() > safeDistance) continue;
      if (vecToCenter.dot(this.forward) < 0) continue;
      if (Math.abs(tempDist = vecToCenter.dot(this.right)) > 45) continue;
      if (tempDist < 0) this.applyForce(this.right.copy().mult(this.maxSpeed * 0.5));
      else this.applyForce(this.right.copy().mult(-this.maxSpeed * 0.5));
    }
  }

  // abstract
  calcSteeringForces() {}
}
