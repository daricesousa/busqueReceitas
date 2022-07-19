import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:get/get.dart';

class DespensaController extends GetxController {
  final List<GroupIngredientsModel> listGroupsIngredients = [];
  final List<IngredientModel> listIngredients = [
     IngredientModel(id: 1, name: 'Leite desnatado', groupId: 1, associateId: []),
     IngredientModel(id: 3, name: 'Farinha de trigo', groupId: 3, associateId: [])
  ];

  @override
  void onInit() {
    getGroupsIngredients();
    getIngredients();
    super.onInit();
  }

  void getGroupsIngredients() {
    GroupIngredientsModel group =
        GroupIngredientsModel(id: 1, name: 'Lacticínios',);
    listGroupsIngredients.add(group);
    group = GroupIngredientsModel(id: 2, name: 'Frutas, verduras e legumes');
    listGroupsIngredients.add(group);
    group = GroupIngredientsModel(id: 3, name: 'Massas');
    listGroupsIngredients.add(group);



  }

  void getIngredients() {
    IngredientModel ingredient = IngredientModel(id: 1, name: 'Leite desnatado', groupId: 1, associateId: []);
    listIngredients.add(ingredient);
    ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
     ingredient = IngredientModel(id: 2, name: 'Leite', groupId: 1, associateId: [1]);
    listIngredients.add(ingredient);
    ingredient = IngredientModel(id: 3, name: 'Farinha de trigo', groupId: 3, associateId: []);
     listIngredients.add(ingredient);
    agroupIngredients();
  }

  void agroupIngredients(){
    listIngredients.forEach((ingrediente) {
      final groupId = ingrediente.groupId;
      final group = listGroupsIngredients.firstWhere((GroupIngredientsModel group) => group.id== groupId);
      group.listIngredients.add(ingrediente);
    });
  }

}
