import 'package:book_app/core/errors/failuer.dart';
import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Book>>> getNewReleases();
}