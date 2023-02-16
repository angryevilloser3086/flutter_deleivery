import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'src/itemscreen.dart';
import 'src/model/fooditem.dart';
import 'src/model/foodratingmodel.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 1;
  FoodItems? foodItem;
  List<FoodItems> foods = [];
  List<Widget> stars = [];
  List<FoodClip> foodClips = [];
  @override
  void initState() {
    setState(() {
      foods.add(FoodItems(
          iconName: "assets/images/greens.png",
          name: "Salad",
          isSelected: false));
      foods.add(FoodItems(
          iconName: "assets/images/pizza.png",
          name: "Pizza",
          isSelected: false));
      foods.add(FoodItems(
          iconName: "assets/images/burger.png",
          name: "Burger",
          isSelected: false));
      foods.add(FoodItems(
          iconName: "assets/images/milk.png",
          name: "Boba Milk",
          isSelected: false));
      foods.add(FoodItems(
          iconName: "assets/images/fried-rice.png",
          name: "Fried Rice",
          isSelected: false));
      foods.add(FoodItems(
          iconName: "assets/images/biryani.png",
          name: "Biryani",
          isSelected: false));
    });

    for (int i = 0; i < 5; i++) {
      setState(() {
        foodClips.add(FoodClip(
            name: "Salad With Shirata",
            foodImage:
                "http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/debris_blend.png",
            time: "10 min delivery",
            distance: "1",
            rating: 10,
            desc:
                """Some examples of descriptive text include: The sunset filled the entire sky with the deep color of rubies, setting the clouds ablaze. The waves crashed and danced along the shore, moving up and down in a graceful and gentle rhythm like they were dancing.
                Some examples of descriptive text include: The sunset filled the entire sky with the deep color of rubies, setting the clouds ablaze. The waves crashed and danced along the shore, moving up and down in a graceful and gentle rhythm like they were dancing.
Some examples of descriptive text include: The sunset filled the entire sky with the deep color of rubies, setting the clouds ablaze. The waves crashed and danced along the shore, moving up and down in a graceful and gentle rhythm like they were dancing.""",
            nOrders: "15k",
            price: 'Rp 100'));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.deepOrangeAccent,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "•",
              backgroundColor: Colors.deepOrangeAccent),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: "•",
              backgroundColor: Colors.deepOrangeAccent),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell),
              label: "•",
              backgroundColor: Colors.deepOrangeAccent),
          // BottomNavigationBarItem(
          //     icon: Icon(CupertinoIcons.person), label: '',backgroundColor: Colors.deepOrangeAccent),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            upperBody(),
            const SizedBox(
              height: 5,
            ),
            differentFoods(),
            differentFoods(),
            differentFoods()
          ],
        ),
      )),
    );
  }

  upperBody() {
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
      child: Column(
        children: [
          const Align(alignment: Alignment.topLeft, child: Text("Delivery to")),
          const SizedBox(
            height: 10,
          ),
          locationName(),
          const SizedBox(
            height: 10,
          ),
          searchBar(),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: foods.map((country) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        foodItem = country;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            decoration: getDec(country),
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: Image.asset(country.iconName),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(country.name)
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }

  getDec(FoodItems foodItems) {
    if (foodItem != null) {
      if (foodItem!.name == foodItems.name) {
        return const BoxDecoration(
            shape: BoxShape.circle, color: Colors.deepOrange);
      } else {
        return const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        );
      }
    } else {
      return const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      );
    }
  }

  searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      width: double.infinity,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          hintText: "What did you eat today?",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.only(
            top: 17,
          ),
        ),
      ),
    );
  }

  Row locationName() {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.deepOrangeAccent,
        ),
        const Text("Sukabumi, Indonesia"),
        Transform.rotate(
            angle: 90 * math.pi / 180,
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.deepOrangeAccent,
            ))
      ],
    );
  }

  foodClipsCards(FoodClip foodClip) {
    setState(() {
      stars = getStars(rating: foodClip.rating, starSize: 15);
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        shadowColor: Colors.black,
        child: Container(
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Transform.translate(
                  offset: const Offset(-5, -30), child: pic(foodClip)),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(foodClip.name!),
                const SizedBox(
                  height: 5,
                ),
                if (stars.isNotEmpty)
                  Row(
                    children: [
                      Row(
                        children: stars,
                      ),
                      Text(foodClip.rating.toString())
                    ],
                  ),
                const SizedBox(
                  height: 5,
                ),
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
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  differentFoods() {
    return Column(
      children: [
        popularFood(),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: foodClips.map((foodClip) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyFoodItem(
                                  foodClip: foodClip,
                                )),
                      );
                    },
                    child: foodClipsCards(foodClip));
              }).toList(),
            ))
      ],
    );
  }

  popularFood() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular food",
            style: Theme.of(context).textTheme.headline5,
          ),
          const Text("see all")
        ],
      ),
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

  pic(FoodClip foodClip) {
    return Stack(
      children: [
        foodPic(foodClip.foodImage!),
        Positioned(
          bottom: 0.5,
          right: 0.5,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: buildCircle(
                  child: Text(foodClip.nOrders!),
                  all: 8,
                  color: Colors.deepOrangeAccent),
            ),
          ),
        )
      ],
    );
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

  foodPic(String pic) {
    return Material(
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 120.0,
        height: 120.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: (pic.isEmpty)
            ? const Center(
                child: Text("Salad",
                    style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              )
            : Image(
                width: 60,
                image: NetworkImage(pic),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const StarIcon({Key? key, required this.icon, required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.yellow,
      size: size,
    );
  }
}
