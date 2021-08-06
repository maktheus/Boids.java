int days = 0;
int infected = 0;
int curado = 0;
int vacinado = 0;
int morto = 0;
int mascara = 0;

ArrayList<ArrayList<String>> exit = new ArrayList();
ArrayList<String> saidaC = new ArrayList();
ArrayList<String> saidaM = new ArrayList();

void draw() {
    days++;
    background(0);
    if (days % 100 != 0) {
        for (Boid b : boids) {
          if(b.inside == true ){      
           b.update();
           b.display(); 
          }
           Random gerador = new Random();
            double r = gerador.nextInt(100);
            if(b.morto ==false){
                if (r > 88 && r < 90  ) {
                    b.saida();  
                }
                if (r > 20 && r < 22 && days > 600) {
                    b.vacinado();
                } 
                if (r > 30 && r < 32 && b.contaminado == true && days > 500 && b.imunizado == false && b.vacinado == false){
                    b.morte();
                }
            }  
        }
    } 
    else {
        infected = 0;
        curado = 0;
        morto=0;
        for (Boid b : boids) {
           if(b.inside == true ){    
             b.update();
             b.display(); 
             if (b.contaminado == true) {
                infected++;
              }
              if (b.morto == true) {
                morto++;
              }  
          }
        } 
        
        
        saidaC.add(Integer.toString(infected));
        saidaM.add(Integer.toString(morto));
        exit.add(saidaC);
        exit.add(saidaM);
        if(exit.size()>2){
          exit.remove(2);
          exit.remove(2);
        }
        print(exit + "\n");
        
        //export CSV file
        File csvFile = new File("C:\\code\\Boids\\testout.txt");
        try{ 
            PrintWriter csvWriter = new PrintWriter(new FileWriter(csvFile)); 
            for (ArrayList < String > item : exit) {
              
                csvWriter.println(item);

            } 
            csvWriter.close();
        }
        catch(IOException e) {
            //Handle exception
            e.printStackTrace();
        }
        
    }   
}
