class CityWeatherModel {
  String cityId;
  String cityName;
  String condition;
  double _temperature;
  double _tempMin;
  double _tempMax;

  CityWeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    this.cityId = parsedJson['id'].toString();
    this.cityName = parsedJson['name'];
    this.condition = parsedJson['weather'][0]['main'];
    this._temperature = parsedJson['main']['temp'];
    this._tempMin = parsedJson['main']['temp_min'];
    this._tempMax = parsedJson['main']['temp_max'];
  }

  String getTemperature(bool useMetric) =>
    useMetric ? toCelsius(this._temperature).toStringAsPrecision(2) + " C" : toFahrenheit(this._temperature).toStringAsPrecision(2) + " F";

  String getMaxTemperature(bool useMetric) =>
      useMetric ? toCelsius(this._tempMax).toStringAsPrecision(2) + " C" : toFahrenheit(this._tempMax).toStringAsPrecision(2) + " F";

  String getMinTemperature(bool useMetric) =>
      useMetric ? toCelsius(this._tempMin).toStringAsPrecision(2) + " C" : toFahrenheit(this._tempMin).toStringAsPrecision(2) + " F";

  double toCelsius(double kelvinTemp) => kelvinTemp - 273.15;

  double toFahrenheit(double kelvinTemp) => kelvinTemp * 9 / 5 - 459.67;
}
