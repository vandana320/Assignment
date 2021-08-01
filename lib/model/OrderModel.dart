import 'dart:collection';
import 'package:assignment/model/Order.dart';
import 'package:flutter/material.dart';

class OrderModel extends ChangeNotifier {
  final List<Order> _order = [
  ];

  UnmodifiableListView<Order> get allOrders => UnmodifiableListView(_order);

  void addTodo(Order order) {
    _order.add(order);
    notifyListeners();
  }

  void toggleTodo(Order order) {
    final taskIndex = _order.indexOf(order);
    notifyListeners();
  }

  void deleteTodo(Order order) {
    _order.remove(order);
    notifyListeners();
  }
}
