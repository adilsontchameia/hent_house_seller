import 'package:hent_house_seller/core/currency_formart.dart';
import 'package:hent_house_seller/features/presentation/filtered_advertisiment/widgets/filtered_card_content.dart';
import 'package:hent_house_seller/features/presentation/widgets/no_matching_result_found.dart';
import 'package:hent_house_seller/features/presentation/widgets/widgets.dart';

import '../filtered_advertisiment.dart';

class FilteredAdvertisiment extends StatelessWidget {
  const FilteredAdvertisiment({
    Key? key,
    required this.snapshot,
    required this.query,
    this.topPickedFilter,
    this.categoryFilter,
    this.minPriceFilter,
    this.maxPriceFilter,
    this.sortByTitleAZ,
  }) : super(key: key);

  final QuerySnapshot snapshot;
  final String query;
  final bool? topPickedFilter;
  final String? categoryFilter;
  final int? minPriceFilter;
  final int? maxPriceFilter;
  final bool? sortByTitleAZ;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<DocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
      var data = doc.data() as Map<String, dynamic>;
      bool titleMatches =
          data['title'].toString().toLowerCase().contains(query.toLowerCase());
      bool provinceMatches = data['province']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
      bool priceAddress = data['address']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());

      if (query.isEmpty || titleMatches || provinceMatches || priceAddress) {
        // Apply the filters
        if (topPickedFilter != null && data['isTopPicked'] != topPickedFilter) {
          return false;
        }

        if (categoryFilter != null &&
            !data['category']
                .toString()
                .toLowerCase()
                .contains(categoryFilter!)) {
          return false;
        }

        if (minPriceFilter != null &&
            (data['monthlyPrice'] as int) < minPriceFilter!) {
          return false;
        }

        if (maxPriceFilter != null &&
            (data['monthlyPrice'] as int) > maxPriceFilter!) {
          return false;
        }

        return true;
      }

      return false;
    }).toList();

    if (sortByTitleAZ == true) {
      filteredDocs.sort((a, b) => (a.data() as Map<String, dynamic>)['title']
          .compareTo((b.data() as Map<String, dynamic>)['title']));
    }

    if (filteredDocs.isEmpty) {
      return const NoResultsFoundWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anúncios Listados: ${filteredDocs.length}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            letterSpacing: 2,
            color: Colors.brown,
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: AlignedGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              var data = filteredDocs[index].data() as Map<String, dynamic>;

              return SizedBox(
                height: height * 0.30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: data['image'].first,
                        fit: BoxFit.fill,
                        height: height,
                        width: width,
                        placeholder: (context, str) => Center(
                          child: Image.asset('assets/loading.gif'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                width: width,
                                color: Colors.black.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data['title'],
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          TopPickedCardContent(
                                            content: data['province'],
                                            icon: FontAwesomeIcons.locationPin,
                                          ),
                                          TopPickedCardContent(
                                            content: data['address'],
                                            icon: FontAwesomeIcons.mapLocation,
                                          ),
                                          TopPickedCardContent(
                                            content:
                                                KwanzaFormatter.formatKwanza(
                                                    double.parse(
                                              data['monthlyPrice'].toString(),
                                            )),
                                            icon: FontAwesomeIcons.moneyBill,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
