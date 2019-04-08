import java.util.*;
import java.lang.*;

// --------------------- Sketch-wide variables ----------------------
Table table;
String[] allSpeciesName = new String[128];
int speciesNum;
ArrayList<Species> allSpecies = new ArrayList<Species>();
float bigCircleDia = 600;
float interval;
PShape bigCircle;
PImage img;
String description;
boolean predPray = true, paraHost = true, predHost = true, paraPara = true;
int canvasX = 1350;
int canvasY = 720;
List< List<float[]> > preyCor = new ArrayList(); 
List< List<float[]> > predatorCor = new ArrayList(); 
// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.

// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.
public void settings() {
  size(canvasX, canvasY);
}
void setup(){
  smooth(); 
  // ELLIPSE x, y, width, height
  bigCircle = createShape(ELLIPSE,640,360,bigCircleDia,bigCircleDia);  
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
  for (int i = 3; i < table.getRowCount(); i++){
    allSpecies.add(new Species(table.getRow(i), bigCircleDia, i-3));
    } 
  speciesNum = allSpecies.size();
  Species cur = allSpecies.get(40);
  List<Float> relaPrey = cur.getRelations();
  preyCor.add(compFoodChainPrey(relaPrey, canvasX/2, canvasY/2, 1));
  int curSize = preyCor.size();
  int scaleSize = 0;
  for(int i = 0; i < curSize; i++){
    List<float []> temp = preyCor.get(i);
    scaleSize = temp.size();
    for(float[] curSpecies : temp){
    preyCor.add(compFoodChainPrey(allSpecies.get((int)(curSpecies[4])).getRelations(),curSpecies[0],curSpecies[1], scaleSize));
    }
  }
  predatorCor.add(compFoodChainPredator(40, canvasX/2, canvasY/2, 1));
  curSize = predatorCor.size();
  for(int i = 0; i < curSize; i++){
    List<float []> temp = predatorCor.get(i);
    scaleSize = temp.size();
    for(float[] curSpecies : temp){
    System.out.println(curSpecies[4]);
    predatorCor.add(compFoodChainPredator((int)curSpecies[4],curSpecies[0], curSpecies[1], scaleSize));
    }
  }
}
void draw(){
  background(255);
  textSize(12);
  for(List<float []> curSpecies: preyCor){
    for(float[] temp: curSpecies){
    line(temp[0],temp[1], temp[2], temp[3]);
    }
  }
  System.out.println(predatorCor.size());
  for(List<float []> curSpecies: predatorCor){
    for(float[] temp: curSpecies){
    line(temp[0],temp[1], temp[2], temp[3]);
    }
    
  }
  String type = allSpecies.get(40).getType();
  // If type is Basal, set the color to royal blue.
  if (type.equals("Basal")) fill(color(102,194,165));
  // If type is Freeliving, set the color to Spring Green1.
  else if (type.equals("Freeliving")) fill(color(252,141,98));
  // If type is Basal, set the color to Orange Red.
  else if (type.equals("Parasite")) fill(color(141,160,203));
  ellipse(canvasX/2,canvasY/2, 30, 30);
  fill(50);
  textAlign(CENTER);
  text(allSpecies.get(40).getName(), canvasX/2, canvasY/2 + 40);
  textSize(30);
  text("Food chains around " + allSpecies.get(40).getName() +".", canvasX/2, 100);
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
      ellipse(temp[0],temp[1], 30, 30);
      fill(50);
      text(allSpecies.get((int)temp[4]).getName(), temp[0] , temp[1] + 30);
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
      ellipse(temp[0],temp[1], 30, 30);
      fill(50);
      text(allSpecies.get((int)temp[4]).getName(), temp[0], temp[1] + 30);
    }
  }
}
  
  

public List<float[]> compFoodChainPrey(List<Float> rela, float x, float y, float level){
  List<float []> ret = new ArrayList<float[]>();
  int size = 0;
  if (level != 1) level = level / 3 * 2;
  float radius = 200 / level ;
  List<Integer> index = new ArrayList<Integer>();
  for(int i = 0; i < rela.size(); i++){
    if(Math.floor(rela.get(i)) == 4 || Math.floor(rela.get(i)) == 3) {
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
    System.out.println(temp[4]);
    ret.add(temp);
  }
  return ret;
}

public List<float[]> compFoodChainPredator(int index, float x, float y, float level){
  List<float []> ret = new ArrayList<float[]>();
  List<Float> curRela;
  int size = 0;
  if (level != 1) level = level / 3 * 2;
  float radius = 200 / level ;
  List<Integer> indexList = new ArrayList<Integer>();
  
  for(int i = 0; i < allSpecies.size();i++){
      curRela = allSpecies.get(i).getRelations();
      if(Math.floor(curRela.get(index)) == 4) {
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
    System.out.println(temp[4]);
    ret.add(temp);
  }
  return ret;
}
