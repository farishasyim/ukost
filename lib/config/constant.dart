import 'package:flutter/material.dart';
import 'package:ukost/config/storage.dart';

const String appname = "ukost";

ValueNotifier<bool> loading = ValueNotifier(false);

Storage storage = Storage();
