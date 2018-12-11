/// An enum representing the weather conditions in a SessionData packet
enum Weather {
  Clear, LightCloud, Overcast, LightRain, HeavyRain, Storm
}

/// Parse a weather value and convert it to a Weather enum value
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