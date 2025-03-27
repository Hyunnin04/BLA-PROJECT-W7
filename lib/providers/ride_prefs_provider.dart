import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferenceProvider extends ChangeNotifier {
   final RidePreferencesRepository repository;
 
   List<RidePreference> pastPreference = [];
 
   RidePreference? _currentPreference;
 
   RidesPreferenceProvider({required this.repository});
 
   RidePreference? get currentPreference {
    //  print("Get current pref: $_currentPreference");
     return _currentPreference;
   }
 
   void setCurrentPreference(RidePreference preference) {
     if (_currentPreference != preference) {
    //    print("Set current pref to $_currentPreference");
       _currentPreference = preference;
       addPreference(preference);
       repository.addPreference(preference);
       notifyListeners();
     }
   }
 
   void addPreference(RidePreference preference) {
     pastPreference.add(preference);
     notifyListeners();
   }
 
   List<RidePreference> getPastPreferences() {
     return pastPreference.reversed.toList();
   }
 }