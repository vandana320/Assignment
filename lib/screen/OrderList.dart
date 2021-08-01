import 'package:assignment/model/Order.dart';
import 'package:assignment/util/CommonUtil.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final Order order;

  OrderList({required this.order});

  @override
  Widget build(BuildContext context) {
    Widget nameWidget = Text("${order.name}",
        style: TextStyle(
            fontFamily: CommonUtil.FONT_FAMILY,
            fontWeight: FontWeight.bold,
            fontSize: 16));

    Widget orderTypeWidget = Text("${order.orderType}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));

    Widget exchangeWidget = Text("exchange: ${order.exchange}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));

    Widget quantityWidget = Text("quantity: ${order.quantity}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));

    Widget priceWidget = Text("Rs. ${order.price}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameWidget,
                  SizedBox(height: 10),
                  quantityWidget,
                  SizedBox(height: 5),
                  priceWidget
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  orderTypeWidget,
                  SizedBox(height: 5),
                  exchangeWidget,
                ],
              ),
            ],
          ),
        ),
      ),
    );;
  }
}