import 'package:driver/models/enum/home_section_enum.dart';
import 'package:driver/views/home/map_view.dart';
import 'package:driver/views/home/settings.dart';
import 'package:driver/views/home/shift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  var mapview = MapView();
  var settings = Settings();
  var shift = Shift();
  Widget body = Container();

  @override
  void initState() {
    body = mapview;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.app_title),
        ),
        extendBodyBehindAppBar: body == mapview,
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(AppLocalizations.of(context)!.driver),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      title: Text(AppLocalizations.of(context)!.home),
                      onTap: () {
                        setState(() {
                          body = mapview;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.work),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      title: Text(AppLocalizations.of(context)!.shift),
                      onTap: () {
                        setState(() {
                          body = shift;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      title: Text(AppLocalizations.of(context)!.settings),
                      onTap: () {
                        setState(() {
                          body = settings;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.timer_off),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_outlined),
                        title: Text(AppLocalizations.of(context)!.end_shift),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_outlined),
                        title: Text(AppLocalizations.of(context)!.disconnect),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: body);
  }
}
