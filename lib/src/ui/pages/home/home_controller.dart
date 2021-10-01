import 'dart:async';
import 'package:flutter/material.dart';
import '../../global_controller/notifications_controller.dart';
import '../../../data/models/dish.dart';
import '../../../data/repositories/websocket_repository.dart';
import '../../../helpers/get.dart';

class HomeController extends ChangeNotifier {
  final NotificationsController notificationsController;
  int _currentPage = 0;

  HomeController(this.notificationsController);

  final _wsRepository = Get.i.find<WebsocketRepository>();

  int get currentPage => _currentPage;

  Map<int, Dish> _favorites = {};
  Map<int, Dish> get favorites => _favorites;

  bool isFavorite(Dish dish) => _favorites.containsKey(dish.id);

  void Function()? onDispose;

  final TabController tabController = TabController(
    length: 4,
    vsync: NavigatorState(),
    initialIndex: 0,
  );

  StreamSubscription? _notificationSubscription;

  List<BottomBarItem> _menuItems = [
    BottomBarItem(
      icon: 'assets/pages/home/home.svg',
      label: 'Inicio',
    ),
    BottomBarItem(
      icon: 'assets/pages/home/favorite.svg',
      label: 'Favoritos',
    ),
    BottomBarItem(
      icon: 'assets/pages/home/bell.svg',
      label: 'Notificaciones',
    ),
    BottomBarItem(
      icon: 'assets/pages/home/avatar.svg',
      label: 'Perfil',
    ),
  ];

  List<BottomBarItem> get menuItems => _menuItems;

  void afterFirstLayour() {
    _wsRepository.connect("");
    _notificationSubscription = this
        .notificationsController
        .onNotificationsChanged
        .listen((notifications) {
      final int count = notifications.length;
      List<BottomBarItem> copy = [..._menuItems];
      copy[2] = copy[2].copyWith(
        badgeCount: count,
      );
      _menuItems = copy;
      notifyListeners();
    });
    this.tabController.addListener(() {
      _currentPage = tabController.index;
      notifyListeners();
    });
  }

  void toggleFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
    } else {
      copy[dish.id] = dish;
    }

    _favorites = copy;
    notifyListeners();
  }

  void deleteFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
      _favorites = copy;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    this._notificationSubscription?.cancel();
    this.tabController.dispose();
    if (this.onDispose != null) {
      this.onDispose!();
    }
    super.dispose();
  }
}

class BottomBarItem {
  final String icon, label;
  final int badgeCount;

  BottomBarItem({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  BottomBarItem copyWith({
    String? icon,
    String? label,
    int? badgeCount,
  }) {
    return BottomBarItem(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
