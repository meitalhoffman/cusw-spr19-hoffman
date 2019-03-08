Table CountyBoundary, CensusData,CensusBlocks;

ArrayList<Float> all_scores = new ArrayList<Float>();
Float min;
Float max;

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
    all_scores.add(score*100);
  }
  //println(all_scores);
    //find the min and max of the scores and scale the score accordingly
    max = all_scores.get(2);
    min = all_scores.get(2);
    for(Float s : all_scores){
      if (max < s) {
        max = s;
      }
      if (min > s) {
        min = s;
      }
    }
  for(int i = 0; i<CensusPolygons.size(); i++){
    CensusPolygons.get(i).score = normalizeScore(max, min, all_scores.get(i)); //this is ONLY if the IDs are accurate
    CensusPolygons.get(i).colorByScore();
    CensusPolygons.get(i).makeShape();
  }
  

  //Test case for point in Polygon
  //println(county.pointInPolygon(new PVector(27.25, -80.85)));
  println("Data Parsed");
}
Float normalizeScore(Float max, Float min, Float val){
  Float range01 = (val - min)/(max-min);
  return range01*255;
}

float correlationTest(){
    int n = CensusPolygons.size();
    println(n);
    float[] mixedPerc = new float[n];
    float[] whitePerc = new float[n];
    for(int i = 0; i< n ; i++){
      float totalPop = CensusData.getFloat(i, "DP0080001");
      float whitePop = CensusData.getFloat(i, "DP0080003");
      float mixedPop = CensusData.getFloat(i, "DP0080020");
      
      if(totalPop != 0){
        mixedPerc[i] = ((mixedPop/totalPop)*100);
        whitePerc[i] = ((whitePop/totalPop)*100);
      } else {
        mixedPerc[i] = 0;
        whitePerc[i] = 0;
      }
    }
    
    float[] sortedMixed = sort(mixedPerc);
    float[] sortedWhite = sort(whitePerc);
    
    for(int i = 0; i < n; i++){
      for (int rank = 0; rank < n; rank++){
        if(mixedPerc[i] == sortedMixed[rank]){
          mixedPerc[i] = rank;
          sortedMixed[rank] = -1;
        } if(whitePerc[i] == sortedWhite[rank]){
          whitePerc[i] = rank;
          sortedWhite[rank] = -1;
        }
      }
    }

    float sumDiffSquared = 0;
    for(int i = 2; i< n ; i++){
      float diff = mixedPerc[i] - whitePerc[i];
      sumDiffSquared += sq(diff);
    }
    return (1 - (6*sumDiffSquared)/(n*(sq(n)-1)));
}
