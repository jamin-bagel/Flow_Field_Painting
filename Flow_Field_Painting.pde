import processing.video.*;

FlowField ff;
ArrayList<Agent> agents; // Boids that do the drawing
Capture cam; // Camera to read from

boolean clickToAdd = true; // Disable this to start the program with the boids already onscreen
String note = "Click and drag to add boids. The more you add, the faster the image updates!";

void setup() {
  size(1000, 750);
  
  ff = new FlowField(20);
  agents = new ArrayList<>();
  // If click-to-drag is disabled, automatically create the boids at random positions
  if (!clickToAdd) {
    for (int i = 0; i < 5000; i++) {
      agents.add(new Agent(random(width), random(height), ff));
    }
  }
  
  // Setup camera
  cam = new Capture(this, width, height, Capture.list()[0]);
  cam.start();
  
  background(255);
}

// Update camera PImage
void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  cam.read();
  
  // Click to add boids
  if (clickToAdd && mousePressed) {
    agents.add(new Agent(mouseX, mouseY, ff));
  }
  
  // Change the flow field
  ff.update();
    
  // Draw using the boids
  for (Agent agent : agents) {
    agent.update();
    int x = int(agent.position.x);
    int y = int(agent.position.y);
    
    stroke(cam.get(x, y));
    strokeWeight(3);
    point(x, y);
  }
  
  // Note across the bottom
  noStroke();
  fill(0);
  rect(0, height - 30, width, height);
  fill(255);
  textSize(20);
  text(note, 3, height - 7);
}
