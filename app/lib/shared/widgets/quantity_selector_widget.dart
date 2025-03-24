import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int quantity;
  const QuantitySelector({super.key, this.quantity = 1});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantitySelector = 1;

  void increment() {
    if (quantitySelector >= widget.quantity) {
      return;
    }
    setState(() {
      quantitySelector++;
    });
  }

  void decrement() {
    setState(() {
      if (quantitySelector > 1) {
        quantitySelector--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            color: quantitySelector > 1
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            onPressed: decrement,
          ),
          const SizedBox(width: 8),
          Text(
            '$quantitySelector',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.add),
            color: quantitySelector < widget.quantity
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            onPressed: increment,
          ),
        ],
      ),
    );
  }
}
