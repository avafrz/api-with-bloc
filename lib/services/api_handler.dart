import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'token_provider.dart';

Dio dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(onError: (error, handler) {
      print('___________________________________________________');
      print("error: ${error.toString()}\n");
      handler.reject(error);
     
    }, onRequest: (request, handler) {
      print('___________________________________________________');
      print(
          'token is ==>>  ${TokenProvider.prefs.getString('accessToken')} *****');

      try {
        if (TokenProvider.prefs.getString('accessToken') != null) {
          request.headers['Authorization'] =
              'Bearer ${TokenProvider.prefs.getString('accessToken')}';
        }

        request.headers['Content-Type'] = 'application/json';
        request.headers['BusinessKey'] = '1da5ce01-7491-44a2-a823-2f4734ef0aef';
        print(
          'Request=> ${request.baseUrl}${request.path}'
          '\n'
          'Body => ${request.data}'
          '\n'
          'Params => ${request.queryParameters}'
          '\n',
        );
        handler.next(request);
      } catch (e) {
        print('___________________________________________________');
        print(
            "request error => ${request.path} \ndata: ${request.data.toString()}\n");
      }
    }, onResponse: (response, handler) async {
      print(
        'Response=> ${response.realUri} '
        '\n'
        'Data => ${response.data}'
        '\n'
        'Extra => ${response.extra}',
      );

      // if (response.statusCode == 401) {
      //  refreshToken(
      //       TokenProvider.prefs.getString('refreshToken') ?? '');
      // }
      handler.resolve(response);
    }),
  );

Future<Response> enterPhone(BuildContext context, String phoneNo) async {
  Response response = await dio.post(
    'https://sit-bnpl.saminray.com/usermanagementnew/Auth/SendCode',
    data: {
      'phoneNo': phoneNo,
    },
  );
  return response;
}

Future<Response> sendCode(
    BuildContext context, String phoneNo, int loginCode) async {
  final response = await dio.post(
    'https://sit-bnpl.saminray.com/usermanagementnew/Auth/Login',
    data: {
      'phoneNo': phoneNo,
      'loginCode': loginCode,
    },
  );

  return response;
}

Future<void> refreshToken(String refreshToken) async {
  final response = await dio.post(
      'https://sit-bnpl.saminray.com/usermanagementnew/Auth/Refresh',
      data: {
        'refreshToken': refreshToken,
      });
  TokenProvider.prefs.setString(
      'accessToken', response.data['valueOrDefault']['tokens']['accessToken']);
}

Future<Response> userData(BuildContext context) async {
  final response = await dio.get(
    'https://sit-bnpl.saminray.com/apiappnew/Merchant/SearchMerchant?hasPaging=true&_page=1&_limit=10',
  );
  return response;
}
