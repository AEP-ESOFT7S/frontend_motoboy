import 'dart:convert';

class UserRequest {
  final String phone;
  final String cep;
  final String city;
  final String neighborhood;
  final String address;
  final String number;
  final String complement;
  final String email;
  final String password;
  final String type;
  //MOTOBOY
  String? firstName;
  String? lastName;
  String? cpf;
  String? bank;
  String? agency;
  String? account;
  String? meansOfDelivery;

  UserRequest({
    required this.phone,
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
    required this.email,
    required this.password,
    required this.type,
    this.firstName,
    this.lastName,
    this.cpf,
    this.bank,
    this.agency,
    this.account,
    this.meansOfDelivery,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'cep': cep,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'email': email,
      'password': password,
      'type': type,
      'firstName': firstName,
      'lastName': lastName,
      'cpf': cpf,
      'bank': bank,
      'agency': agency,
      'account': account,
      'meansOfDelivery': meansOfDelivery,
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      phone: map['phone'] ?? '',
      cep: map['cep'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      address: map['address'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      firstName: map['firstName'],
      lastName: map['lastName'],
      cpf: map['cpf'],
      bank: map['bank'],
      agency: map['agency'],
      account: map['account'],
      meansOfDelivery: map['meansOfDelivery'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) => UserRequest.fromMap(json.decode(source));
}
