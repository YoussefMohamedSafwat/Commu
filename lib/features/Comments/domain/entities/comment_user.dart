import 'package:cleanarch/features/user/domain/entities/user.dart';

abstract class  CommentUser extends User {
  CommentUser({required super.id, required super.username, required super.email});


}
