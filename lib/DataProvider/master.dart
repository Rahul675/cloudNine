import 'package:cloudnine/models/master.dart';
import 'package:cloudnine/models/usersModel.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';

class MasterDataProvider extends ChangeNotifier {
  Master? _data;
  Master? get data => _data;

  Future<void> fetchMasterData() async {
    print('11_fetchMasterData+========================>>>>>');
    try {
      final result = await ApiService.cloudMaster();
      _data = Master.fromJson(result);
      notifyListeners();
      userData();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Master? _masterData;
  // Master? get masterData => _masterData;

  // Future<void> fetchCloudMasterData() async {
  //   try {
  //     final result = await ApiService.cloudMaster();
  //     _masterData = Master.fromJson(result);
  //     notifyListeners();
  //     userData();
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  List cities = [];
  Future<void> getCitiesByState(String stateId) async {
    for (var i = 0; i < data!.city.length; i++) {
      if (data!.city[i] == stateId) {
        cities.add(data!.city[i]);
      }
    }
    data?.city = cities;
    print("cities===>$cities");
    notifyListeners();
  }

  User? _user;
  User? get user => _user;

  Future<void> userData() async {
    try {
      final result = await ApiService.userDetails();
      _user = User.fromJson(result);
      notifyListeners();
      print('13_fetcUserData+========================>>>>>${_user!.email}');
      print('14_fetcUserData+========================>>>>>${user!.email}');
    } catch (e) {
      print('Error fetching data: $e');
    } 
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }
}
