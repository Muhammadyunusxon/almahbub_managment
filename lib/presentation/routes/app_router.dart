import 'package:almahbub_managment/presentation/pages/add_screen/add_page.dart';
import 'package:almahbub_managment/presentation/pages/add_screen/add_product_screen.dart';
import 'package:almahbub_managment/presentation/pages/auth/login_page.dart';
import 'package:almahbub_managment/presentation/pages/category/category_products.dart';
import 'package:almahbub_managment/presentation/pages/category/category_screen.dart';
import 'package:almahbub_managment/presentation/pages/favourite/favourite_screen.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/home_page.dart';
import 'package:auto_route/auto_route.dart';
import '../pages/home_screen/location_map.dart';
import '../pages/initial/splash_page.dart';
import '../pages/main/main_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    MaterialRoute(
      path: "/",
      page: SplashPage,
      initial: true,
    ),
    MaterialRoute(
      path: "/login",
      page: LoginPage,
    ),
    MaterialRoute(
      path: "/home",
      page: HomePage,
    ),
    MaterialRoute(
      path: "/location",
      page: YandexLocationMapPage,
    ),
    MaterialRoute(
      path: "/favourite",
      page: FavouritePage,
    ),
    MaterialRoute(
      path: "/add",
      page: AddPage,
    ),
    MaterialRoute(
      path: "/add-product",
      page: AddProductPage,
    ),
    MaterialRoute(
      path: "/category",
      page: CategoryPage,
    ),
    MaterialRoute(
      path: "/category-products",
      page: CategoryProducts,
    ),
    MaterialRoute(
      path: "/main",
      page: MainPage,
    ),
  ],
)
class $AppRouter {}


