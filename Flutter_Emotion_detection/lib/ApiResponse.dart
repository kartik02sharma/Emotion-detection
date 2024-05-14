// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

List<ApiResponse> apiResponseFromJson(String str) => List<ApiResponse>.from(json.decode(str).map((x) => ApiResponse.fromJson(x)));

String apiResponseToJson(List<ApiResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiResponse {
  double? probability;
  Rectangle? rectangle;
  Emotion? emotion;

  ApiResponse({
    this.probability,
    this.rectangle,
    this.emotion,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    probability: json["probability"]?.toDouble(),
    rectangle: json["rectangle"] == null ? null : Rectangle.fromJson(json["rectangle"]),
    emotion: json["emotion"] == null ? null : Emotion.fromJson(json["emotion"]),
  );

  Map<String, dynamic> toJson() => {
    "probability": probability,
    "rectangle": rectangle?.toJson(),
    "emotion": emotion?.toJson(),
  };
}

class Emotion {
  String? value;
  double? probability;
  Sentiments? sentiments;

  Emotion({
    this.value,
    this.probability,
    this.sentiments,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
    value: json["value"],
    probability: json["probability"]?.toDouble(),
    sentiments: json["sentiments"] == null ? null : Sentiments.fromJson(json["sentiments"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "probability": probability,
    "sentiments": sentiments?.toJson(),
  };
}

class Sentiments {
  double? angry;
  double? disgust;
  double? fear;
  double? happy;
  double? sad;
  double? surprise;
  double? neutral;

  Sentiments({
    this.angry,
    this.disgust,
    this.fear,
    this.happy,
    this.sad,
    this.surprise,
    this.neutral,
  });

  factory Sentiments.fromJson(Map<String, dynamic> json) => Sentiments(
    angry: json["angry"]?.toDouble(),
    disgust: json["disgust"]?.toDouble(),
    fear: json["fear"]?.toDouble(),
    happy: json["happy"]?.toDouble(),
    sad: json["sad"]?.toDouble(),
    surprise: json["surprise"]?.toDouble(),
    neutral: json["neutral"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "angry": angry,
    "disgust": disgust,
    "fear": fear,
    "happy": happy,
    "sad": sad,
    "surprise": surprise,
    "neutral": neutral,
  };
}

class Rectangle {
  double? left;
  double? top;
  double? right;
  double? bottom;

  Rectangle({
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  factory Rectangle.fromJson(Map<String, dynamic> json) => Rectangle(
    left: json["left"]?.toDouble(),
    top: json["top"]?.toDouble(),
    right: json["right"]?.toDouble(),
    bottom: json["bottom"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "left": left,
    "top": top,
    "right": right,
    "bottom": bottom,
  };
}
