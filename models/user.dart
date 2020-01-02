
class User {
  int studId, userId, pin, token, phone;
  String name, email, password, date;

  User (this.studId, this.userId, this.pin, this.token, this.phone,
        this.name, this.email, this.password, this.date);

  User.withId (this.studId, this.userId, this.pin, this.token, this.phone,
        this.name, this.email, this.password, this.date);

  User.fromJson(Map json)
    : userId      = json['userId'],
      studId      = json['studentId'],
			pin         = json['pin'],
			token       = json['token'],
			phone       = json['phone'],
      name        = json['name'],
      email       = json['email'],
      password    = json['password'],
      date        = json['date'];
  
  Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		if (userId != null) map['userId'] = userId;
		map['studId']     = studId;
		map['pin']        = pin;
		map['token']      = token;
		map['phone']      = phone;
    map['name']       = name;
    map['email']      = email;
    map['password']   = password;
    map['date']       = date;

		return map;
	}

  User.fromDb(Map map)
		: userId      = map['userId'],
      studId      = map['studId'],
			pin         = map['pin'],
			token       = map['token'],
			phone       = map['phone'],
      name        = map['name'],
      email       = map['email'],
      password    = map['password'],
      date        = map['date']; 
  
}
