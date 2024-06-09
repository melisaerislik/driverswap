class RandevuModel{
  String? guzergah;
  String? hatNo;
  DateTime? zaman;

  RandevuModel({
    required this.guzergah,
    required this.hatNo,
    required this.zaman


});
  Map<String, dynamic> toJson() {
    return {
      'guzergah' : guzergah,
      'hatNo': hatNo,
      'zaman': zaman,
    };
  }

}