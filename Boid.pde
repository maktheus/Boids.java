import java.util.Random;
class Boid {
      int days = 0;
      int dia_contaminado;
      PVector pos;
      PVector vel;
      PVector acc;
      
      boolean contaminado;
      boolean curado;
      boolean vacinado;
      boolean morto;
      boolean mascara;
      boolean inside;
      boolean imunizado;
      
      public Boid(PVector pos, PVector vel,boolean contaminado,boolean curado) {
          this.acc = new PVector();
          this.pos = pos;
          this.vel = vel;
          this.contaminado = contaminado;
          this.curado = curado;
          this.vacinado = false;
          this.morto = false;
          this.dia_contaminado = days;
          this.mascara = false;
          this.inside = true;
          this.imunizado = false;
  }
      
      void drawBoid(float x, float y, float heading) {
          
          pushMatrix();
          translate(x, y);
          rotate(heading);
          
          float shapeSize = 1;
          boidShape = createShape();
          boidShape.beginShape();
          
          //Mudanca de cores
          //saudavel
          if (contaminado ==  false) {
              boidShape.fill(0,0,255);  
            // circle(pos.x,pos.y, 3);
          }
          //saudavel com mascara
          
          //contaminado
          if (contaminado == true &&  curado ==  false) {
              boidShape.fill(255,0,0);
              
          }
          //com mascara
          
          //curado
          if (contaminado == false && curado == true) {
              boidShape.fill(0,255,0);  
          }
          //com mascara
          //vacinado
          if (vacinado == true) {
              boidShape.fill(218,165,32);
          }
          //com mascara
          
          //morto
          if (morto == true) {
              boidShape.fill(128,128,128);
          }
          // imunizado
          if (imunizado == true) {
              boidShape.fill(153,51,153);
          }
          //saiu da cidade
          if (inside ==  false) {
              boidShape.fill(10,10,10);
          }
          
          boidShape.vertex(shapeSize * 4, 0);
          boidShape.vertex( - shapeSize, shapeSize * 2);
          boidShape.vertex(0, 0);
          boidShape.vertex( - shapeSize, -shapeSize * 2);
          
          
          boidShape.endShape(CLOSE);
          shape(boidShape);
          popMatrix();
  }
      
      void display() {
          drawBoid(pos.x, pos.y, vel.heading());
          if (pos.x < 50) {
              drawBoid(pos.x + width, pos.y, vel.heading());
          }
          if (pos.x > width - 50) {
              drawBoid(pos.x - width, pos.y, vel.heading());
          }
          if (pos.y < 50) {
              drawBoid(pos.x, pos.y + height, vel.heading());
          }
          if (pos.y > height - 50) {
              drawBoid(pos.x, pos.y - height, vel.heading());
          }
  }
      
      void separate() {
          PVector target = new PVector();
          int total = 0;
          for (Boid other : boids) {
              float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
            if (other != this && d < radius  && other.morto ==  false) {
                  PVector diff = PVector.sub(pos, other.pos);
                  diff.div(d * d);
                  target.add(diff);
                  total++;
          }
          }
          if (total == 0) return;
          
          target.div(total);
          target.setMag(maxSpeed);
          PVector force = PVector.sub(target, vel);
          force.limit(maxForce);
          force.mult(sCoef);
          acc.add(force);
  }
      
      void cohere() {
          PVector center = new PVector();
          int total = 0;
          for (Boid other : boids) {
              float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
            if (other != this && d < radius  && other.morto ==  false) {
                  center.add(other.pos);
                  total++;
          }
          }
          if (total == 0) return;
          center.div(total);
          PVector target = PVector.sub(center, pos);
          target.setMag(maxSpeed);
          PVector force = PVector.sub(target, vel);
          force.limit(maxForce);
          force.mult(cCoef);
          acc.add(force);
  }
      
      void align() {
          PVector target = new PVector();
          int total = 0;
          for (Boid other : boids) {
              float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
            if (other != this && d < radius && other.morto ==  false) {
                  target.add(other.vel);
                  total++;
          }
          }
          if (total == 0) return;
          target.div(total);
          target.setMag(maxSpeed);
          PVector force = PVector.sub(target, vel);
          force.limit(maxForce);
          force.mult(aCoef);
          acc.add(force);
  }
      
      void contaminate() {
          PVector target = new PVector();
          int total = 0;
          for (Boid other : boids) {
              float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
            if (other != this && d < radius) {
                  other.contaminado = true;
                  other.dia_contaminado = days;
          }
          }
  }
      
      void sobreviver() {
          PVector target = new PVector();
          int total = 0;
          for (Boid other : boids) {
              float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
              if (other != this && d < radius && contaminado == true) {
                  curado = true;
          }
          }
  }
      
      void ficar_normal() {
        if(vacinado== false){
        Random gerador = new Random();
          double r = gerador.nextInt(100);
          if (r > 50 && r < 53) {
              curado = false;
              contaminado = false;
      }
       else{      
                  imunizado= true;
                  curado = false;
                  contaminado = false;
      }
          
        }
          
      }
  

  void vacinado() {
      curado = false;
      contaminado = false;
      vacinado = true;
  }

  void morte() {
      curado = false;
      contaminado = false;
      morto = true;
      vel.set(0.0, 0.0, 0.0);
  }


  void saida() {
      if (this.inside == true) {
          this.inside = false;
      } else{
          this.inside = true;
      }
  }


  void wrap() {
      if (pos.x < 0) { pos.x = width; }
      else if (pos.x >= width) { pos.x = 0; }
      if (pos.y < 0) { pos.y = height; }
      else if (pos.y >= height) { pos.y = 0; }
  }

  void update() {
      this.days += 1;
      Random gerador = new Random();
      double r = gerador.nextInt(100);
      acc = new PVector();
      
      if (morto != true && inside != false) {
          wrap();
          align();
          cohere();
          separate();
          if (contaminado ==  true && r > 88  && r < 90) {
              contaminate();
          }
          if (contaminado == true && r > 78 && r < 80 && days > 500) {
              sobreviver();
          }
          if (contaminado == true && curado == true && r > 76 && r < 78) {
              ficar_normal();
          }
  }
      pos.add(vel);
      vel.add(acc);
      vel.limit(maxSpeed);
  }
}
