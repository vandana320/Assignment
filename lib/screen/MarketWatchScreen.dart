import 'package:assignment/model/MarketDetails.dart';
import 'package:assignment/model/Order.dart';
import 'package:assignment/model/OrderModel.dart';
import 'package:assignment/ui/BaseState.dart';
import 'package:assignment/util/CommonUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketWatchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MarketWatchScreen();
  }
}

class _MarketWatchScreen extends BaseState<MarketWatchScreen>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _quantityController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  MarketDetails _details = MarketDetails();
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees',
          style: TextStyle(
            fontFamily: CommonUtil.FONT_FAMILY,
            fontWeight: FontWeight.bold,
          ),
        ),
        brightness: Brightness.dark,
      ),
      backgroundColor: Color(0xFFF1F9FC),
      body: SafeArea(
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
      return ListView.builder(
          controller: _controller,
          itemBuilder: _itemBuilder,
          itemCount: _details.stocks.length,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics());
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = _details.stocks[index];

    Widget nameWidget = Text("${item["name"]}",
        style: TextStyle(
            fontFamily: CommonUtil.FONT_FAMILY,
            fontWeight: FontWeight.bold,
            fontSize: 16));

    Widget exchangeWidget = Text("Exchange: ${item["exchange"]}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));

    Widget priceWidget = Text("Rs. ${item["current_price"]}",
        style: TextStyle(
            color: Color(0xFF7A7B7C),
            fontFamily: CommonUtil.FONT_FAMILY,
            fontSize: 15));
    Widget _buyBtnWidget = FlatButton(
      onPressed: () {
        _showDialog("Buy", item);
      },
      child: Text('Buy',
          style: TextStyle(
              fontFamily: CommonUtil.FONT_FAMILY,
              color: Colors.white)),
      color: Theme.of(context).accentColor,
    );

    Widget _sellBtnWidget = FlatButton(
      onPressed: () {
        _showDialog("Sell", item);
      },
      child: Text('Sell',
          style: TextStyle(
              fontFamily: CommonUtil.FONT_FAMILY,
              color: Colors.white)),
      color: Theme.of(context).accentColor,
    );

    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameWidget,
                  SizedBox(height: 15.0),
                  exchangeWidget,
                  SizedBox(height: 10.0),
                  priceWidget
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buyBtnWidget,
                SizedBox(width: 8.0),
                _sellBtnWidget
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, item) {
    _priceController.text = item["current_price"].toString();
    Widget quantityWidget = TextFormField(
      textCapitalization: TextCapitalization.values[0],
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
      controller: _quantityController,
      onSaved: (String? value) {
        value = value!.trim();
      },
      validator: (_) {
        if (_!.trim().isEmpty) {
          return "Enter quantity";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        labelText: 'Quantity',
        labelStyle: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
        border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            )),
      ),
    );
    Widget priceWidget = TextFormField(
      textCapitalization: TextCapitalization.values[0],
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
      controller: _priceController,
      onSaved: (String? value) {
        value = value!.trim();
      },
      validator: (_) {
        if (_!.trim().isEmpty) {
          return "Enter price";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        labelText: 'Price',
        labelStyle: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
        border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            )),
      ),
    );
    Widget submitWidget = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:
        LinearGradient(colors: [Color(0xff1B1DC7), Color(0xff484AD2)]),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        child: Text(
          "Confirm Order",
          style: TextStyle(
              fontFamily: CommonUtil.FONT_FAMILY,
              color: Colors.white,
              fontSize: 18),
        ),
        onPressed: () {
          _confirmOrder(item, title);
        },
      ),
    );
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState){
          return Scaffold(
            appBar: AppBar(
                title: Text(title, style: TextStyle(color: Colors.black)),
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.black)),
                centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          quantityWidget,
                          SizedBox(
                              height: 20.0
                          ),
                          priceWidget
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: submitWidget,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _confirmOrder(item, String orderType) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Order order = Order(item["name"], _priceController.text,
          _quantityController.text, orderType, item["exchange"]);
      Provider.of<OrderModel>(context, listen: false).addTodo(order);
      Navigator.pop(context);
    }
  }
}