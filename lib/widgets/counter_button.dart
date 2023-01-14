import 'package:flutter/material.dart';
import 'package:machine_code/model/menu_list_model.dart';
import 'package:machine_code/provider/order_provider.dart';
import 'package:machine_code/widgets/custom_icon_button.dart';
import 'package:machine_code/widgets/custom_outline_button.dart';
import 'package:provider/provider.dart';

class CounterButton extends StatelessWidget {
  final CartItem cartItem;
  final int listIndex;
  const CounterButton(
      {super.key, required this.cartItem, required this.listIndex});

  @override
  Widget build(BuildContext context) {
    final OrderProvider priceProvider =
        Provider.of<OrderProvider>(context, listen: false);

    final OrderProvider priceProviderListener =
        Provider.of<OrderProvider>(context);

    final count = priceProviderListener.getQuantity(cartItem, listIndex);

    return count == 0
        ? CustomOutlineButton(
            onPressed: () {
              priceProvider.increment(cartItem, listIndex);
            },
            text: 'Add',
          )
        : Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            height: 40,
            child: Row(
              children: [
                CustomIconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    priceProvider.decrement(cartItem, listIndex);
                  },
                ),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                CustomIconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => priceProvider.increment(cartItem, listIndex),
                ),
              ],
            ),
          );
  }
}
