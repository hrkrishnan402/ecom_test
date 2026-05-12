import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/counter_button.dart';
import '../widgets/veg_indicator.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orderSummary),
        titleSpacing: 0,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text(AppStrings.cartEmpty));
          }

          final items = state.nonEmptyItems;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHeader(items.length, state.totalQuantity),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              return _buildCartItem(context, items[index]);
                            },
                          ),
                          _buildTotalSection(state.totalPrice, items.isNotEmpty ? items.first.dish.currency : 'INR'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildPlaceOrderButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(int dishCount, int itemCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        color: AppTheme.counterBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Text(
        '$dishCount ${AppStrings.dishes} - $itemCount ${AppStrings.items}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final dish = item.dish;
    final unitPrice = double.tryParse(dish.price) ?? 0.0;
    final itemTotal = unitPrice * item.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: VegIndicator(isVeg: dish.isVeg),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.priceLabel(dish.currency, dish.price),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${dish.calories} ${AppStrings.calories}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  CounterButton(
                    quantity: item.quantity,
                    onIncrement: () => context.read<CartBloc>().add(CartItemAdded(dish: dish)),
                    onDecrement: () => context.read<CartBloc>().add(CartItemRemoved(dishId: dish.id)),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 80,
                    child: Text(
                      AppStrings.priceLabel(dish.currency, itemTotal.toStringAsFixed(2)),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(double totalPrice, String currency) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.totalAmount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37474F),
            ),
          ),
          Text(
            AppStrings.priceLabel(currency, totalPrice.toStringAsFixed(2)),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => _handlePlaceOrder(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.counterBackground,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        child: const Text(
          AppStrings.placeOrder,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void _handlePlaceOrder(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            SizedBox(height: 16),
            Text(
              AppStrings.orderPlaced,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    // Wait for a moment, then clear cart and redirect
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.read<CartBloc>().add(const CartClearRequested());
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }
}
