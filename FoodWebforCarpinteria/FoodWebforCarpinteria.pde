//import java.util.*;
//import java.lang.*;

//// --------------------- Sketch-wide variables ----------------------
//Table table;
//String[] allSpeciesName = new String[128];
//int speciesNum;
//ArrayList<Species> allSpecies = new ArrayList<Species>();
//float bigCircleDia = 600;
//float interval;
//PShape bigCircle;
//PImage img;
//String description;
//boolean predPray = true, paraHost = true, predHost = true, paraPara = true;
//// ------------------------ Initialisation --------------------------

//// Initialises the data and bar chart.

//// ------------------------ Initialisation --------------------------

//// Initialises the data and bar chart.


//void setup(){
//  size(1350, 720);
//  smooth(); 
//  // ELLIPSE x, y, width, height
//  bigCircle = createShape(ELLIPSE,640,360,bigCircleDia,bigCircleDia);  
//  // Load the data table.
//  table = loadTable("carpinteria.csv");
//  // The first row of the table saves all the name of species in the food web.
//  // Extract them all and save them in a String array.
//  TableRow row0 = table.getRow(0);
//  for (int i = 2;i < row0.getColumnCount();i++){
//    allSpeciesName[i-2] = row0.getString(i);
//  }
//  // The first two columns are not species name
//  // Initialize save all species information into an arraylist
//  for (int i = 3; i < table.getRowCount(); i++){
//    allSpecies.add(new Species(table.getRow(i), bigCircleDia, i-3));
//    } 
//  speciesNum = allSpecies.size();
  
//}

//void mousePressed(){
//  if (mouseX <= 125 && mouseX >= 100 && mouseY <= 125 && mouseY >= 100) {
//    if (predPray == false) predPray = true;
//    else predPray = false;
//  }
//  if (mouseX <= 125 && mouseX >= 100 && mouseY <= 165 && mouseY >= 140) {
//    if (paraHost == false) paraHost = true;
//    else paraHost = false;
//  }
//  if (mouseX <= 125 && mouseX >= 100 && mouseY <= 205 && mouseY >= 180) {
//    if (predHost == false) predHost = true;
//    else predHost = false;
//  }
//  if (mouseX <= 125 && mouseX >= 100 && mouseY <= 245 && mouseY >= 220) {
//    if (paraPara == false) paraPara = true;
//    else paraPara = false;
//  }
//}


//void draw()
//{
// background(255); 
// shape(bigCircle,0,0);
// stroke(0);
// textSize(20);
// fill(0);
// text("Subwebs (click to select)", 100, 80);
 
// if (predPray) fill(152,78,163);
// else noFill();
// rect(100, 100, 25, 25);
// fill(152,78,163);
// text("pedator-prey", 140, 120); 
 
// if (paraHost) fill(247,129,191);
// else noFill();
// rect(100, 140, 25, 25);
// fill(247,129,191);
// text("parasite-host", 140, 160);
 
// if (predHost) fill(78,179,211);
// else noFill();
// rect(100, 180, 25, 25);
// fill(78,179,211);
// text("predator-parasite", 140, 200);
 
// if (paraPara) fill(153,153,153);
// else noFill();
// rect(100, 220, 25, 25);
// fill(153,153,153);
// text("parasite-parasite", 140, 240);
 
// fill(255,255,51); rect(990, 90, 10, 10);
// fill(255,127,0); rect(990, 110, 10, 10);
// fill(228,26,28); rect(990, 130, 10, 10);
// fill(152,78,163); rect(990, 150, 10, 10);
// fill(247,129,191); rect(990, 180, 10, 10);
// fill(102,166,30); rect(990, 212, 10, 10);
// fill(78,179,211); rect(990, 242, 10, 10);
// fill(153,153,153); rect(990, 272, 10, 10);
 
// textSize(16);
// fill(0);
// text("Types of links", 990, 75);
// textSize(12);
// text("first intermediate host", 1010, 100);
// text("first and second intermediate host", 1010, 120);
// text("second intermediate host", 1010, 140);
// text("final intermediate host", 1010, 160);
// text("predator-prey and egg predator", 1010, 190);
// text("predation on free-living cercarial stage of", 1010, 220);
// text("a trematode and micropredation (mosquito)", 1010, 230);
// text("predation on parasite in a host", 1010, 250); 
// text("parasite-parasite (mostly intraguild predation)", 1010, 280);
 
// fill(102,194,165); circle(995, 375, 15);
// fill(1252,141,98); circle(995, 405, 15);
// fill(141,160,203); circle(995, 435, 15);
 
// fill(0);
// textSize(18);
// text("Types of species", 990, 350);
// textSize(16);
// text("Basal", 1015, 380);
// text("Freeliving", 1015, 410);
// text("Parasite", 1015, 440);
 
// textSize(12);
// text("Citation: ", 970, 500);
// text("CLafferty, K. D., R. F. Hechinger, J. C. Shaw, K. L. Whitney ", 970, 520);
// text("and A. M. Kuris (in press) ", 970, 535);
// text("Food webs and parasites in a salt marsh ecosystem. ", 970, 555);
// text("In Disease ecology: community structure and pathogen", 970, 575);
// text("dynamics (eds S. Collinge and C. Ray). ", 970, 590);
// text("Oxford University Press, Oxford.", 970, 605);
 
// noFill();
// rect(960, 480, 350, 140);
// rect(80, 300, 220, 350);
 
// textSize(18);
// text("Killdeer", 90, 325);
// img = loadImage("image/41.jpg");
// image(img, 95, 330, 180, 120);
// textSize(15);
// description = "Charadrius vociferus (Killdeer) is a species of bird in the family Charadriidae. It is found in the Neotropics and the Nearctic. It is a carnivore.";
// text(description, 90, 465, 200, 650);
 
// for(int i = 0; i < speciesNum; i++){
//   shape(allSpecies.get(i).getShape(),0,0);
// }
// for(int i = 0; i < speciesNum; i ++){
//   for(int j = 0; j < speciesNum; j++){
//     float ijRelation = allSpecies.get(i).getRelations().get(j);
//     // draw links if two speceis have relations
//     if(ijRelation!=0) {
//       if (predPray){
//         if(ijRelation==1) {
//           strokeWeight(0.5);
//           stroke(255,255,51);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         }
//         if(ijRelation==1.2||ijRelation==1.25) {
//           strokeWeight(0.5);
//           stroke(255,127,0);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         }
//         if(ijRelation==2||ijRelation==2.5) {
//           strokeWeight(0.5);
//           stroke(228,26,28);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         }
//         if(ijRelation==3) {
//           strokeWeight(0.5);
//           stroke(152,78,163);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());          }
//       }
//       if(paraHost){
//         if(ijRelation==4||ijRelation==4.1||ijRelation==4.11||ijRelation==4.2) {
//           strokeWeight(0.45);
//           stroke(247,129,191);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         }
//       }
//       if (predHost){
//         if(ijRelation==5||ijRelation==6) {
//           strokeWeight(0.5);
//           stroke(102,166,30);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         } 
//         if(ijRelation==7||ijRelation==8) {
//           strokeWeight(0.25);
//           stroke(78,179,211);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         } 
//       }
//       if (paraPara){
//         if(ijRelation==9) {
//           strokeWeight(0.5);
//           stroke(153,153,153);
//           line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
//         } 
//       }
//     }
//   }
// }
//}
