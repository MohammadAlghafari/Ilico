import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/base_error.dart';

part 'live_template_state.dart';

class LiveTemplateCubit extends Cubit<LiveTemplateState> {
  LiveTemplateCubit() : super(LiveTemplateInitial());
}
