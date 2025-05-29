import 'package:common/common.dart';

class HttpClientImpl extends HttpClient {
  HttpClientImpl({required this.authRepository})
      : super(clientConfig: AppEnvironment.current.config);

  final AuthRepository authRepository;

  /// Headers with [JWT] token
  @override
  Map<String, String>? get headers => authRepository.headersWithJWT;

  @override
  Future<T> request<T>({
    String? baseUrl,
    required String path,
    required HttpMethod method,
    JsonObject query = const {},
    dynamic body,
    HttpFormData? formData,
    Map<String, String>? headers,
    HttpProgressCallback? onSendProgress,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) async {
    headers ??= this.headers ?? {};
    try {
      // RefreshToken if expired

      // final token = authRepository.authToken;
      // if (token != null && JwtDecoder.isExpired(token)) {
      //   final accessToken = await authRepository.getRefreshedToken();
      //   if (accessToken.isNotNull) {
      //     headers['Authorization'] = 'Bearer $accessToken';
      //   }
      // }

      return await super.request<T>(
        baseUrl: baseUrl,
        path: path,
        method: method,
        query: query,
        body: body,
        formData: formData,
        headers: headers,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        timeout: timeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );
    } catch (e) {
      // UnauthorisedException
      // if (e is UnauthorisedException) {
      //   authRepository.logOut();
      // }
      rethrow;
    }
  }

  @override
  String? decodeMessage(dynamic data, int statusCode) {
    final message = super.decodeMessage(data, statusCode);
    if (message != null) return message;

    if (data is JsonObject && data.isNotEmpty) {
      final error = data['error'] ?? data['response'];
      if (error is JsonObject && error.isNotEmpty) {
        final errors = error.values.firstOrNull;
        if (errors is JsonArray && errors.isNotEmpty) {
          final message = errors.firstOrNull;
          if (message is String && message.isNotBlank) {
            return message;
          }
        } else if (errors is String && errors.isNotBlank) {
          return errors;
        }
      } else if (error is String && error.isNotBlank) {
        return error;
      }
    }
    return '$statusCode: Something went wrong, please try again later.';
  }
}
