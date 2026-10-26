import 'package:flutter/material.dart';
class QuantitySelector extends StatefulWidget { 
const QuantitySelector({super.key});
@override 
State<QuantitySelector> 
createState() => _QuantitySelectorState(); }
class _QuantitySelectorState extends State<QuantitySelector> { 
  int quantity = 1;
@override Widget build(BuildContext context) {
   return Container(
   padding: const EdgeInsets.symmetric( 
  horizontal: 12, vertical: 4, ), 
  decoration: BoxDecoration(
   border: Border.all( color: Colors.grey, ),
   borderRadius: BorderRadius.circular(16), ), 
   child: Row( mainAxisSize: MainAxisSize.min,
   children: [ 
  IconButton( onPressed: () { 
  if (quantity > 1) { setState(() { quantity--; }); } },
 icon: const Icon(Icons.remove), ),
      SizedBox(
        width: 28,
        child: Center(
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),

      IconButton(
        onPressed: () {
          setState(() {
            quantity++;
          });
        },
        icon: const Icon(Icons.add),
      ),
    ],
  ),
);
} }