class Agent {
  
  PVector acceleration;
  PVector velocity;
  PVector position;
  
  final FlowField field;
  final float maxForce;
  final float maxSpeed;
  
  Agent(float initialX, float initialY, FlowField field) {
    this.field = field;
    
    // Randomize force and speed
    maxForce = random(0.1, 0.5);
    maxSpeed = random(2, 30);
    
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(initialX, initialY);
  }
  
  // Follow the flow field
  void follow() {
    PVector desired = field.getVecAt(position.x, position.y);
    desired.normalize();
    desired.mult(maxSpeed);
    acceleration = desired;
    acceleration.limit(maxForce);
  }
  
  // Send offscreen boids to the opposite side of the screen
  void constrain() {
    if (position.x > width) {
      position.x = 0;
    }
    if (position.x < 0) {
      position.x = width;
    }
    
    if (position.y > height) {
      position.y = 0;
    }
    if (position.y < 0) {
      position.y = height;
    }
  }
  
  void update() {
    follow();
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    
    constrain();
  }
}
