import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_repository/super_repository.dart';

import '../../../core/routes/app_routes.dart';

class SettingsController extends GetxController {
  final _local = SuperRepository.provider.local;

  Locale get getLocale => Locale(_local.get(key: AppRoutes.languages) ??
      Platform.localeName.substring(0, 2));
}
