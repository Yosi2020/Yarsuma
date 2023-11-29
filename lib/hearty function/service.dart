import 'package:flutter/material.dart';

class Product {
  final String image, title;
  final int id;
  final Color color;
  Product({
    this.id,
    this.image,
    this.title,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Internet of Things (IOT)",
      image: "assets/image/s1.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Artificial Intelligence",
      image: "assets/image/s2.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 3,
      title: "Website Development",
      image: "assets/image/s3.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 4,
      title: "Mobile Application",
      image: "assets/image/s4.jpg",
      color: Color(0xFF3D82AE)),
];