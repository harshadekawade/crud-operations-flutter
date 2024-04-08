import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manage_product/screens/products.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  bool selected = false;
  List<FilterChipBoz> chips = [
    FilterChipBoz('Cabbage and lettuce (14)', true),
    FilterChipBoz('Cucumber and Tomato (10)', false),
    FilterChipBoz('Onions and Garlic (8)', false),
    FilterChipBoz('Peppers (7)', false),
    FilterChipBoz('Potatoes (5)', false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 20, color: Color(0xff2D0C57)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Vegetables',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color(0xff2D0C57)))
                          ],
                        ),
                      ),
                      Image.asset('assets/images/topimg.png', height: 200)
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 170, left: 20, right: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Icon(
                              Icons.search_outlined,
                              size: 35,
                              color: Colors.black,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                color: Color(0xffE4D9EA), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                color: Color(0xff2D0C57), width: 1),
                          ),
                          hintText: 'Search'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    textDirection: TextDirection.ltr,
                    direction: Axis.horizontal,
                    children: chipsWidget(),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child:Column(
                  children: [
                    listRow('img1.png', 'Boston Lettuce', '1.10', 'pieces'),
                    listRow('img2.png', 'Purple Cauliflower', '1.85', 'kg'),
                    listRow('img3.png', 'Savoy Cabbage', '1.45', 'kg'),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(
            color: Color(0xffB37DF4)
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.amber[800],
          onTap: (index){

          },
        ),
      ),
    );
  }

  List<Widget> chipsWidget() {
    List<Widget> c = [];
    for (int i = 0; i < chips.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          backgroundColor: Colors.white,
          selectedColor: const Color(0xffE2CBFC),
          checkmarkColor: const Color(0xff6C0DE4),
          disabledColor: Colors.white,
          label: Text(chips[i].label),
          selected: chips[i].isSelected,
          labelStyle: TextStyle(
              color: chips[i].isSelected ? Color(0xff6C0DE4) : Colors.grey),
          onSelected: (bool value) {
            setState(() {
              chips[i].isSelected = value;
            });
          },
        ),
      );
      c.add(item);
    }
    return c;
  }

  Widget listRow(image, name, price, unit){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/$image', scale: 2.3),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2D0C57))),
                  SizedBox(height: 10),

                  Wrap(
                    spacing: 5,
                    children: [
                      Text(price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff2D0C57))),
                      Text("€ / $unit",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Color(0xffE4D9EA)
                            ),
                            color: Colors.white
                        ),
                        child: Image.asset('assets/images/heart.png', height: 25),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Theme.of(context).primaryColor
                            ),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Image.asset('assets/images/cart.png', height: 25),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FilterChipBoz {
  late String label;
  late bool isSelected;
  FilterChipBoz(this.label, this.isSelected);
}
