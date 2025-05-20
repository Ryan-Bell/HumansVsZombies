class Human extends Vehicle {
  constructor(x, y, r, ms, mf, obstacle, type) {
    super(x, y, r, ms, mf, type);
    this.wanderRadius = 25;
    this.wanderDistance = 80;
    this.wanderDelta = 0.2;
    this.rotation = PI;
    this.range = 180;
    this.isObstacle = obstacle;
  }

  getSick() {
    zombies.push(new Zombie(this.position.x, this.position.y, 6, 3, 0.1, 1));
    humans.splice(humans.indexOf(this), 1);
  }

  calcSteeringForces() {
    this.findClosest(zombies);
    if (this.minDist < this.radius) {
      this.getSick();
      return;
    }
    if (this.minDist < this.range) {
      this.target = p5.Vector.add(this.position, p5.Vector.sub(this.position, this.target));
    } else {
      this.target = this.wander();
    }
    this.steeringForce.mult(0);
    this.steeringForce.add(this.seek(this.target)).add(this.correctiveForce.mult(5)).limit(this.maxForce);
    this.applyForce(this.steeringForce);
  }

  wander() {
    this.rotation += random(-this.wanderDelta, this.wanderDelta);
    return this.position.copy()
      .add(this.velocity.copy().normalize().mult(this.wanderDistance))
      .add(this.wanderRadius * cos(this.rotation + this.velocity.heading()),
           this.wanderRadius * sin(this.rotation + this.velocity.heading()));
  }
}
