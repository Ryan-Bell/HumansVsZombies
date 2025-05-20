class Zombie extends Vehicle {
  constructor(x, y, r, ms, mf, type) {
    super(x, y, r, ms, mf, type);
    this.range = 120;
  }

  calcSteeringForces() {
    this.findClosest(humans);
    this.steeringForce.mult(0);
    this.steeringForce.add(this.seek(this.target)).add(this.correctiveForce.mult(5)).limit(this.maxForce);
    this.applyForce(this.steeringForce);
  }
}
