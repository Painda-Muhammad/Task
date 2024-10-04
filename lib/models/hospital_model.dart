class HospitalModel {
    HospitalModel({
        required this.id,
        required this.hospitalName,
        required this.openTime,
        required this.closeTime,
        required this.description,
        required this.imageUrl,
        required this.isCheckin,
        required this.location,
    });

    final int? id;
    final String? hospitalName;
    final String? openTime;
    final String? closeTime;
    final String? description;
    final String? imageUrl;
    final bool? isCheckin;
    final String? location;

    factory HospitalModel.fromJson(Map<String, dynamic> json){ 
        return HospitalModel(
            id: json["id"],
            hospitalName: json["hospitalName"],
            openTime: json["openTime"],
            closeTime: json["closeTime"],
            description: json["description"],
            imageUrl: json["imageUrl"],
            isCheckin: json["isCheckin"],
            location: json["location"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalName": hospitalName,
        "openTime": openTime,
        "closeTime": closeTime,
        "description": description,
        "imageUrl": imageUrl,
        "isCheckin": isCheckin,
        "location": location,
    };

}
