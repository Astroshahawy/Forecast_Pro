// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _WeatherRemoteDataSource implements WeatherRemoteDataSource {
  _WeatherRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://api.weatherapi.com/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherModel> getWeather(cityName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': cityName};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'forecast.json?key=173514b02f4144fa9e1200509220209',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WeatherModel> get2DaysForecast(cityName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': cityName};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'forecast.json?key=173514b02f4144fa9e1200509220209&days=2',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WeatherModel> get7DaysForecast(cityName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': cityName};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'forecast.json?key=173514b02f4144fa9e1200509220209&days=7',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<SearchItemModel>> searchByCityName(cityName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': cityName};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SearchItemModel>>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, 'search.json?key=173514b02f4144fa9e1200509220209',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => SearchItemModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
