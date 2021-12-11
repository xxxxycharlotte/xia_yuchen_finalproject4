class Stroke {
  ArrayList<PVector> points;
  int lifetime = 1000;
  int timestamp = 0;
  boolean alive = true;
  int size=int(random(10, 30));
  color mycolor1, mycolor2;
  color color1, color2;
  int startIndex=int(random(4));
  float lerp=0;
  Stroke() {
    points = new ArrayList<PVector>();
    timestamp = millis();
    mycolor1=cols[int(random(cols.length))];
    mycolor2=cols[int(random(cols.length))];
  }

  void update() {
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      p.x=p.x+map(noise(5+frameCount*p.x), 0, 1, -8, 8);
      p.y=p.y+map(noise(frameCount*p.y), 0, 1, -8, 8);
      if (p.x>width-120) {
        alive = false;
      }
      if (p.x<120) {
        alive = false;
      }
      if (p.y>height-120) {
        alive = false;
      }
      if (p.y<120) {
        alive = false;
      }
    }

    if (millis() > timestamp + lifetime) {
      alive = false;
    }
    if (lerp<1) {
      lerp+=0.02;
    }
  }

  void draw() {
    for (int i=0; i<points.size(); i++) {
      int index=i%6;
      mycolor1=cols[index+startIndex];
      mycolor2=cols[index*2+startIndex];
      color2=lerpColor(mycolor1, mycolor2, lerp);
      color1=lerpColor(mycolor2, mycolor1, lerp);
      PVector p = points.get(i);
      //p.x += random(5) - random(5);
      fill(color1);
      stroke(color2);
      //strokeWeight(random(2, 10));
      strokeWeight(4);
      if (index==0) {
        ellipse(p.x, p.y, size, size);
      } else if (index==1) {
        pushMatrix();
        translate(p.x, p.y);
        rotate(-PI/6);
        triangle(size*cos(PI/3), size*sin(PI/3), size*cos(PI), size*sin(PI), size*cos(2*PI-PI/3), size*sin(2*PI-PI/3));
        popMatrix();
      } else if (index==2) {
        rect(p.x, p.y, size, size);
      } else if (index==3) {
        pushMatrix();
        translate(p.x, p.y);
        beginShape();
        int num=10;
        for (int j=0; j<num; j++) {
          float rad;
          if (j%2==0) {  
            rad=size*0.8;
          } else {
            rad=size/2*0.8;
          }
          float xpos=cos(j*TWO_PI/num)*rad;
          float ypos=sin(j*TWO_PI/num)*rad;
          vertex(xpos, ypos);
        }
        endShape(CLOSE);
        popMatrix();
      } else if (index==4) {
        rect(p.x, p.y, 1.4*size, size*0.8);
      } else {
        point(p.x, p.y);
      }
      if (i > 0) {
        PVector p2 = points.get(i-1);
        strokeWeight(2);
        line(p.x, p.y, p2.x, p2.y);
      }
    }
  }

  void run() {
    update();
    draw();
  }
}
