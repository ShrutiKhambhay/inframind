// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.bodyTemperature,
        this.bloodPressure,
        this.respiration,
        this.glucose,
        this.heartRate,
        this.cholestrol,
        this.oxygensaturation,
    });

    double bodyTemperature;
    int bloodPressure;
    int respiration;
    int glucose;
    int heartRate;
    int cholestrol;
    int oxygensaturation;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        bodyTemperature: json["bodyTemperature"].toDouble(),
        bloodPressure: json["bloodPressure"],
        respiration: json["respiration"],
        glucose: json["glucose"],
        heartRate: json["heartRate"],
        cholestrol: json["cholestrol"],
        oxygensaturation: json["oxygensaturation"],
    );

    Map<String, dynamic> toJson() => {
        "bodyTemperature": bodyTemperature,
        "bloodPressure": bloodPressure,
        "respiration": respiration,
        "glucose": glucose,
        "heartRate": heartRate,
        "cholestrol": cholestrol,
        "oxygensaturation": oxygensaturation,
    };
}
