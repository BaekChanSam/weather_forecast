class WeatherModel {
  final double temp;
  final String description;
  final double windSpeed;
  final int humidity;
  final String cityName;

  WeatherModel({
    required this.temp,
    required this.description,
    required this.windSpeed,
    required this.humidity,
    required this.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'].toInt(),
      cityName: json['name'],
    );
  }
}
