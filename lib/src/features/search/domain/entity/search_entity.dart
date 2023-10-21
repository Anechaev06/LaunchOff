import '../../../auth/auth.dart';
import '../../../project/project.dart';

class SearchEntity {
  final UserEntity? user;
  final ProjectEntity? project;

  SearchEntity({this.user, this.project});
}
