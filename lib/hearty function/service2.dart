import 'package:flutter/material.dart';
import 'service.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            //Spacer(flex: 2,),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(100),
              //height: 200,
              //width: 180,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(product.image),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                child: Text(product.title, style:
                Theme.of(context)
                    .textTheme
                    .bodyText1.copyWith(
                  color : Theme.of(context).textTheme
                      .bodyText1
                      .color.withOpacity(0.8),)))
          ]
      ),
    );
  }
}