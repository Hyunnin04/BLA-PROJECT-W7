import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/providers/ride_prefs_provider.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

void main() {
  // 1. Verify mock repository implementation
  final RidePreferencesRepository mockRepo = MockRidePreferencesRepository();

  // 2. Initialize provider
  final provider = RidesPreferenceProvider(repository: mockRepo);

  try {
    // Verify dummy data existence
    assert(fakeLocations.length >= 4, "Need at least 4 fake locations");

    final cookie = RidePreference(
      departure: fakeLocations[0],
      arrival: fakeLocations[3],
      departureDate: DateTime.now().add(const Duration(days: 1)),
      requestedSeats: 2,
    );

    // Test 1: Initial state
    print(
        "Initial Current Preference: ${provider.currentPreference}"); // Should be null

    // Test 2: Set preference
    provider.setCurrentPreference(cookie);
    print("After Setting: ${provider.currentPreference}");

    // Test 3: Verify repository interaction
    assert(mockRepo.getPastPreferences().contains(cookie),
        "Preference not saved to repository");

    // Test 4: Verify past preferences
    print(
        "Past Preferences Count: ${provider.getPastPreferences().length}"); // Should be 1
  } catch (e) {
    print("Test failed: $e");
  }
}
