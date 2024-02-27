import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  // setting and getting of Cityname
  setCity(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("city", value);

  }

  getCity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String city = pref.getString("city")??"ghaziabad";
    return city;
  }

  // getting and setting of temp
  setTempe(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Temperature", value);

  }

  getTempe() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String Temperature = pref.getString("Temperature")??"0";
    return Temperature;
  }
  // getting and setting of Condition
  setCondition(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Condition", value);

  }

  getCondition() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String Condition = pref.getString("Condition")??"Clear";
    return Condition;
  }
  // getting and setting of Humidity
  setHumidity(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Humidity", value);

  }

  getHumidity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String Humidity = pref.getString("Humidity")??"0";
    return Humidity;
  }

  //setting and getting of windspeed
  setWindSpeed(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("WindSpeed", value);

  }

  getWindSpeed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String WindSpeed = pref.getString("WindSpeed")??"0";
    return WindSpeed;
  }

}