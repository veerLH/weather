
class Helper {
  static String mapStringToImage(String input){
    var name = "";
    switch(input){
      case "sn":name = "wea4";
      break;
      case "lr" : name ="wea3";
      break;
      case  "hr" : name ="wea3";
      break;
      case "lc" : name = "wea2";
      break;
      case "c" : name ="wea1";
      break;
      case "hc" : name ="wea4";
      break;
      default:
        name = "wea1";
    }
    return name;
  }

}