import java.util.*;
import java.lang.*;

// --------------------- Sketch-wide variables ----------------------
Table table;
String[] allSpeciesName = new String[128];
int speciesNum;
ArrayList<Species> allSpecies = new ArrayList<Species>();
float bigCircleDia = 600;
float interval;
//PShape bigCircle;
// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.

// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.


void setup(){
  size(1650, 900, P3D);
  smooth(); 
  // ELLIPSE x, y, width, height
  //bigCircle = createShape(ELLIPSE,725,475,bigCircleDia,bigCircleDia);  
  // Load the data table.
  table = loadTable("carpinteria.csv");
  // The first row of the table saves all the name of species in the food web.
  // Extract them all and save them in a String array.
  TableRow row0 = table.getRow(0);
  for (int i = 3;i < row0.getColumnCount();i++){
    allSpeciesName[i-3] = row0.getString(i);
  }
  // The first two columns are not species name
  // Initialize save all species information into an arraylist
  for (int i = 3; i < table.getRowCount(); i++){
    allSpecies.add(new Species(table.getRow(i), bigCircleDia, i-3));
    } 
  speciesNum = allSpecies.size();
  
}



void draw()
{
 background(0); 
 stroke(255); 
 noStroke();
 directionalLight(255, 255, 255,  1, -0.5, -0.5);
 
 // add camera interaction
  float minDist = 200;
  float maxDist = 1500;
  //  Zoom in/out with the camera
  float cameraDistance = lerp(minDist, maxDist, float(mouseY)/height);
  // use the current mouse position with mouseY to dolly the camera position towards and away from the data. 
  camera(cameraDistance,cameraDistance,cameraDistance, 0,0,0, 0,0,-1);
  // Rotate the data
  rotateZ(radians(0.25*mouseX));
 
 
 for(int i = 0; i < speciesNum; i++){  
    if (allSpecies.get(i).getLevel()==1) fill(179,222,105);
    else if (allSpecies.get(i).getLevel()==2) fill(253,180,98);
    else if (allSpecies.get(i).getLevel()==3) fill(128,177,211);
    else if (allSpecies.get(i).getLevel()==4) fill(251,128,114);
    else if (allSpecies.get(i).getLevel()==5) fill(190,186,218);
    else if (allSpecies.get(i).getLevel()==6) fill(255,255,179);
    else fill(141,211,199);
   pushMatrix();
   lights();
   translate(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(i).getZCor());
   sphere(15);
   popMatrix();
 }
 stroke(255);
 for(int i = 0; i < speciesNum; i++){
   fill(255);
   text(allSpecies.get(i).getName(), allSpecies.get(i).getXCor()+15, allSpecies.get(i).getYCor(), allSpecies.get(i).getZCor());
   if (allSpecies.get(i).getLevel()==1) stroke(179,222,105);
   else if (allSpecies.get(i).getLevel()==2) stroke(253,180,98);
   else if (allSpecies.get(i).getLevel()==3) stroke(128,177,211);
   else if (allSpecies.get(i).getLevel()==4) stroke(251,128,114);    
   else if (allSpecies.get(i).getLevel()==5) stroke(190,186,218);
   else if (allSpecies.get(i).getLevel()==6) stroke(255,255,179);
   else fill(141,211,199);
   //if (allSpecies.get(i).getLevel()==2){
     for(int j = 0; j < speciesNum; j++){
       float ijRelation = allSpecies.get(i).getRelations().get(j);
       // draw links if two speceis have relations
       if(ijRelation==4||ijRelation==4.1||ijRelation==4.2||ijRelation==5) {
           strokeWeight(0.75);
           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(i).getZCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor(), allSpecies.get(j).getZCor());
       }
     }
   }
 
}
