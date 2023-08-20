import 'package:hent_house_seller/core/currency_formart.dart';
import 'package:hent_house_seller/features/presentation/filtered_advertisiment/widgets/filtered_card_content.dart';
import 'package:hent_house_seller/features/presentation/widgets/no_matching_result_found.dart';
import 'package:hent_house_seller/features/presentation/widgets/widgets.dart';

import '../filtered_advertisiment.dart';

class GridViewWithData extends StatelessWidget {
  const GridViewWithData({
    Key? key,
    required this.snapshot,
    required this.query,
    this.topPickedFilter,
    this.categoryFilter,
    this.provinceFilter,
    this.minPriceFilter,
    this.maxPriceFilter,
  }) : super(key: key);

  final QuerySnapshot snapshot;
  final String query;
  final bool? topPickedFilter;
  final String? categoryFilter;
  final String? provinceFilter;
  final int? minPriceFilter;
  final int? maxPriceFilter;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<DocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
      var data = doc.data() as Map<String, dynamic>;
      bool titleMatches =
          data['title'].toString().toLowerCase().contains(query.toLowerCase());

      bool priceAddress = data['address']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
      bool category =
          data['type'].toString().toLowerCase().contains(query.toLowerCase());
      bool province = data['province']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());

      if (query.isEmpty ||
          titleMatches ||
          priceAddress ||
          category ||
          province) {
        if (topPickedFilter != null && data['isPromo'] != topPickedFilter) {
          return false;
        }

        if (categoryFilter != null &&
            !data['type'].toString().toLowerCase().contains(categoryFilter!)) {
          return false;
        }

        if (provinceFilter != null &&
            !data['province']
                .toString()
                .toLowerCase()
                .contains(provinceFilter!)) {
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
                      Hero(
                        tag: 'header_pic',
                        child: CachedNetworkImage(
                          imageUrl: data['image'].first,
                          fit: BoxFit.fill,
                          height: height,
                          width: width,
                          placeholder: (context, str) => Center(
                            child: Image.asset('assets/loading.gif'),
                          ),
                        ),
                      ),
                      Container(
                        height: height,
                        width: width,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BounceInDown(
                              child: Text(
                                data['title'],
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
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
                                  KwanzaFormatter.formatKwanza(double.parse(
                                data['monthlyPrice'].toString(),
                              )),
                              icon: FontAwesomeIcons.moneyBill,
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
