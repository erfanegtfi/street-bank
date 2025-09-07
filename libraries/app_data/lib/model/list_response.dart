import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {
  List<T>? result;

  ListResponse({super.status, this.result});

  factory ListResponse.fromJson(dynamic json, Function(Map<String, dynamic>) create) {
    List<T> result = [];
    json['result'].forEach((v) {
      result.add(create(v));
    });

    return ListResponse<T>(result: result);
  }
}
