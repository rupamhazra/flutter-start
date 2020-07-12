import 'package:flutter/material.dart';
import '../model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(slideList[index].imageUrl),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 30,
        ),
        Text(slideList[index].title,
            style: TextStyle(color: Theme.of(context).primaryColor)),
        SizedBox(
          height: 15,
        ),
        Text(
         slideList[index].description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
