import 'package:assignment/model/Order.dart';
import 'package:assignment/model/OrderModel.dart';
import 'package:assignment/screen/OrderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Container(
        child: Consumer<OrderModel>(
            builder: (context, todos, child) => ListView(
              children: getChildren(todos.allOrders),
            )
        ),
      ) ,
    );
  }

  List<Widget> getChildren(List<Order>order) {
    return order.map((todo) => OrderList(order: todo)).toList();
  }
}