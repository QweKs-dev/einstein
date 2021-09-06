import 'package:einstein/Additionaly/web_app.dart';
import 'package:einstein/core/NeiroController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neirobank_web_apps_channel/profile_channel/profile_channel.dart';

ProfileChannel profileChannel;
void main() async {
  await NeiroController().onStart();
  profileChannel = ProfileChannel();
  await GetStorage.init('einstainCacha');
  await GetStorage.init('CouponStorage');
  if(kIsWeb)
  profileChannel.init();
  runApp(WebApp());
}
