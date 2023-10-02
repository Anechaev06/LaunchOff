class UserEntity {
  final String id;
  final String email;
  final String name;
  final String userName;

  UserEntity(
      {required this.id,
      required this.email,
      this.name = '',
      required this.userName});
}
