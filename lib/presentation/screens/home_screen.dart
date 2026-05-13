import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/menu/menu_bloc.dart';
import '../../blocs/menu/menu_event.dart';
import '../../blocs/menu/menu_state.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/menu_category.dart';
import '../widgets/cart_badge.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/side_drawer.dart';
import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().add(const MenuFetchRequested());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const SideDrawer(),
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuLoaded) {
            _tabController?.dispose();
            _tabController = TabController(
              length: state.categories.length,
              vsync: this,
            );
            setState(() {});
          }
        },
        builder: (context, state) => switch (state) {
          MenuInitial() || MenuLoading() => _buildLoading(),
          MenuLoaded(:final categories) => _buildContent(categories),
          MenuError(:final message) => _buildError(message),
        },
      ),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            return CartBadge(
              itemCount: cartState.totalQuantity,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _buildContent(List<MenuCategory> categories) {
    if (_tabController == null) return _buildLoading();

    return Column(
      children: [
        _buildTabBar(categories),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: categories.map((cat) => _buildDishList(cat)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(List<MenuCategory> categories) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.tabBorderColor, width: 1),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorWeight: 2.5,
        tabAlignment: TabAlignment.start,
        tabs: categories.map((c) => Tab(text: c.name)).toList(),
      ),
    );
  }

  Widget _buildDishList(MenuCategory category) {
    if (category.dishes.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noItemsInCategory,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: category.dishes.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final dish = category.dishes[index];
            return MenuItemCard(
              dish: dish,
              quantity: cartState.quantityOf(dish.id),
              onIncrement: () => context.read<CartBloc>().add(
                    CartItemAdded(dish: dish),
                  ),
              onDecrement: () => context.read<CartBloc>().add(
                    CartItemRemoved(dishId: dish.id),
                  ),
            );
          },
        );
      },
    );
  }


  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            AppStrings.somethingWentWrong,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(message, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () =>
                context.read<MenuBloc>().add(const MenuFetchRequested()),
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }


}
