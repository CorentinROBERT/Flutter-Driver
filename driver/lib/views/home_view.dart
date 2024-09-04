import 'package:driver/models/enum/home_section_enum.dart';
import 'package:driver/views/home/map_view.dart';
import 'package:driver/views/home/order_details.dart';
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
  var shift = ShiftView();
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
          forceMaterialTransparency: body == mapview,
          backgroundColor: body == mapview ? Colors.transparent : Colors.black,
          centerTitle: true,
          elevation: 0,
          title: Visibility(
            visible: body == mapview,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderDetails(
                          orderNumber: "JJA-1119",
                        )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.more_horiz,
                      color: Colors.pinkAccent,
                      size: 30,
                    ),
                    Text(
                      "JJA-1119",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
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
