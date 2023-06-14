import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.userId = '',
    this.email = '',
    this.fullName = '',
    this.pinTransaction = '',
    this.imageProfile = '',
    this.dateOfBirth = '',
    this.balance = 0,
    this.favoriteGenres = const [],
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        userId: id,
        email: json['email'],
        fullName: json['full_name'],
        pinTransaction: json['pin_transaction'],
        imageProfile: json['image_profile'],
        dateOfBirth: json['date_of_birth'],
        balance: json['balance'],
        favoriteGenres: json['favorite_genres'],
      );

  final String userId;
  final String email;
  final String fullName;
  final String pinTransaction;
  final String imageProfile;
  final String dateOfBirth;
  final int balance;
  final List favoriteGenres;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'email': email,
        'full_name': fullName,
        'pin_transaction': pinTransaction,
        'image_profile': imageProfile,
        'date_of_birth': dateOfBirth,
        'balance': balance,
        'favorite_genres': favoriteGenres,
      };

  @override
  List<Object?> get props => [
        userId,
        email,
        fullName,
        pinTransaction,
        imageProfile,
        dateOfBirth,
        balance,
        favoriteGenres,
      ];
}
