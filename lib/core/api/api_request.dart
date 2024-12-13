import 'package:dio/dio.dart';
import 'package:movies/core/api/api_constants.dart';
import 'package:movies/core/api/api_log.dart';

class ApiRequest {
  ApiRequest({
    required this.path,
    required this.method,
    this.requestFunction,
    this.className,
    this.header,
    this.body,
    this.queryParameters,
    this.formatResponse = false,
    this.withLoading = false,
    this.shouldShowMessage = true,
  });

  final String? path;
  final String? method;
  final String? className;
  final Map<String, dynamic>? header;
  String authorization() =>
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTk5MGJjZTY1YTc1MGM3NTI2YWEzMGJiNDBjZjZkZCIsIm5iZiI6MTczMzk0NDI3NC44NzY5OTk5LCJzdWIiOiI2NzU5ZTNkMjU1N2RlNTJlMjUxMWQ1ZGUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.Yx1ZqyXHleGoJraMFh-DxHBt82-k4gPikr31OYoirzQ';
  final bool withLoading;
  final bool formatResponse;
  final bool shouldShowMessage;
  final dynamic body;
  final dynamic queryParameters;
  dynamic response;
  final Function? requestFunction;

  Dio _dio() {
    // Put your authorization token here
    return Dio(
      BaseOptions(
        headers: <String, dynamic>{
          'Authorization': authorization(),
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Device-Type': 'MOBILE',

          ...(header ?? <String, dynamic>{}),
        },
      ),
    );
  }

  Future<void> request({
    Function()? beforeSend,
    Function(dynamic data, dynamic response)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    // start request time
    final Stopwatch stopwatch = Stopwatch()..start();

    // if (!_myAppController.isInternetConnect) {
    //   _myAppController.noInternetWaitingRequests.add(<String, dynamic>{
    //     keyRequestFunction: requestFunction,
    //   });
    //   _myAppController.update();
    //   dismissLoading();
    //   return;
    // }

    try {
      if (withLoading) {
        // startLoading();
      }
      // check method type
      switch (method) {
        case getMethod:
          response = await _dio()
              .get(baseUrl + path!, queryParameters: queryParameters);

          break;
        case postMethod:
          response = await _dio().post(
            baseUrl + path!,
            data: body,
            queryParameters: queryParameters,
          );
          break;
        case putMethod:
          response = await _dio().put(
            baseUrl + path!,
            data: body,
            queryParameters: queryParameters,
          );
          break;
        case deleteMethod:
          response = await _dio().delete(
            baseUrl + path!,
            data: body,
            queryParameters: queryParameters,
          );
          break;
      }

      // print response data in console
      showRequestDetails(
        method: method,
        path: path,
        formatResponse: formatResponse,
        className: className,
        body: body.toString(),
        headers: _dio().options.headers,
        queryParameters: queryParameters.toString(),
        response: response.data,
        time: stopwatch.elapsedMilliseconds,
      );
      stopwatch.stop();

      if (withLoading) {
        // dismissLoading();
      }
      if (onSuccess != null) {
        onSuccess(response.data['data'], response.data);
      }
    } on Exception catch (error) {
      // dismissLoading();
      if (error is DioException) {
        final dynamic errorData = error.response?.data ??
            <String, dynamic>{
              'errors': <Map<String, String>>[
                <String, String>{'message': 'Un handled Error'}
              ]
            };
        // print response error
        showRequestDetails(
          method: method,
          path: path,
          formatResponse: formatResponse,
          className: className,
          body: body.toString(),
          headers: _dio().options.headers,
          queryParameters: queryParameters.toString(),
          response: errorData,
          time: stopwatch.elapsedMilliseconds,
          isError: true,
        );

        //handle DioError here by error type or by error code
        if (shouldShowMessage) {
          // showMessage(
          //   description:
          //       errorData['errors'] != null && errorData['errors'].length > 0
          //           ? errorData['errors'][0]['message']
          //           : errorData['message'],
          // );
        }

        if (onError != null) {
          onError(errorData);
        }

        if (error.response!.statusCode == 401) {
          // Get.find<MyAppController>().onSignOut();
          // Get.offAllNamed(routeLogin);

          //SingOut
          //GoToLogin
        }
      } else {
        // handle another errors
        showRequestDetails(
          method: method,
          path: path,
          formatResponse: formatResponse,
          className: className,
          body: body.toString(),
          headers: _dio().options.headers,
          queryParameters: queryParameters.toString(),
          response: error,
          time: stopwatch.elapsedMilliseconds,
          isError: true,
          otherCatch: true,
        );
      }
      stopwatch.stop();
    }
  }
}
