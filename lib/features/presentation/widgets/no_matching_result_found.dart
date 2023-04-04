import 'widgets.dart';

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      child: Column(
        children: [
          Image.asset(
            'assets/not_found.jpg',
            height: 120.0,
            width: width,
            fit: BoxFit.cover,
          ),
          const Text(
            'Sem Anúncios Correspondente.',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
