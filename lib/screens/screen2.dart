import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ImageSlideshow(
                  width: double.infinity,
                  height: 250,
                  initialPage: 0,
                  indicatorColor: Colors.white,
                  indicatorBackgroundColor: Color(0x98ffffff),
                  indicatorBottomPadding: 80,
                  onPageChanged: (value) {
                  },
                  // autoPlayInterval: 5000,
                  isLoop: false,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7c94b6),
                        image: DecorationImage(
                          image: AssetImage('assets/images/img1.png'),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.overlay),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7c94b6),
                        image: DecorationImage(
                          image: AssetImage('assets/images/img1.png'),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.overlay),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7c94b6),
                        image: DecorationImage(
                          image: AssetImage('assets/images/img1.png'),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.overlay),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 200),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text('Boston Lettuce',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xff2D0C57))),
                      SizedBox(height: 25),

                      Wrap(
                        spacing: 5,
                        children: [
                          Text('1.10 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(0xff2D0C57))),
                          Text("€ / piece",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text('~ 150 gr / piece',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(height: 40),

                      Text('Spain',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xff2D0C57))),
                      SizedBox(height: 20),

                      Text('Lettuce is an annual plant of the daisy family, Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.grey)),
                      SizedBox(height: 100),

                      Row(
                        children: [
                          Container(
                            width: 80,
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
                          Expanded(
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2, color: Theme.of(context).primaryColor
                                  ),
                                  color: Theme.of(context).primaryColor
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Image.asset('assets/images/cart.png', height: 25),
                                SizedBox(width: 10),
                                Text('ADD TO CART', style: TextStyle(color: Colors.white),),
                              ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
