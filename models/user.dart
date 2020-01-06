class User {

  int id;
  String name, email, phone, studentId, password, pin, date;

  User(this.name, this.email, this.phone, this.studentId, this.password, this.pin, this.date);

  User.withId(this.id, this.name, this.email, this.phone, this.studentId, this.password, this.pin, this.date);

  User.fromJson(Map json)
    : id        = json['id'],
      name      = json['name'],
      email     = json['email'],
			phone     = json['phone'],
      studentId = json['studentId'],
      password  = json['password'],
			pin       = json['pin'],
      date      = json['date'];

  Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		if (id != null) map['id'] = id;
    map['name']      = name;
    map['email']     = email;
		map['phone']     = phone;
		map['studentId'] = studentId;
    map['password']  = password;
		map['pin']       = pin;
    map['date']      = date;

		return map;
	}

  User.fromDb(Map map)
		: id        = map['id'],
      name      = map['name'],
      email     = map['email'],
			phone     = map['phone'],
      studentId = map['studentId'],
      password  = map['password'],
			pin       = map['pin'],
      date      = map['date'];
}
