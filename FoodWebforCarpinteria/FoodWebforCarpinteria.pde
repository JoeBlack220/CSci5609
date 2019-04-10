import java.util.*;
import java.lang.*;

// --------------------- Sketch-wide variables ----------------------
Table table;
String[] allSpeciesName = new String[128];
int speciesNum;
ArrayList<Species> allSpecies = new ArrayList<Species>();
float bigCircleDia = 600;
float interval;
long last;
PShape bigCircle;
PImage img;
String description;
boolean predPray = true, paraHost = true, predHost = true, paraPara = true;
int buttonX = 50, buttonY = 120;
int canvasX = 1920;
int canvasY = 1080;
int foodChainX = 1500;
int foodChainY = 525;
int foodChainRadius = 20;
int foodChainLine = 200;
int foodChainIndex = 40;
double connectance;
List< List<float[]> > preyCor = new ArrayList(); 
List< List<float[]> > predatorCor = new ArrayList(); 
// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.

// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.


void setup(){
  size(1920, 1080);
  smooth(); 
  // ELLIPSE x, y, width, height
  bigCircle = createShape(ELLIPSE,725,475,bigCircleDia,bigCircleDia);  
  // Load the data table.
  table = loadTable("carpinteria.csv");
  // The first row of the table saves all the name of species in the food web.
  // Extract them all and save them in a String array.
  TableRow row0 = table.getRow(0);
  for (int i = 2;i < row0.getColumnCount();i++){
    allSpeciesName[i-2] = row0.getString(i);
  }
  // The first two columns are not species name
  // Initialize save all species information into an arraylist
  int totalNum = table.getRowCount();
  for (int i = 3; i < totalNum; i++){
    allSpecies.add(new Species(table.getRow(i), bigCircleDia, i-3, totalNum - 3));
    } 
  speciesNum = allSpecies.size();
  setFoodChains(foodChainIndex);
  computeConnectance();
  
}

void mouseClicked(MouseEvent evt){
  if(evt.getCount() == 2) deleteFoodChainIndex(mouseX,mouseY);
  //last = millis();
  if (mouseX <= buttonX+10 && mouseX >= buttonX && mouseY <= buttonY+10 && mouseY >= buttonY) {
    if (predPray == false) predPray = true;
    else predPray = false;
  }
  if (mouseX <= buttonX+10 && mouseX >= buttonX && mouseY <= buttonY+30 && mouseY >= buttonY+20) {
    if (paraHost == false) paraHost = true;
    else paraHost = false;
  }
  if (mouseX <= buttonX+10 && mouseX >= buttonX && mouseY <= buttonY+50 && mouseY >= buttonY+40) {
    if (predHost == false) predHost = true;
    else predHost = false;
  }
  if (mouseX <= buttonX+10 && mouseX >= buttonX && mouseY <= buttonY+70 && mouseY >= buttonY+60) {
    if (paraPara == false) paraPara = true;
    else paraPara = false;
  }
  if(mouseX <= 650 + 20 && mouseX >= 650 && mouseY <= 920 + 20 && mouseY >= 920) resetFoodWeb();
  setFoodChainIndex(mouseX, mouseY);
}


void draw()
{ 
   //if (millis()-last > 1000 * 1l){
   textAlign(LEFT);
   background(255); 
   shape(bigCircle,0,0);
   stroke(0);
   textSize(15);
   fill(0);
   text("Subwebs (click to select)", 45, 110);
   
   if (predPray) fill(152,78,163);
   else noFill();
   rect(buttonX, buttonY, 10, 10);
   fill(152,78,163);
   text("pedator-prey", buttonX+13, buttonY+10); 
   
   if (paraHost) fill(247,129,191);
   else noFill();
   rect(buttonX, buttonY+20, 10, 10);
   fill(247,129,191);
   text("parasite-host", buttonX+13, buttonY+30);
   
   if (predHost) fill(78,179,211);
   else noFill();
   rect(buttonX, buttonY+40, 10, 10);
   fill(78,179,211);
   text("predator-parasite", buttonX+13, buttonY+50);
   
   if (paraPara) fill(153,153,153);
   else noFill();
   rect(buttonX, buttonY+60, 10, 10);
   fill(153,153,153);
   text("parasite-parasite", buttonX+13, buttonY+70);
   //reset button
   rect(650,920,20,20);
   fill(0);
   text("Reset the food web", 650+25, 935);

   int tplX = 40, tplY = 350;
   fill(255,255,51); rect(tplX, tplY, 10, 10);
   fill(255,127,0); rect(tplX, tplY+20, 10, 10);
   fill(228,26,28); rect(tplX, tplY+40, 10, 10);
   fill(152,78,163); rect(tplX, tplY+60, 10, 10);
   fill(247,129,191); rect(tplX, tplY+85, 10, 10);
   fill(102,166,30); rect(tplX, tplY+105, 10, 10);
   fill(78,179,211); rect(tplX, tplY+150, 10, 10);
   fill(153,153,153); rect(tplX, tplY+170, 10, 10);
   
   textSize(13);
   fill(0);
   text("Types of links", tplX, 340);
   textSize(12);
   text("first intermediate host", tplX+20, tplY+10);
   text("first and second intermediate host", tplX+20, tplY+30);
   text("second intermediate host", tplX+20, tplY+50);
   text("final intermediate host", tplX+20, tplY+70);
   text("predator-prey and egg predator", tplX+20, tplY+90);
   text("predation on free-living cercarial", tplX+20, tplY+110);
   text("stage of a trematode and", tplX+20, tplY+125);
   text("micropredation (mosquito)", tplX+20, tplY+140);
   text("predation on parasite in a host", tplX+20, tplY+160); 
   text("parasite-parasite", tplX+20, tplY+180);
   
   int tpsX = 55, tpsY = 250;
   fill(102,194,165); circle(tpsX, tpsY, 15);
   fill(1252,141,98); circle(tpsX, tpsY+20, 15);
   fill(141,160,203); circle(tpsX, tpsY+40, 15);
   
   fill(0);
   textSize(14);
   text("Types of species", tpsX-10, tpsY-15);
   textSize(14);
   text("Basal", tpsX+10, tpsY+5);
   text("Freeliving", tpsX+10, tpsY+25);
   text("Parasite", tpsX+10, tpsY+45);
   
   //textSize(12);
   //text("Citation: ", 970, 500);
   //text("CLafferty, K. D., R. F. Hechinger, J. C. Shaw, K. L. Whitney ", 970, 520);
   //text("and A. M. Kuris (in press) ", 970, 535);
   //text("Food webs and parasites in a salt marsh ecosystem. ", 970, 555);
   //text("In Disease ecology: community structure and pathogen", 970, 575);
   //text("dynamics (eds S. Collinge and C. Ray). ", 970, 590);
   //text("Oxford University Press, Oxford.", 970, 605);
   
   //noFill();
   //rect(960, 480, 350, 140);
   //rect(80, 300, 220, 350);
   
   
   text("Connectance: " + connectance, 650, 980);
   //img = loadImage("image/41.jpg");
   //image(img, 95, 330, 180, 120);
   //textSize(15);
   //description = "Charadrius vociferus (Killdeer) is a species of bird in the family Charadriidae. It is found in the Neotropics and the Nearctic. It is a carnivore.";
   //text(description, 90, 465, 200, 650);
   
   for(int i = 0; i < speciesNum; i++){
     // draw the relationships involving i if i is still activated
     if (allSpecies.get(i).getStatus()) drawFoodWeb(i);
   }

   drawFoodChains(foodChainIndex);
   //}
 
}
public void drawFoodWeb(int i){
   int t=i;
   pushMatrix();
   fill(0);
   textSize(10);
   rotate(t*PI/64);
   translate(allSpecies.get(t).getXNum()*cos(t*PI/64)+allSpecies.get(t).getYNum()*sin(t*PI/64), -allSpecies.get(t).getXNum()*sin(t*PI/64)+allSpecies.get(t).getYNum()*cos(t*PI/64)+3);
   text(allSpecies.get(t).getName(), 0,0);
   popMatrix();
   shape(allSpecies.get(i).getShape(),0,0);
   for(int j = 0; j < speciesNum; j++){
     // draw relations between i and j if j is still activated
     if(allSpecies.get(j).getStatus()){
       float ijRelation = allSpecies.get(i).getRelations().get(j);
       // draw links if two speceis have relations
       
       if(ijRelation!=0) {
         if (predPray){
           if(ijRelation==1) {
             strokeWeight(0.5);
             stroke(255,255,51);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           }
           if(ijRelation==1.2||ijRelation==1.25) {
             strokeWeight(0.5);
             stroke(255,127,0);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           }
           if(ijRelation==2||ijRelation==2.5) {
             strokeWeight(0.5);
             stroke(228,26,28);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           }
           if(ijRelation==3) {
             strokeWeight(0.5);
             stroke(152,78,163);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());          }
         }
         if(paraHost){
           if(ijRelation==4||ijRelation==4.1||ijRelation==4.11||ijRelation==4.2) {
             strokeWeight(0.45);
             stroke(247,129,191);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           }
         }
         if (predHost){
           if(ijRelation==5||ijRelation==6) {
             strokeWeight(0.5);
             stroke(102,166,30);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           } 
           if(ijRelation==7||ijRelation==8) {
             strokeWeight(0.25);
             stroke(78,179,211);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           } 
         }
         if (paraPara){
           if(ijRelation==9) {
             strokeWeight(0.5);
             stroke(153,153,153);
             line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
           } 
         }
       }
     }
   }
}

public void resetFoodWeb(){
 for(Species s: allSpecies){
   s.setStatus(true);
 }
 computeConnectance();
}

public void computeConnectance(){
  // trophic elements
  int S = 0;
  // basal + primary producers
  int ppba = 0;
  // predators
  int pr = 0;
  // total link
  double link = 0;

  for(Species s: allSpecies){
    if(s.getStatus()){
      S ++;
      if(s.getType().equals("basal")) ppba++;
      else pr ++;
      for(int j = 0; j < speciesNum; j++){
        if(allSpecies.get(j).getStatus()){
          if(s.getRelations().get(j) != 0) link ++;
        }
      }
    }
  }
  connectance = (link / (Math.pow(S, 2) - (ppba)*S + S - ppba + pr*ppba));
}

public List<float[]> compFoodChainPrey(List<Float> rela, float x, float y, float level){
  List<float []> ret = new ArrayList<float[]>();
  int size = 0;
  // set the maximum number of a level for clearance
  int max = 3;
  if (level != 1) level = level / 3 * 2;
  float radius = foodChainLine / level ;
  List<Integer> index = new ArrayList<Integer>();
  for(int i = 0; i < rela.size(); i++){
    // only find predator-prey relationships
    if(Math.floor(rela.get(i)) == 4 || Math.floor(rela.get(i)) == 3) {
      if(size >= max) break;
      size++;
      index.add(i);
    }
  }
  float interval = (float)Math.PI / (size + 1);
  float[] temp;
  for(int i = 0; i < size; i++){
    temp = new float[5];
    temp[0] = (float)(x + radius * Math.sin(interval*(i+1)));
    temp[1] = (float)(y - radius * Math.cos(interval*(i+1)));
    temp[2] = x;
    temp[3] = y;
    temp[4] = index.get(i);
    ret.add(temp);
  }
  return ret;
}

public List<float[]> compFoodChainPredator(int index, float x, float y, float level){
  List<float []> ret = new ArrayList<float[]>();
  List<Float> curRela;
  int size = 0;
  // set the maximum number of a level for clearance
  int max = 3;
  if (level != 1) level = level / 3 * 2;
  float radius = foodChainLine / level ;
  List<Integer> indexList = new ArrayList<Integer>();
  
  for(int i = 0; i < allSpecies.size();i++){
      curRela = allSpecies.get(i).getRelations();
      if(Math.floor(curRela.get(index)) == 4) {
        if(size >= max) break;
        indexList.add(i);
        size++;
    }
  }
  float interval = (float)Math.PI / (size + 1);
  float[] temp;
  for(int i = 0; i < size; i++){
    temp = new float[5];
    temp[0] = (float)(x - radius * Math.sin(interval*(i+1)));
    temp[1] = (float)(y - radius * Math.cos(interval*(i+1)));
    temp[2] = x;
    temp[3] = y;
    temp[4] = indexList.get(i);
    ret.add(temp);
  }
  return ret;
}

public void setFoodChains(int index){
  Species cur = allSpecies.get(index);
  List<Float> relaPrey = cur.getRelations();
  preyCor.add(compFoodChainPrey(relaPrey, foodChainX, foodChainY, 1));
  int curSize = preyCor.size();
  int scaleSize = 0;
  for(int i = 0; i < curSize; i++){
    List<float []> temp = preyCor.get(i);
    scaleSize = temp.size();
    for(float[] curSpecies : temp){
    preyCor.add(compFoodChainPrey(allSpecies.get((int)(curSpecies[4])).getRelations(),curSpecies[0],curSpecies[1], scaleSize));
    }
  }
  predatorCor.add(compFoodChainPredator(index, foodChainX, foodChainY, 1));
  curSize = predatorCor.size();
  for(int i = 0; i < curSize; i++){
    List<float []> temp = predatorCor.get(i);
    scaleSize = temp.size();
    for(float[] curSpecies : temp){
    predatorCor.add(compFoodChainPredator((int)curSpecies[4], curSpecies[0], curSpecies[1], scaleSize));
    }
  }
}

public void drawFoodChains(int index){
  Species curS = allSpecies.get(index);
  for(List<float []> curSpecies: preyCor){
    for(float[] temp: curSpecies){
    line(temp[0],temp[1], temp[2], temp[3]);
    }
  }
  for(List<float []> curSpecies: predatorCor){
    for(float[] temp: curSpecies){
    line(temp[0],temp[1], temp[2], temp[3]);
    }
    
  }
  String type = curS.getType();
  // If type is Basal, set the color to royal blue.
  if (type.equals("Basal")) fill(color(102,194,165));
  // If type is Freeliving, set the color to Spring Green1.
  else if (type.equals("Freeliving")) fill(color(252,141,98));
  // If type is Basal, set the color to Orange Red.
  else if (type.equals("Parasite")) fill(color(141,160,203));
  ellipse(foodChainX, foodChainY, foodChainRadius, foodChainRadius);
  fill(50);
  textAlign(CENTER);
  textSize(9);
  text(curS.getName(), foodChainX, foodChainY + 15);
  textSize(18);
  text("Food chains around " + curS.getName() +".", foodChainX, foodChainY - 250);
  textSize(12);
  for(List<float []> curSpecies: preyCor){
    for(float[] temp: curSpecies){
      type = allSpecies.get((int)temp[4]).getType();
      // If type is Basal, set the color to royal blue.
      if (type.equals("Basal")) fill(color(102,194,165));
      // If type is Freeliving, set the color to Spring Green1.
      else if (type.equals("Freeliving")) fill(color(252,141,98));
      // If type is Basal, set the color to Orange Red.
      else if (type.equals("Parasite")) fill(color(141,160,203));
      ellipse(temp[0],temp[1], foodChainRadius, foodChainRadius);
      fill(50);
      textAlign(LEFT);
      textSize(9);
      String[] printName = allSpecies.get((int)temp[4]).getName().split(" ");
      for(int i = 0; i < printName.length ;i++){
        text(printName[i], temp[0] - 10 , temp[1] + 18 + 8*i);
      }
    }
  }
  for(List<float []> curSpecies: predatorCor){
    for(float[] temp: curSpecies){
      type = allSpecies.get((int)temp[4]).getType();
      // If type is Basal, set the color to royal blue.
      if (type.equals("Basal")) fill(color(102,194,165));
      // If type is Freeliving, set the color to Spring Green1.
      else if (type.equals("Freeliving")) fill(color(252,141,98));
      // If type is Basal, set the color to Orange Red.
      else if (type.equals("Parasite")) fill(color(141,160,203));
      ellipse(temp[0],temp[1], foodChainRadius, foodChainRadius);
      fill(50);
      textAlign(RIGHT);
      textSize(9);
      String[] printName = allSpecies.get((int)temp[4]).getName().split(" ");
      for(int i = 0; i < printName.length ;i++){
        text(printName[i], temp[0] + 10 , temp[1] + 18 + 8*i);
      }
    }
  }
   textAlign(LEFT);
   textSize(18);
   text(curS.getName(), 1400, 825);
   img = curS.getImg();
   image(img, 1100, 810,300,220);
   textSize(15);
   description = curS.getDesc();
   text(description, 1400, 840, 400, 200);
}

public void setFoodChainIndex(float x, float y){
  for(int i = 0; i < allSpecies.size(); i++){
    Species s = allSpecies.get(i);
    if(x < s.getXCor() + s.getDia()/2 && x > s.getXCor() - s.getDia()/2 
    && y > s.getYCor() - s.getDia()/2 && y < s.getYCor() + s.getDia()/2 ){
      foodChainIndex = i;
      preyCor = new ArrayList(); 
      predatorCor = new ArrayList(); 
      setFoodChains(foodChainIndex);
      return;
    }
  }
}

public void deleteFoodChainIndex(float x, float y){
    for(int i = 0; i < allSpecies.size(); i++){
    Species s = allSpecies.get(i);
    if(x < s.getXCor() + s.getDia()/2 && x > s.getXCor() - s.getDia()/2 
    && y > s.getYCor() - s.getDia()/2 && y < s.getYCor() + s.getDia()/2 ){
      allSpecies.get(i).setStatus(false);
      computeConnectance();
      return;
    }
  }
}
