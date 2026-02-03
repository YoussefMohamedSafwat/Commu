import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/Comments/data/datasources/remote_comment_datasource.dart';
import 'package:cleanarch/features/Comments/data/repositories/comment_repository_impl.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:cleanarch/features/Comments/domain/usecases/add_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/delete_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/get_comment_by_postid_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/update_comment_usecase.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';

void initComments() {
  //blocs
  dc.registerFactory(
    () => CommentBloc(
      getCommentByPostidUsecase: dc(),
      addcommentUsecase: dc(),
      deleteCommentUsecase: dc(),
      updateCommentUsecase: dc(),
    ),
  );

  //usecase

  dc.registerLazySingleton(
    () => GetCommentByPostidUsecase(commentRepository: dc()),
  );
  dc.registerLazySingleton(() => AddCommentUsecase(repository: dc()));
  dc.registerLazySingleton(() => DeleteCommentUsecase(commentRepository: dc()));
  dc.registerLazySingleton(() => UpdateCommentUsecase(commentRepository: dc()));

  //repositories
  dc.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: dc(), networkInfo: dc()),
  );

  //datasources
  dc.registerLazySingleton<RemoteCommentDatasource>(
    () => RemoteCommentDatasourceImpl(client: dc()),
  );
}
