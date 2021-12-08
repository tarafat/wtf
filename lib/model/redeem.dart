class Redeem {
  int id;
  String code;
  bool earned;
  Redeem(this.id, this.code, this.earned);

  Map<String, dynamic> toMapFromDb() {
    var map = <String, dynamic>{
      "id": id,
      "code": code,
      "earned": earned ? 1 : 0,
    };
    return map;
  }

  Redeem.fromMapToDb(Map<String, dynamic> map)
      : id = map["id"],
        code = map["code"],
        earned = map["earned"] == 1;
}
