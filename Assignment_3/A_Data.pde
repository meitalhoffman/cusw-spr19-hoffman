Table CountyBoundary, CensusData,CensusBlocks;

void loadData(){
  //CountyBoundary = loadTable("data/FloridaNodes.csv", "header");
  CensusBlocks = loadTable("data/chicago-nodes.csv", "header");
  CensusData = loadTable("data/chicago-attributes.csv", "header");
  println("Data Loaded");
}

void parseData(){
  //First parse county polygon
    //ArrayList<PVector> coords = new ArrayList<PVector>();
   // for(int i = 0; i<CountyBoundary.getRowCount(); i++){
   //      float lat = float(CountyBoundary.getString(i, 2));
   //      float lon = float(CountyBoundary.getString(i, 1));
   //      coords.add(new PVector(lat, lon));
   // }
   //county = new Polygon(coords);
   //county.outline = true;
   //county.makeShape();  

//Now we can parse the population polygons
  int previd = 0;
  ArrayList<PVector> coords = new ArrayList<PVector>();
  for(int i = 0; i<CensusBlocks.getRowCount(); i+=2){
    println(CensusBlocks.getString(1, 0));
    int shapeid = int(CensusBlocks.getString(i, 0));
       if(shapeid != previd){
           if(coords.size() > 0){
               Polygon poly = new Polygon(coords);
               poly.id = shapeid;
               CensusPolygons.add(poly);
           }
           //clear coords
           coords = new ArrayList<PVector>();
           //reset variable
           previd = shapeid;
       }
       if(shapeid == previd){
         float lat = float(CensusBlocks.getString(i, 2));
         float lon = float(CensusBlocks.getString(i, 1));
         //println(lat, lon);
         coords.add(new PVector(lat, lon));
       }
  }
  
  //clean the attribute data so it doesn't have empty rows
  for(int i = 1; i<CensusData.getRowCount(); i++){
    if(CensusData.getInt(i, 0) == 0){
     CensusData.removeRow(i);
    }
  }
  //Add attribute you want to your polygon (you can add more attributes if you want and look at the Tiger page for more info) 
  //Total household income
  for(int i = 0; i<CensusPolygons.size(); i++){
    float totalPop = CensusData.getFloat(i, "DP0080001");
    float mixedPop = CensusData.getFloat(i, "DP0080020");
    //println(str(totalPop));
    //println(str(mixedPop));
    float score = mixedPop/totalPop;
    if(totalPop == 0){
      score = 0;
    }
    println(score);
    CensusPolygons.get(i).score = score*4800; //this is ONLY if the IDs are accurate
    //print(score);
    CensusPolygons.get(i).colorByScore();
    CensusPolygons.get(i).makeShape();
  }
  

  //Test case for point in Polygon
  //println(county.pointInPolygon(new PVector(27.25, -80.85)));
  
  println("Data Parsed");
}
