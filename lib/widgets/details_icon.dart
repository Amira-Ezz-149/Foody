import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsIcon extends StatelessWidget {
  DetailsIcon({this.icon, this.text = ''});
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            icon,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
