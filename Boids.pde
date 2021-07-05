int n; // How many boids we have.
float sCoef;
float aCoef;
float cCoef;
float radius;

float maxSpeed;
float maxForce;

Boid boid[];
ArrayList<Boid> boids = new ArrayList();

PShape boidShape;
  import java.util.Random;
void setup() {
  size(1920, 1080);
  frameRate(60);
  
  n = 1000;
  aCoef = 0.3;
  sCoef = 0.5;
  cCoef = 0.5;
  radius = 100;
  
  maxSpeed = 3;
  maxForce = 0.1;
  
  boid = new Boid[n];
  
  for (int i = 0; i < boid.length; i++) {
    if(i==0){
    boid[i] = new Boid(new PVector(random(0, width), random(0, height)), PVector.random2D(),true,false);
    boids.add(boid[i]);
    }
    else{
    boid[i] = new Boid(new PVector(random(0, width), random(0, height)), PVector.random2D(),false,false);
    boids.add(boid[i]);
    }
  }
 

}
