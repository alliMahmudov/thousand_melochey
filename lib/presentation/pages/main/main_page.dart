
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/main/packages/custom_navbar.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final notifier = ref.read(mainProvider(0).notifier);
    final state = ref.watch(mainProvider(0));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.140.sh),
            child: ProsteIndexedStack(
              children: notifier.list,
              index: state.indexPage,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: const Stack(
        children: [
          //CustomFloatingActionButton(),
          CustomNavBar(),
        ],
      ),
    );
  }
}
