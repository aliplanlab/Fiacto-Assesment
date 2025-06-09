import 'package:common/common.dart';
import 'package:fiacto/app/bloc/app_bloc.dart';
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:fiacto/auth/two_factor_sign_up/repository/two_factor_sign_repository.dart';
import 'package:fiacto/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

part 'app_providers.dart';
part 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocus(),
      child: AppCoreProviders(),
    );
  }
}
