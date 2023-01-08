import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/constants.dart';
import 'package:hulajuan/src/settings/settings.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

const _maxAllowedSeconds = 300;

class DurationTile extends StatefulWidget {
  const DurationTile({
    Key? key,
    required this.onEditingCompleted,
    required this.initialValue,
  }) : super(key: key);

  final void Function(int) onEditingCompleted;
  final String initialValue;

  @override
  State<DurationTile> createState() => _DurationTileState();
}

class _DurationTileState extends State<DurationTile> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final duration = context.read<SettingsCubit>().state.durationInSeconds;
    controller.text = duration.toString();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Duration'),
      subtitle: const Text('(in seconds, maximum of 300)'),
      trailing: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth * 0.2,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                final seconds = int.parse(controller.text.trim());
                if (seconds > _maxAllowedSeconds) {
                  widget.onEditingCompleted.call(_maxAllowedSeconds);
                  showCustomSnackbar(
                    context,
                    key: kGlobalScaffoldMessengerKey,
                    message:
                        'The maximum time allowed is 5 minutes (300 seconds)',
                    snackBarType: SnackBarType.error,
                  );
                  Focus.of(context).unfocus();
                  return;
                }
                Focus.of(context).unfocus();
                widget.onEditingCompleted.call(seconds);
              },
            ),
          );
        },
      ),
    );
  }
}
