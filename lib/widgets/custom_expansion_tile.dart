import 'package:flutter/material.dart';
import 'package:machine_code/model/menu_list_model.dart';
import 'package:machine_code/widgets/counter_button.dart';

class CustomExpansionTile extends StatefulWidget {
  final List<CartItem> list;
  final String name;
  final int listIndex;
  const CustomExpansionTile(
      {super.key,
      required this.list,
      required this.name,
      required this.listIndex});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.name),
      trailing: customTileExpanded
          ? _trailingWidget(const Icon(Icons.keyboard_arrow_down_outlined))
          : _trailingWidget(const Icon(Icons.keyboard_arrow_right)),
      children: [
        SingleChildScrollView(
          child: Column(children:
              // widget.list.map((item) => _customListTile(item)).toList()
              [
            for (int i = 0; i < widget.list.length; i++)
              _customListTile(widget.list[i], i)
          ]),
        )
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => customTileExpanded = expanded);
      },
    );
  }

  SizedBox _trailingWidget(Icon icon) {
    return SizedBox(
      width: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${widget.list.length}',
            style: const TextStyle(fontSize: 14),
          ),
          icon
        ],
      ),
    );
  }

  Widget _badge() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
              color: Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Text(
            'Bestseller',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _customListTile(CartItem data, int lastListIndex) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: const Border(
              bottom: BorderSide(width: .3, color: Colors.black45))),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.name!,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    if (widget.listIndex == 6 && lastListIndex == 0) _badge()
                  ],
                ),
                Text(
                  '\$${data.price!}',
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                )
              ],
            ),
            CounterButton(
              cartItem: data,
              listIndex: widget.listIndex,
            )
          ]),
    );
  }
}
