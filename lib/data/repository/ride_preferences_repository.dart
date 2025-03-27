import '../../model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  // List<RidePreference> getPastPreferences();
    Future<List<RidePreference>> getPastPreferences();

  // void addPreference(RidePreference preference);
  Future<void> addPreference(RidePreference preference);
}
