import 'widgets.dart';

class ErrorFecthingData extends StatelessWidget {
  const ErrorFecthingData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.brown.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElasticInLeft(
                delay: const Duration(milliseconds: 200),
                child: const Text(
                  'Ocorreu um erro ao carregar as informações, por favor consulte o suporte técnico.',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
