import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/screens/item_details.dart';
import 'package:provider/provider.dart';
import '../services/providers/my_provider.dart';

class CustomizedGridViewItem extends StatelessWidget {
  final String description;
  final String foodName;
  final String image;
  final String price;
  final String veryHealthy;
  final String vegan;
  final String veryPopular;
  final String readyInMinutes;

  CustomizedGridViewItem(
      {this.foodName,
      this.price,
      this.image,
      this.description,
      this.vegan,
      this.veryHealthy,
      this.readyInMinutes,
      this.veryPopular});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Consumer<MyProvider>(
          builder: (_, value, child) => Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            width: Provider.of<MyProvider>(context).chooseWidth(context) / 1.5,
            height: Provider.of<MyProvider>(context).chooseHeight(context),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(0, 10), //(x,y)
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade200,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(
                          foodName: foodName,
                          image: image,
                          price: price,
                          description: description,
                          vegan: vegan,
                          readyInMinutes: readyInMinutes,
                          veryHealthy: veryHealthy,
                          veryPopular: veryPopular,
                        ),
                      ),
                    );
                  },
                  child: Image(
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.height / 4,
                    image: NetworkImage(image),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  child: Text(
                    '$foodName',
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$price',
                      style:
                          TextStyle(color: priceColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$readyInMinutes min',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
