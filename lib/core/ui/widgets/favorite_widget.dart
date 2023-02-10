import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

import '../../../features/profile/data/use_case/toogel_favorite_usecase.dart';
import '../../constants/app_icons.dart';
import '../dialogs/dialogs.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget(
      {Key? key, required this.isFavorite, required this.onChange, required this.id, required this.type})
      : super(key: key);

  final ValueChanged<bool> onChange;
  final bool isFavorite;
  final String id;
  final String type;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return CreateModel(
      withValidation: false,
      useCaseCallBack: (model) {
        if (CashHelper.authorized) {
          return ToggleFavoriteUseCase(ProfileRepository()).call(
            params: ToggleFavoriteParams(profileId: widget.id, type: widget.type),
          );
        } else {
          Dialogs.showErrorSnackBar(message: 'Pleas log in'.tr(), typeSnackBar: AnimatedSnackBarType.warning);
        }
      },
      onSuccess: (success) {
        widget.onChange(true);
      },
      child: SvgPicture.asset(
        widget.isFavorite ? selectedFavoriteSvg : favoriteSvg,
        // color: widget.isFavorite ? Colors.red : null,
      ),
    );
  }
}
