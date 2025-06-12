import 'package:common/common.dart';
import 'package:common/widgets/custom_alert_dialog.dart';
import 'package:common/widgets/rich_text_widget.dart';
import 'package:fiacto/2FA/view/view.dart';
import 'package:fiacto/accountVerification/view/login_phone.dart';
import 'package:fiacto/accountVerification/view/login_authenticator.dart';
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:fiacto/login/cubit/login_cubit.dart';
import 'package:fiacto/login/cubit/login_state.dart';
import 'package:fiacto/login/repository/login_repository.dart';
import 'package:fiacto/signup/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_page.dart';
part 'login_view.dart';
