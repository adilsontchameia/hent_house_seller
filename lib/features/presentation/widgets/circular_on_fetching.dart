import 'widgets.dart';

class CircularProgressOnFecthing extends StatelessWidget {
  const CircularProgressOnFecthing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.brown,
    ));
  }
}
