ArrayList<Stroke> strokes;
int marktime = 0;
int timeout = 3000;
color[] cols={#c48b3a, #869986, #8c659c, #e88b45, #264a48, #a38f5d, #9da1c2, #c97ca8, 
  #0a080b, #0c0a0d, #1d2e7c, #4485bd, #e8da56, #a85237, #683d34, #a63b41};
int state=0;
float[]vels={1, 0.5, 0.5, 0.5, 1, 1, 0.5, 1};

void setup() {
  size(900, 900, P2D);
  background(255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  setupXYscope();
  strokes = new ArrayList<Stroke>();
}

void draw() {
  background(199, 211, 183);
  strokeWeight(20);
  stroke(255, 200);
  noFill();
  rect(width/2, height/2, width-200, height-200);
  toStart();
  if (state==1) {
    updateXYscope();
    for (int i=strokes.size()-1; i >= 0; i--) {
      Stroke stroke = strokes.get(i);
      stroke.run();
      if (!stroke.alive) strokes.remove(i);
    }

    if (millis() > marktime + timeout) {
      xy.clearWaves();
    }

    surface.setTitle("" + frameRate);
  }
}
void toStart() {
  if (state==0) {
    fill(69, 137, 148);
    noStroke();
    rect(width/2, height/2, 300, 100);
    fill(255);
    textSize(25);
    text("CLICK HERE TO START", width/2, height/2-20);
    textSize(15);
    text("KEY 1-8 TO PLAY MUSIC", width/2, height/2+30);
  }
}

void mouseClicked() {
  if (state==0) {
    if ((mouseX>width/2-150)&&(mouseX<width/2+150)&&(mouseY>height/2-50)&&(mouseY<height/2+50)) {
      state=1;
    }
  }
}

void mouseDragged() {
  if (state==1) {
    xy.line(mouseX, mouseY, pmouseX, pmouseY);
    if (strokes.size() > 0) {
      Stroke stroke = strokes.get(strokes.size()-1);
      stroke.points.add(new PVector(mouseX, mouseY));
      //stroke.points.add(new PVector(width-mouseX, height-mouseY));
      stroke.timestamp = millis();
    }

    marktime = millis();
  }
}

void mousePressed() {
  if (state==1) {
    Stroke stroke = new Stroke();
    strokes.add(stroke);
  }
}
