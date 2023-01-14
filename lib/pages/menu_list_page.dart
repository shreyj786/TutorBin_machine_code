import 'package:flutter/material.dart';
import 'package:machine_code/model/menu_list_model.dart';
import 'package:machine_code/provider/order_provider.dart';

import 'package:machine_code/widgets/custom_button.dart';
import 'package:machine_code/widgets/custom_expansion_tile.dart';
import 'package:provider/provider.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  late OrderProvider priceProviderListener =
      Provider.of<OrderProvider>(context);

  late OrderProvider priceProvider =
      Provider.of<OrderProvider>(context, listen: false);

  late final Future<MenuListModel> fetchList = priceProvider.fetchList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TutorBin Machine Code')),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder<MenuListModel>(
              future: fetchList,
              builder: (BuildContext context,
                  AsyncSnapshot<MenuListModel> snapshot) {
                if (snapshot.hasData) {
                  return _mainListWidget();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
        _placeOrderWidget()
      ]),
    );
  }

  Widget _mainListWidget() {
    return Column(children: [
      for (int i = 0; i < priceProvider.menuListModel!.catData!.length; i++)
        if (i != 6)
          CustomExpansionTile(
            list: priceProvider.menuListModel!.catData![i],
            name: 'List ${i + 1}',
            listIndex: i,
          )
        else
          CustomExpansionTile(
            list: priceProvider.menuListModel!.catData![i],
            name: 'Popular Item',
            listIndex: i,
          )
    ]);
  }

  Widget _placeOrderWidget() {
    final price = priceProviderListener.totalPrice;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: CustomButton(
                onPressed: () async {
                  await priceProvider.placeOrder();
                  debugPrint('is it working');
                },
                text: 'Place Order',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Text('\$$price'),
          )
        ],
      ),
    );
  }
}
