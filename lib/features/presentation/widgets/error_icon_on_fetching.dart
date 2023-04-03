import 'widgets.dart';

class ErrorIconOnFetching extends StatelessWidget {
  const ErrorIconOnFetching({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        FontAwesomeIcons.triangleExclamation,
        color: Colors.red,
      ),
    );
  }
}
