class FlowField {
  
  final int resolution;
  final float fieldNoise;
  final float timeNoise;
  
  float[][] angles;
  float timeOffset;
  
  FlowField(int resolution) {
    this(resolution, 0.1, 0.01);
  }
  
  FlowField(int resolution, float fieldNoise, float timeNoise) {
    this.resolution = resolution;
    this.fieldNoise = fieldNoise;
    this.timeNoise = timeNoise;
    
    angles = new float[getWidth()][getHeight()];
    timeOffset = 0;
    
    update();
  }
  
  // Increment the noise's Z value and update the vectors' rotations
  void update() {
    for (int x = 0; x < getWidth(); x++) {
      for (int y = 0; y < getHeight(); y++) {
        angles[x][y] = map(noise(x * fieldNoise, y * fieldNoise, timeOffset * timeNoise), 0, 1, -TWO_PI, TWO_PI);
      }
    }
    timeOffset++;
  }
  
  // Get the closest vector in the field to a given pixel coordinate
  PVector getVecAt(float pixX, float pixY) {
    int vecX = int(pixX / resolution);
    int vecY = int(constrain(pixY, 0, height) / resolution);
    return PVector.fromAngle(angles[constrain(vecX, 0, getWidth() - 1)][constrain(vecY, 0, getHeight() - 1)]);
  }
  
  // How many vectors wide the field is
  int getWidth() {
    return int(width / resolution);
  }
  
  // How many vectors tall the field is
  int getHeight() {
    return int(height / resolution);
  }
  
  // Debug method to draw the flow field's vectors
  /*void show() {
    for (int x = 0; x < getWidth(); x++) {
      for (int y = 0; y < getHeight(); y++) {
        float vecX = x*resolution + (resolution/2);
        float vecY = y*resolution + (resolution/2);
        
        pushMatrix();
        translate(vecX, vecY);
        rotate(angles[x][y]);
        
        stroke(0, 255, 0);
        strokeWeight(1);
        line(-resolution/2, 0, resolution/2, 0);
        
        popMatrix();
      }
    }
  }*/
}
