class UserModel {

  String? uId;
  String userName;
  String name;
  String weight;
  String height;


  UserModel(this.uId, this.userName, this.name, this.weight, this.height);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'uId': uId,
      'weight': weight,
      'height': height
    };
  }
}