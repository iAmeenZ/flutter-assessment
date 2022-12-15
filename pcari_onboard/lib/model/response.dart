import 'dart:convert';

import 'package:pcari_onboard/model/contact.dart';

class PostmanResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Contact>? data;
  Support? support;
  
  PostmanResponse({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(page != null){
      result.addAll({'page': page});
    }
    if(perPage != null){
      result.addAll({'perPage': perPage});
    }
    if(total != null){
      result.addAll({'total': total});
    }
    if(totalPages != null){
      result.addAll({'totalPages': totalPages});
    }
    if(data != null){
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }
    if(support != null){
      result.addAll({'support': support!.toMap()});
    }
  
    return result;
  }

  factory PostmanResponse.fromMap(Map<String, dynamic> map) {
    return PostmanResponse(
      page: map['page']?.toInt(),
      perPage: map['perPage']?.toInt(),
      total: map['total']?.toInt(),
      totalPages: map['totalPages']?.toInt(),
      data: map['data'] != null ? List<Contact>.from(map['data']?.map((x) => Contact.fromMap(x))) : null,
      support: map['support'] != null ? Support.fromMap(map['support']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostmanResponse.fromJson(String source) => PostmanResponse.fromMap(json.decode(source));
}

class Support {
  String? url;
  String? text;
  
  Support({
    this.url,
    this.text,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(url != null){
      result.addAll({'url': url});
    }
    if(text != null){
      result.addAll({'text': text});
    }
  
    return result;
  }

  factory Support.fromMap(Map<String, dynamic> map) {
    return Support(
      url: map['url'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Support.fromJson(String source) => Support.fromMap(json.decode(source));
}

class ResponseOrError {
  String? anyError;
  PostmanResponse? response;

  ResponseOrError({
    this.anyError,
    this.response,
  });
}
