import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide(
      {
        @required this.imageUrl,
        @required this.description,
        @required this.title
      }
    );
}

final slideList = [
  Slide(
      imageUrl: 'assets/images/IMG_20200630_203911.jpg',
      description: 'Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using readable English.',
      title:'This is first slider'
      ),
  Slide(
      imageUrl: 'assets/images/IMG_20200630_203925.jpg',
      description: 'Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using readable English.',
      title:'This is second slider'),
  Slide(
      imageUrl: 'assets/images/IMG_20200630_204007.jpg',
      description: 'Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using readable English.',
      title:'This is third slider'),
  Slide(
      imageUrl: 'assets/images/IMG_20200630_204008.jpeg',
      description: 'Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using readable English.',
      title:'This is fourth slider')
];
