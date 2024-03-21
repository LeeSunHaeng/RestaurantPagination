import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_pagination/restaurant/component/restraunt_card.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    print(accessToken);
    final resp = await dio.get('http://$ip/restaurant',
        options: Options(
            headers: {
              'authorization': 'Bearer ${accessToken}',
            }
        ));
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List> snapShot) {
                if (!snapShot.hasData) {
                  return Container();
                }
                return ListView.separated(
                    itemCount: snapShot.data!.length,
                    itemBuilder: (_, index){
                      final item = snapShot.data![index];
                      return RestaurantCard(
                        image: Image.network('http://$ip${item['thumbUrl']}'),
                        // image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                        name: item['name'],
                        tags: List<String>.from(item['tags']) ,
                        ratingsCount: item['ratingsCount'],
                        deliveryTime: item['deliveryTime'],
                        deliveryFee: item['deliveryFee'],
                        ratings: item['ratings'],
                      );
                    },
                    separatorBuilder: (_, index){
                      return SizedBox(height: 16.0,);
                    },

                );

              },
            )
        )
    );
  }
}