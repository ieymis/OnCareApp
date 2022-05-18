class User{
  final int age,weight;
  final String record_id,id, username,email,password,gender,phone_number, body_temperature,blood_pressure,hart_rate,respiratory_rate ;

  User(this.record_id, this.id, this.username,this.email,this.password,this.age,this.gender,this.weight,this.phone_number, this.body_temperature, this.blood_pressure, this.hart_rate, this.respiratory_rate);

  static User fromJson(json) => User(
      json['id'].toString(),
      json['user_id'].toString(),
      json['username'],
      json['email'],
      json['password'],
      json['age'],
      json['gender'],
      json['weight'],
      json['phone_number'].toString(),
      json['body_temperature'].toString(),
      json['bload_perssure'].toString(),
      json['hart_rate'].toString(),
      json['respiratory_rate'].toString(),
  );

}