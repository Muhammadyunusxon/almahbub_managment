// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/foundation.dart' as _i13;
import 'package:flutter/material.dart' as _i12;

import '../../infrastructure/model/category_model.dart' as _i15;
import '../../infrastructure/model/product_model.dart' as _i14;
import '../pages/add_screen/add_page.dart' as _i6;
import '../pages/add_screen/add_product_screen.dart' as _i7;
import '../pages/auth/login_page.dart' as _i2;
import '../pages/category/category_products.dart' as _i9;
import '../pages/category/category_screen.dart' as _i8;
import '../pages/favourite/favourite_screen.dart' as _i5;
import '../pages/home_screen/home_page.dart' as _i3;
import '../pages/home_screen/location_map.dart' as _i4;
import '../pages/initial/splash_page.dart' as _i1;
import '../pages/main/main_page.dart' as _i10;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(key: args.key),
      );
    },
    YandexLocationMapRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.YandexLocationMapPage(),
      );
    },
    FavouriteRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.FavouritePage(),
      );
    },
    AddRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AddPage(),
      );
    },
    AddProductRoute.name: (routeData) {
      final args = routeData.argsAs<AddProductRouteArgs>(
          orElse: () => const AddProductRouteArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.AddProductPage(
          key: args.key,
          product: args.product,
        ),
      );
    },
    CategoryRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.CategoryPage(),
      );
    },
    CategoryProducts.name: (routeData) {
      final args = routeData.argsAs<CategoryProductsArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CategoryProducts(
          key: args.key,
          categoryModel: args.categoryModel,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.MainPage(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i11.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i11.RouteConfig(
          YandexLocationMapRoute.name,
          path: '/location',
        ),
        _i11.RouteConfig(
          FavouriteRoute.name,
          path: '/favourite',
        ),
        _i11.RouteConfig(
          AddRoute.name,
          path: '/add',
        ),
        _i11.RouteConfig(
          AddProductRoute.name,
          path: '/add-product',
        ),
        _i11.RouteConfig(
          CategoryRoute.name,
          path: '/category',
        ),
        _i11.RouteConfig(
          CategoryProducts.name,
          path: '/category-products',
        ),
        _i11.RouteConfig(
          MainRoute.name,
          path: '/main',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i11.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i13.Key? key})
      : super(
          HomeRoute.name,
          path: '/home',
          args: HomeRouteArgs(key: key),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.YandexLocationMapPage]
class YandexLocationMapRoute extends _i11.PageRouteInfo<void> {
  const YandexLocationMapRoute()
      : super(
          YandexLocationMapRoute.name,
          path: '/location',
        );

  static const String name = 'YandexLocationMapRoute';
}

/// generated route for
/// [_i5.FavouritePage]
class FavouriteRoute extends _i11.PageRouteInfo<void> {
  const FavouriteRoute()
      : super(
          FavouriteRoute.name,
          path: '/favourite',
        );

  static const String name = 'FavouriteRoute';
}

/// generated route for
/// [_i6.AddPage]
class AddRoute extends _i11.PageRouteInfo<void> {
  const AddRoute()
      : super(
          AddRoute.name,
          path: '/add',
        );

  static const String name = 'AddRoute';
}

/// generated route for
/// [_i7.AddProductPage]
class AddProductRoute extends _i11.PageRouteInfo<AddProductRouteArgs> {
  AddProductRoute({
    _i13.Key? key,
    _i14.ProductModel? product,
  }) : super(
          AddProductRoute.name,
          path: '/add-product',
          args: AddProductRouteArgs(
            key: key,
            product: product,
          ),
        );

  static const String name = 'AddProductRoute';
}

class AddProductRouteArgs {
  const AddProductRouteArgs({
    this.key,
    this.product,
  });

  final _i13.Key? key;

  final _i14.ProductModel? product;

  @override
  String toString() {
    return 'AddProductRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.CategoryPage]
class CategoryRoute extends _i11.PageRouteInfo<void> {
  const CategoryRoute()
      : super(
          CategoryRoute.name,
          path: '/category',
        );

  static const String name = 'CategoryRoute';
}

/// generated route for
/// [_i9.CategoryProducts]
class CategoryProducts extends _i11.PageRouteInfo<CategoryProductsArgs> {
  CategoryProducts({
    _i13.Key? key,
    required _i15.CategoryModel categoryModel,
  }) : super(
          CategoryProducts.name,
          path: '/category-products',
          args: CategoryProductsArgs(
            key: key,
            categoryModel: categoryModel,
          ),
        );

  static const String name = 'CategoryProducts';
}

class CategoryProductsArgs {
  const CategoryProductsArgs({
    this.key,
    required this.categoryModel,
  });

  final _i13.Key? key;

  final _i15.CategoryModel categoryModel;

  @override
  String toString() {
    return 'CategoryProductsArgs{key: $key, categoryModel: $categoryModel}';
  }
}

/// generated route for
/// [_i10.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/main',
        );

  static const String name = 'MainRoute';
}
