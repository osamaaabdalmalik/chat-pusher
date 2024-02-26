import 'dart:convert';

import 'package:pusher/core/errors/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

Unit getExceptionStatusCode(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return unit;
    case 400:
      throw BadRequestException(message: json.decode(response.body)['message']);
    case 403:
      throw UnAuthorizedException();
    case 401:
      throw UnAuthenticatedException();
    case 404:
      throw NotFoundException();
    case 500:
      throw InternalServerErrorException();
    default:
      throw UnexpectedException();
  }
}
