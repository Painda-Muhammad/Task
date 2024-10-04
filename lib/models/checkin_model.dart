
class CheckInModel {
   String? id;
   String? hospitalId;
   String? hospitalName;
   String? userId;
   DateTime? timestamp;
  bool synced;

  CheckInModel({
     this.id,
     this.hospitalId,
     this.hospitalName,
     this.userId,
     this.timestamp,
    this.synced = false,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) {
    return CheckInModel(
      id: json['id'],
      hospitalId: json['hospitalId'],
      hospitalName: json['hospitalName'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
      synced: json['synced'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'hospitalId': hospitalId,
        'hospitalName': hospitalName,
        'userId': userId,
        'timestamp': timestamp!.toIso8601String(),
        'synced': synced,
      };
}
