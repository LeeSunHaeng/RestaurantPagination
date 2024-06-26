import 'package:flutter/material.dart';
import 'package:restaurant_pagination/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '떡볶이',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,),
                ),
                Text(
                  '전통 떡볶이의 정석!\n맛있습니다.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: BODY_TEXT_COLOR),
                ),
                Text(
                  '10000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR
                  ),
      
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
