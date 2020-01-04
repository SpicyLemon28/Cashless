
class User {
  int studId, userId, pin, phone;
  String name, email, password, date;

  User (this.name, this.email, this.phone, this.studId, this.password, this.pin, this.date);

  User.withId (this.userId, this.name, this.email, this.phone, this.studId, this.password, this.pin, this.date);

  User.fromJson(Map json)
    : userId      = json['userId'],
      name        = json['name'],
      email       = json['email'],
			phone       = json['phone'],
      studId      = json['studentId'],
      password    = json['password'],
			pin         = json['pin'],
      date        = json['date'];
  
  Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		if (userId != null) map['userId'] = userId;
    map['name']       = name;
    map['email']      = email;
		map['phone']      = phone;
		map['studId']     = studId;
    map['password']   = password;
		map['pin']        = pin;
    map['date']       = date;

		return map;
	}

  User.fromDb(Map map)
		: userId      = map['userId'],
      name        = map['name'],
      email       = map['email'],
			phone       = map['phone'],
      studId      = map['studId'],
      password    = map['password'],
			pin         = map['pin'],
      date        = map['date'];   
}
