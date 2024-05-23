import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridItem extends StatelessWidget {
  final String? name;
  String? image;
  final IconData? icon;
  String? route;

  GridItem({required this.name, this.image, this.icon, this.route});
  @override
  Widget build(BuildContext context) {
    List<Widget> myWidgets = [];

    // Icon(icon),
    //           const SizedBox(height: 8),
    //           Text(
    //             name,
    //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //           ),

    if (image != null) {
      myWidgets.add(Image.asset(
        image!,
        fit: BoxFit.cover,
      ));
    }
    if (icon != null) {
      myWidgets.add(Icon(icon));
    }
    if (name != null && image == null) {
      myWidgets.add(
        Text(
          name!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          if (route != null) {
            Navigator.pushNamed(context, route!);
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: myWidgets,
          ),
        ),
      ),
    );
  }
}