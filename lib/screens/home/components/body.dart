import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../models/images/images.dart';


class HomeBody extends StatelessWidget {
  final List allImagesURL = Images().getAllImages();
  // int temp = allImagesURL.toList().length % 3 ;
  // int temp = 0;
  int temp = 0;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SearchBar(size: size),
        // Carousel
        Container(
          padding: kPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular now', style: kLabelTextStyle),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(Icons.arrow_right_alt,
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
              CarouselSlider.builder(
                itemCount: ( allImagesURL.length / 3 ).round(),
                itemBuilder: (context, index, realIndex) {
                  final int first = index * 3;
                  final int second = first + 1;
                  final int third = second + 1 >= allImagesURL.length ? 0 : second + 1;

                  // final int third = second + 1;
                      // second + 1 >= allImagesURL.length ? second : second + 1;
                  final int temp = ( allImagesURL.length / 3 ).round();
                  // print('length: $temp');
                  // print('first $first');
                  // print('second $second');
                  // print('third $third');
                  return Row(
                    children: [first, second, third]
                        .map((rIndex) => Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    allImagesURL[rIndex],
                                    fit: BoxFit.cover,
                                    // width: 50.0,  can not set width
                                    height: 175.0,
                                    // height: 350.0,
                                    // width: 250.0,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.99,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: kPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular now', style: kLabelTextStyle),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(Icons.arrow_right_alt,
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
              CarouselSlider.builder(
                itemCount: ( allImagesURL.length / 3 ).round(),
                itemBuilder: (context, index, realIndex) {
                  final int first = index * 3;
                  final int second = first + 1;
                  final int third = second + 1 >= allImagesURL.length ? 0 : second + 1;

                  // final int third = second + 1;
                  // second + 1 >= allImagesURL.length ? second : second + 1;
                  final int temp = ( allImagesURL.length / 3 ).round();
                  // print('length: $temp');
                  // print('first $first');
                  // print('second $second');
                  // print('third $third');
                  return Row(
                    children: [first, second, third]
                        .map((rIndex) => Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            allImagesURL[rIndex],
                            fit: BoxFit.cover,
                            // width: 50.0,  can not set width
                            height: 175.0,
                            // height: 350.0,
                            // width: 250.0,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.99,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: kPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular now', style: kLabelTextStyle),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(Icons.arrow_right_alt,
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
              CarouselSlider.builder(
                itemCount: ( allImagesURL.length / 3 ).round(),
                itemBuilder: (context, index, realIndex) {
                  final int first = index * 3;
                  final int second = first + 1;
                  final int third = second + 1 >= allImagesURL.length ? 0 : second + 1;

                  // final int third = second + 1;
                  // second + 1 >= allImagesURL.length ? second : second + 1;
                  final int temp = ( allImagesURL.length / 3 ).round();
                  // print('length: $temp');
                  // print('first $first');
                  // print('second $second');
                  // print('third $third');
                  return Row(
                    children: [first, second, third]
                        .map((rIndex) => Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            allImagesURL[rIndex],
                            fit: BoxFit.cover,
                            // width: 50.0,  can not set width
                            height: 175.0,
                            // height: 350.0,
                            // width: 250.0,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.99,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: kPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular now', style: kLabelTextStyle),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(Icons.arrow_right_alt,
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
              CarouselSlider.builder(
                itemCount: ( allImagesURL.length / 3 ).round(),
                itemBuilder: (context, index, realIndex) {
                  final int first = index * 3;
                  final int second = first + 1;
                  final int third = second + 1 >= allImagesURL.length ? 0 : second + 1;

                  // final int third = second + 1;
                  // second + 1 >= allImagesURL.length ? second : second + 1;
                  final int temp = ( allImagesURL.length / 3 ).round();
                  // print('length: $temp');
                  // print('first $first');
                  // print('second $second');
                  // print('third $third');
                  return Row(
                    children: [first, second, third]
                        .map((rIndex) => Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            allImagesURL[rIndex],
                            fit: BoxFit.cover,
                            // width: 50.0,  can not set width
                            height: 175.0,
                            // height: 350.0,
                            // width: 250.0,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.99,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: kPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular now', style: kLabelTextStyle),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(Icons.arrow_right_alt,
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
              CarouselSlider.builder(
                itemCount: ( allImagesURL.length / 3 ).round(),
                itemBuilder: (context, index, realIndex) {
                  final int first = index * 3;
                  final int second = first + 1;
                  final int third = second + 1 >= allImagesURL.length ? 0 : second + 1;

                  // final int third = second + 1;
                  // second + 1 >= allImagesURL.length ? second : second + 1;
                  final int temp = ( allImagesURL.length / 3 ).round();
                  // print('length: $temp');
                  // print('first $first');
                  // print('second $second');
                  // print('third $third');
                  return Row(
                    children: [first, second, third]
                        .map((rIndex) => Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            allImagesURL[rIndex],
                            fit: BoxFit.cover,
                            // width: 50.0,  can not set width
                            height: 175.0,
                            // height: 350.0,
                            // width: 250.0,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.99,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.1,
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find Wallpaper...',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (valueChanged) {
                    print(valueChanged);
                  },
                ),
              ),
              SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.black.withOpacity(0.5),
              )
            ],
          ),
        ));
  }
}
