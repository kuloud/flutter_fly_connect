import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly_connect/generated/l10n.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with WidgetsBindingObserver {
  List<AppInfo>? _installedApps;

  List<String> androidPackageNames = ["com.kuloud.android.flit"];
  List<String> iOSSchemas = ["flove://"];

  @override
  void initState() {
    super.initState();
    queryFlyAppSet();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      queryFlyAppSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).appName)),
      body: (_installedApps?.isNotEmpty ?? false)
          ? ListView.builder(
              itemCount: _installedApps?.length,
              itemBuilder: (context, index) {
                final app = _installedApps![index];

                return ListTile(
                  title: Text(app.appName ?? app.packageName),
                  subtitle: Text(
                    app.versionName ?? '',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      AppCheck.launchApp(app.packageName).then((_) {
                        debugPrint(
                          "${app.appName ?? app.packageName} launched!",
                        );
                      }).catchError((err) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "${app.appName ?? app.packageName} not found!",
                          ),
                        ));
                        debugPrint(err.toString());
                      });
                    },
                  ),
                );
              },
            )
          : const Center(child: Text('No installed apps found!')),
    );
  }

  Future<void> queryFlyAppSet() async {
    List<AppInfo>? installedApps;

    final packages = Platform.isAndroid ? androidPackageNames : iOSSchemas;

    final apps = await Future.wait(
        packages.map((package) => AppCheck.checkAvailability(package)));

    installedApps = apps.where((app) => (app != null)).cast<AppInfo>().toList();

    if (mounted) {
      setState(() {
        _installedApps = installedApps;
      });
    }
  }
}
