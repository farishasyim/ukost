import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ukost/config/storage.dart';

const String appname = "UKOST";

Dio dio = Dio();

ValueNotifier<bool> loading = ValueNotifier(false);

Storage storage = Storage();

enum Role { customer, admin }

enum UserStatus { available, unavailable, all }
