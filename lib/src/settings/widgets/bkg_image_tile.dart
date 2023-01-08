import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/settings/cubit/settings_cubit.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

class BkgImageTile extends StatelessWidget {
  const BkgImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = context.select(
      (SettingsCubit c) => c.state.bkgPath,
    );

    return ListTile(
      onTap: () async {
        await showImagePicker(
          context,
          label: 'Background Color',
          initialSelectedImage: imagePath,
          onImageSelected: (String? value) {
            if (value != null && value != imagePath) {
              context.read<SettingsCubit>().onBkgPathChanged(value);
            }
          },
        );
      },
      title: const Text('Background Image'),
      trailing: Card(
        elevation: 5,
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxHeight * 2,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
