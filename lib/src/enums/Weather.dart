enum Weather {
  Clear, LightCloud, Overcast, LightRain, HeavyRain, Storm
}

Weather parseWeather(int value) {
  switch(value) {
    case 0: return Weather.Clear;
    case 1: return Weather.LightCloud;
    case 2: return Weather.Overcast;
    case 3: return Weather.LightRain;
    case 4: return Weather.HeavyRain;
    case 5: return Weather.Storm;
    default:
      throw new Exception('Unknown Weather: ${value}');
  }
}