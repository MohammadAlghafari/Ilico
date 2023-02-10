part of 'add_service_cubit.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class AddServiceLoaded extends AddServiceState {
  final AddService data;

  AddServiceLoaded({required this.data});
}

class AddServiceError extends AddServiceState {
  AddServiceError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class AddEventLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class AddEventLoaded extends AddServiceState {
  final dynamic data;

  AddEventLoaded({required this.data});
}

class AddEventError extends AddServiceState {
  AddEventError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class DeleteEventLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class DeleteEventLoaded extends AddServiceState {
  DeleteEventLoaded();
}

class DeleteEventError extends AddServiceState {
  DeleteEventError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class DeleteServiceOrProductLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class DeleteServiceOrProductLoaded extends AddServiceState {
  DeleteServiceOrProductLoaded();
}

class DeleteServiceOrProductError extends AddServiceState {
  DeleteServiceOrProductError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class AddMediaLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class AddMediaLoaded extends AddServiceState {
  final dynamic data;

  AddMediaLoaded({required this.data});
}

class AddMediaError extends AddServiceState {
  AddMediaError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

//////article////
class CreateArticleLoading extends AddServiceState {}

class CreateArticleLoaded extends AddServiceState {
  final CreateArticle data;
  CreateArticleLoaded({required this.data});
}

class CreateArticleError extends AddServiceState {
  CreateArticleError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class DeleteArticleLoading extends AddServiceState {}

class DeleteArticleLoaded extends AddServiceState {
  final GetMyArticles data;
  DeleteArticleLoaded({required this.data});
}

class DeleteArticleError extends AddServiceState {
  DeleteArticleError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
