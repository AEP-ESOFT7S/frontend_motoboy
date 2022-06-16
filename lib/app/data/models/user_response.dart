// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserResponse {
  final String id;
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
  final String firstName;
  final String lastName;
  final String cpf;
  final String bank;
  final String agency;
  final String account;
  final String meansOfDelivery;

  UserResponse({
    required this.id,
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
    required this.firstName,
    required this.lastName,
    required this.cpf,
    required this.bank,
    required this.agency,
    required this.account,
    required this.meansOfDelivery,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
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

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['_id'] ?? '',
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
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      cpf: map['cpf'] ?? '',
      bank: map['bank'] ?? '',
      agency: map['agency'] ?? '',
      account: map['account'] ?? '',
      meansOfDelivery: map['meansOfDelivery'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source));
}
