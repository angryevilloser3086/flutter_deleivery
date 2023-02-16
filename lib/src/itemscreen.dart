import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../deliveryapp.dart';
import 'model/foodratingmodel.dart';

class MyFoodItem extends StatefulWidget {
  final FoodClip foodClip;
  const MyFoodItem({super.key, required this.foodClip});

  @override
  State<MyFoodItem> createState() => _MyFoodItemState();
}

class _MyFoodItemState extends State<MyFoodItem> {
  List<Widget> stars = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: addtoCart(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _upperBody(widget.foodClip),
            foodClipsCards(widget.foodClip),
            const SizedBox(
              height: 10,
            ),
            sizeChart(),
          ],
        ),
      )),
    );
  }

  _upperBody(FoodClip foodClip) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
            Colors.white,
            Colors.white10,
            Color.fromARGB(15, 222, 102, 47)
          ])),
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        Image.network(foodClip.foodImage!),
      ]),
    );
  }

  sizeChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Size",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }

  addtoCart() {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      shadowColor: Colors.black,
      child: Container(
        height: 210,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Price",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                )),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(widget.foodClip.price,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove_circle_rounded),
                      onPressed: () => _decrementCounter(),
                      color: Colors.deepOrangeAccent,
                    ),
                    Text("$_counter"),
                    IconButton(
                      icon: const Icon(Icons.add_circle_rounded),
                      color: Colors.deepOrangeAccent,
                      onPressed: () => _incrementCounter(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            toButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Container toButton() {
    return Container(
        width: 260,
        height: 48,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrangeAccent),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.deepOrangeAccent),
        child: const Center(
          child: Text(
            "Add to cart",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ));
  }

  foodClipsCards(FoodClip foodClip) {
    setState(() {
      stars = getStars(rating: foodClip.rating, starSize: 15);
    });
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${foodClip.distance!} km "),
                const Text(
                  " • ",
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                Text(foodClip.time!)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodClip.name!,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  buildCircle(
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.redAccent,
                      ),
                      all: 5,
                      color: Colors.white)
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (stars.isNotEmpty)
              Row(
                children: [
                  Row(
                    children: stars,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${foodClip.rating.toString()}  Rating")
                ],
              ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.foodClip.desc,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ]),
    );
  }

  List<Widget> getStars({required double? rating, required double starSize}) {
    List<StarIcon> temp = [];
    if (rating != null) {
      for (var i = 0; i < rating ~/ 2; i++) {
        //(rating / 2).toInt() == rating ~/ 2;
        setState(() {
          temp.add(StarIcon(
            icon: Icons.star,
            size: starSize,
          ));
        });
      }
      if (rating > 0 && rating % 5 == 0) {
        setState(() {
          temp.add(StarIcon(
            icon: Icons.star,
            size: starSize,
          ));
        });
      }
      if (rating > 0 && rating % 2 != 0) {
        setState(() {
          temp.add(StarIcon(
            icon: Icons.star_half,
            size: starSize,
          ));
        });
      }

      while (temp.length < 5) {
        setState(() {
          temp.add(StarIcon(
            icon: Icons.star_border,
            size: starSize,
          ));
        });
      }
    }
    return temp;
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
