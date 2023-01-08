import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final data = snapshot.data;
          final version = data?.version;
          final build = data?.buildNumber;

          return ListTile(
            title: Text('Version: $version'),
            subtitle: Text('Build: $build'),
          );
        });
  }
}
