import 'package:get/get.dart';
import '../models/pet.dart';
import '../services/api_service.dart';
import '../controllers/auth_controller.dart';

class PetController extends GetxController {
  var isLoading = false.obs;
  var pets = <Pet>[].obs;

  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    loadPets();
  }

  Future<void> loadPets() async {
    try {
      isLoading.value = true;
      final token = _authController.token;

      if (token != null) {
        final fetchedPets = await ApiService.getPets(token);
        pets.value = fetchedPets;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPet(Pet pet) async {
    try {
      isLoading.value = true;
      final token = _authController.token;

      if (token != null) {
        final newPet = await ApiService.addPet(token, pet);
        pets.add(newPet);

        Get.snackbar('Success', 'Pet added successfully');
        Get.back(); // Return to pets list
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePet(String? petId) async {
    if (petId == null) return;

    try {
      isLoading.value = true;
      final token = _authController.token;

      if (token != null) {
        await ApiService.deletePet(token, petId);
        pets.removeWhere((pet) => pet.id == petId);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPets() async {
    await loadPets();
  }
}
