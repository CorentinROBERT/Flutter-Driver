import 'package:driver/models/enum/home_section_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  Widget body = Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Text(AppLocalizations.of(context)!.app_title),
        ),
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
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.work),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      title: Text(AppLocalizations.of(context)!.shift),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      title: Text(AppLocalizations.of(context)!.settings),
                      onTap: () {},
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
