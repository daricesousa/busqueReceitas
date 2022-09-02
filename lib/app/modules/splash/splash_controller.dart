import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  List<GroupIngredientsModel> listGroups = [];
  final listPantry = <int>[].obs;
  final _repositoryIngredient = IngredientRepository();
  final _storage = GetStorage();
  final _user = Rxn<UserModel>();

  UserModel? get user => _user.value;


  set user(UserModel? user) => _user.value = user;
  

  @override
  void onReady() async {
    _loadUser();
    _loadPantry();
    await getIngredients();
    Get.offNamedUntil('/layout', (route) => false);
    super.onReady();
  }

  Future<void> getIngredients() async {
    try {
      await Future.wait([_getIngredients(), _getGroupsIngredients()]);
    } catch (e) {
      print("Erro ao carregar ingredientes da internet");
      await Future.wait([_loadIngredients(), _loadGroups()]);
    }
  }

  Future<void> _getGroupsIngredients() async {
    listGroups.assignAll(await _repositoryIngredient.getGroups());
  }

  Future<void> _getIngredients() async {
    listIngredients.assignAll(await _repositoryIngredient.getIngredients());
  }

  void _loadPantry() {
    try {
      final data = (_storage.read('pantry') ?? []).cast<int>();
      listPantry.assignAll(data as List<int>);
    } catch (e) {
      print(e);
      print("Erro ao carregar despensa");
    }
  }

  Future<void> _loadIngredients() async {
    final data = await _storage.read('ingredients') ?? [];
    List<IngredientModel> ingredients = [];
    ingredients = data.map<IngredientModel>((i) {
      return IngredientModel.fromMap(i);
    }).toList();
    listIngredients.assignAll(ingredients);
  }

  void _loadUser() {
    final user = _storage.read('user');
    if (user!= null) {
      this.user = UserModel.fromMap(_storage.read('user'));
    }
  }

  Future<void> _loadGroups() async {
    final data = await _storage.read('groups') ?? [];
    List<GroupIngredientsModel> groups = [];
    groups = data.map<GroupIngredientsModel>((g) {
      return GroupIngredientsModel.fromMap(g);
    }).toList();
    listGroups.assignAll(groups);
  }

  void changeIngredient({required int ingredientId}) {
    final have = havePatry(ingredientId);
    if (have) {
      listPantry.removeWhere((i) => i == ingredientId);
    } else {
      listPantry.add(ingredientId);
    }
    _savePantry();
  }

  void _savePantry() {
    _storage.write('pantry', listPantry);
  }

  bool havePatry(int ingredientId) {
    final findIndex = listPantry.indexWhere((i) => i == ingredientId);
    if (findIndex < 0) {
      return false;
    } else {
      return true;
    }
  }
}
