import 'package:busque_receitas/app/modules/add_ingredients/add_pantry_bindings.dart';
import 'package:busque_receitas/app/modules/add_ingredients/add_pantry_page.dart';
import 'package:busque_receitas/app/modules/auth/register/register_bindings.dart';
import 'package:busque_receitas/app/modules/auth/login/login_bindings.dart';
import 'package:busque_receitas/app/modules/auth/register/register_page.dart';
import 'package:busque_receitas/app/modules/auth/login/login_page.dart';
import 'package:busque_receitas/app/modules/do_later/do_later_page.dart';
import 'package:busque_receitas/app/modules/do_later/do_later_bindings.dart';
import 'package:busque_receitas/app/modules/pageView/layout/layout_bindings.dart';
import 'package:busque_receitas/app/modules/pageView/layout/layout_page.dart';
import 'package:busque_receitas/app/modules/recipe/recipe_page.dart';
import 'package:busque_receitas/app/modules/shopping_list/add_shopping_list/add_shopping_list_page.dart';
import 'package:busque_receitas/app/modules/shopping_list/add_shopping_list/add_shopping_list_bindings.dart';
import 'package:busque_receitas/app/modules/shopping_list/shopping_list/shopping_list_page.dart';
import 'package:busque_receitas/app/modules/shopping_list/shopping_list/shopping_list_bindings.dart';
import 'package:busque_receitas/app/modules/splash/splash_bindings.dart';
import 'package:busque_receitas/app/modules/recipe/recipe_bindings.dart';
import 'package:busque_receitas/app/modules/profile/profile_page.dart';
import 'package:busque_receitas/app/modules/profile/profile_bindings.dart';
import 'package:busque_receitas/app/modules/favorites/favorites_bindings.dart';
import 'package:busque_receitas/app/modules/favorites/favorites_page.dart';
import 'package:busque_receitas/app/modules/splash/splash_page.dart';
import 'package:busque_receitas/app/modules/create_recipe/create_recipe_page.dart';
import 'package:busque_receitas/app/modules/create_recipe/create_recipe_bindings.dart';
import 'package:busque_receitas/app/modules/validation_page_view/recipe_validation/recipe_validation_page.dart';
import 'package:busque_receitas/app/modules/validation_page_view/recipe_validation/recipe_validation_bindings.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_layout/validation_layout_bindings.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_layout/validation_layout_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: '/',
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: '/layout',
      page: () => const LayoutPage(),
      binding: LayoutBindings(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
    ),
    GetPage(
      name: '/add_pantry',
      page: () => const AddPantryPage(),
      binding: AddPantryBindings(),
    ),
    GetPage(
      name: '/recipe',
      page: () => const RecipePage(),
      binding: RecipeBindings(),
    ),
    GetPage(
      name: '/favorites',
      page: () => const FavoritesPage(),
      binding: FavoritesBindings(),
    ),
    GetPage(
      name: '/shopping_list',
      page: () => const ShoppingListPage(),
      binding: ShoppingListBindings(),
    ),
    GetPage(
      name: '/do_later',
      page: () => const DoLaterPage(),
      binding: DoLaterBindings(),
    ),
    GetPage(
      name: '/add_shopping',
      page: () => const AddShoppingListPage(),
      binding: AddShoppingListBindings(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: '/create_recipe',
      page: () => const CreateRecipePage(),
      binding: CreateRecipeBindings(),
    ),
    GetPage(
      name: '/validation_layout',
      page: () => const ValidationLayoutPage(),
      binding: ValidationLayoutBindings(),
    ),
    GetPage(
      name: '/recipe_validation',
      page: () => const RecipeValidationPage(),
      binding: RecipeValidationBindings(),
    )
  ];
}
