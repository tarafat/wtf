class Coupon {
  int id;
  int amount;
  bool earned;
  Coupon(this.id, this.amount, this.earned);

  Map<String, dynamic> toMapFromDb() {
    var map = <String, dynamic>{
      "id": id,
      "amount": amount,
      "earned": earned ? 1 : 0,
    };
    return map;
  }

  Coupon.fromMapToDb(Map<String, dynamic> map)
      : id = map["id"],
        amount = map["amount"],
        earned = map["earned"] == 1;
}
