import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_pagination/restaurant/component/restraunt_card.dart';
import 'package:restaurant_pagination/restaurant/model/restaurant_model.dart';
import 'package:restaurant_pagination/restaurant/view/restaurant_detail_screen.dart';

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
                  itemBuilder: (_, index) {
                    final item = snapShot.data![index];
                    final pItem = RestaurantModel.fromJson(json: item);

                    return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => RestaurantDetainScreen())
                          );
                        },
                        child: RestaurantCard.fromModel(model: pItem));
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 16.0,);
                  },

                );
              },
            )
        )
    );
  }
}
