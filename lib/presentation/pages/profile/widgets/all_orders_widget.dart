import 'package:thousand_melochey/core/imports/imports.dart';

@RoutePage()
class AllOrdersPage extends ConsumerStatefulWidget {
  const AllOrdersPage({super.key});

  @override
  ConsumerState<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends ConsumerState<AllOrdersPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(cartProvider.notifier);
      notifier.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: CustomScrollView(
        slivers: [
          state.isOrdersLoading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverList.builder(
                  itemBuilder: (context, index) {
                    final product = state.getOrders?.cartProducts?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          leading: Container(
                            height: 50,
                            width: 50,
                            child: Image.network(product?.product?.image ??
                                "https://t4.ftcdn.net/jpg/03/16/15/47/360_F_316154790_pnHGQkERUumMbzAjkgQuRvDgzjAHkFaQ.jpg"),
                          ),
                          title: Text(product?.product?.name ?? ""),
                          //  subtitle: Text("Bicycle lock * 2pcs."),
                          trailing: Text("\$${product?.product?.price}" ?? ""),
                          //subtitle: Text("PRice"),
                          tileColor: Colors.white,
                        ),
                      ),
                    );
                  },
                  itemCount: state.getOrders?.cartProducts?.length,
                )
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.primaryColor,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Date: 2024-05-17", style: TextStyle(color: AppColors.white, fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total price: \$${state.getOrders?.totalPrice}", style: TextStyle(color: AppColors.white, fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}
