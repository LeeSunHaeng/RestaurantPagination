import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_pagination/common/const/colors.dart';
import 'package:restaurant_pagination/common/layout/default_layout.dart';
import 'package:restaurant_pagination/common/view/root_tabs.dart';

import '../../common/component/custom_text_form_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/const/data.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String id = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    return DefaultLayout(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
                top: true,
                bottom: false,
                child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            _Title(),
            const SizedBox(height: 16.0,),
            _SubTilte(),
            Image.asset(
              'asset/img/misc/logo.png',
              height: MediaQuery.of(context).size.width * (2 / 3),
            ),
            CustomTextFormField(
              hintText: '이메일을 입력해주세요.',
              autoFocus: true,
              onChanged: (String value) {
                id = value;
              },
            ),
            const SizedBox(height: 16.0,),
            CustomTextFormField(
              hintText: '비밀번호를 입력해주세요.',
              onChanged: (String value) {
                password = value;
              },
            ),
            const SizedBox(height: 16.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: PRIMARY_COLOR
              ),
                onPressed: () async{
                  // final rawString = 'test@codefactory.ai:testtest';
                  String rawString = '$id:$password';
                  Codec<String,String> stringToBase64 = utf8.fuse(base64);

                  String token = stringToBase64.encode(rawString);

                  final resp = await dio.post('http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization' : 'Basic $token'
                        }
                      ));
                  final refreshToken = resp.data['refreshToken'];
                  final accessToken = resp.data['accessToken'];

                  await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                  await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RootTab())
                  );
                  print(resp.data);
                },
                child: Text('로그인')),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black
              ),
                onPressed: () async{

                },
                child: Text('회원가입')),
          ]),
                ),
              ),
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTilte extends StatelessWidget {
  const _SubTilte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 이볅해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
