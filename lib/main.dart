import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hulajuan/bootstrap.dart';
import 'package:hulajuan_core/hulajuan_core.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = _AppBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await bootstrap();
}

class _AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    'onChange: Previous => ${change.currentState} New => ${change.nextState}'
        .log();
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    'onEvent: $event'.log();
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    'onClose: ${bloc.state}'.log();
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    'onCreate: ${bloc.state}'.log();
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    'Error: $bloc, error: $error, st: $stackTrace'.log();
    super.onError(bloc, error, stackTrace);
  }
}
