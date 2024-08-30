import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key, required this.orderNumber});

  String orderNumber;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: "Client",
              ),
              Tab(icon: Icon(Icons.food_bank), text: "Commande"),
              Tab(icon: Icon(Icons.business), text: "Restaurant"),
            ],
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: const BackButton(
            color: Colors.pinkAccent,
          ),
          title: Text(
            orderNumber,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Informations clients",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Nom Prénom",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Adresse + notes",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Status client MVP / premium / abonné",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Nombre de commande passé",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Informations commande",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Nourriture",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Boissons",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Nombre de sacs",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Informations restaurant",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Nom de l'enseigne",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Adresse + notes",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
