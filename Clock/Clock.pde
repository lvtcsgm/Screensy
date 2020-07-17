PFont font;
int hour, minute, second;
float x, y, extent;
float r, g, b;
String test;
Float temp;
PImage img;
String imgURL;
String fTime;
String fHour;
String fMinute;
String fSecond;


void setup()
{
  size(800, 600);
  background(0);
  font = createFont("Monaco", 40, false);
  thread("getWeather");
  
  
}

void draw()
{
  textFont(font, 40);
  textSize(120);
  fill(255);
  hour = hour();
  minute = minute();
  second = second();
  
 //if (frameCount % 6 == 0)
 //{
 //  createBackgroundColor();
 //  generateSquares();
 //  displayHour();
 //  displayWeather();
 //} 
 
 createBackgroundColor();
   generateSquares();
   displayHour();
   displayWeather();
 
}

void generateSquares()
{
  noFill();
  strokeWeight(2);
  for (int i = 0; i <= 10; i++)
   {
     r = random(0, 255);
     g = random(0, 255);
     b = random(0, 255);
     x = random(0, 800);
     y = random(0, 600);
     extent = random(10, 40);
     stroke(r, g, b);
     square(x, y, extent);
   }
}

void displayHour()
{
  
   fHour = "" + hour;
   fMinute = ":" + minute;
   fSecond = ":" + second;
  
   if (hour < 10) 
   {
    fHour = "0" + hour;
   } 
   
   if (minute < 10)
   {
     fMinute = "0" + minute;
   }
   
   if (second < 10)
   {
     fSecond = ":0" + second;
   }
   
   fTime = fHour + fMinute + fSecond;
   
   text(fTime, (width / 2) - 290, (height / 2) + 20);
}

void displayWeather()
{
    if (temp != null && imgURL != null)
   {
     textSize(30);
     temp = (float)floor(temp);
     text(temp + "F°", (width / 2) - 50, (height / 2) + 130);
     img = loadImage(imgURL);
     image(img, 250, 370);
   } 
   else 
   {
     textSize(30);
     text("Loading...", (width / 2) - 70, (height / 2) + 130);
   }
   
}

void getWeather() 
{
  
  String apiKey = "334d173929684fc2e02a7bcf714dee2f";
  String cityId = "5506956";
  String url = "https://api.openweathermap.org/data/2.5/weather?id=" + cityId + "&units=imperial&appid=" + apiKey;
  
  
  JSONObject json = loadJSONObject(url);  
  temp = json.getJSONObject("main").getFloat("temp");
  
  JSONArray weatherArray = json.getJSONArray("weather");
  JSONObject weatherObject = weatherArray.getJSONObject(0);
  
  imgURL = weatherObject.getString("icon");
  imgURL = "http://openweathermap.org/img/wn/" + imgURL + "@2x.png";
  
}

void createBackgroundColor()
{
  
  if (hour < 4 || hour > 21)
  {
    background(#1b262c); // dark black
  }
  else if (hour > 4 && hour < 6)
  {
    background(#0f4c75);
  }
  else if (hour > 6 && hour < 17)
  {
    background(#bbe1fa);
  }
  
  
}
