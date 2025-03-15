import 'package:get_it/get_it.dart';

import '../../features/signin/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<SigninCubit>(() => SigninCubit());
}
