import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/currency_formart.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/presentation/filtered_advertisiment/widgets/filtered_card_content.dart';
import 'package:hent_house_seller/features/presentation/home_screen/widgets/search_text_field.dart';
import 'package:hent_house_seller/features/presentation/providers/advertisement_provider.dart';
import 'package:hent_house_seller/features/presentation/sale_detail/sale_detail_screen.dart';
import 'package:hent_house_seller/features/presentation/widgets/circular_on_fetching.dart';
import 'package:hent_house_seller/features/presentation/widgets/error_icon_on_fetching.dart';
import 'package:hent_house_seller/features/presentation/widgets/no_matching_result_found.dart';

import '../filtered_advertisiment.dart';

class FilteredAdvertisimentCard extends StatefulWidget {
  FilteredAdvertisimentCard({
    Key? key,
  }) : super(key: key);

  final AdvertisementModel advertisement = AdvertisementModel();

  @override
  State<FilteredAdvertisimentCard> createState() =>
      _FilteredAdvertisimentCardState();
}

class _FilteredAdvertisimentCardState extends State<FilteredAdvertisimentCard> {
  final TextEditingController _searchController = TextEditingController();
  final HomeAdsServiceProvider advertisementManager = HomeAdsServiceProvider();
  String query = '';
  bool? topPickedFilter;
  String? categoryFilter;

  String? provinceFilter;
  double? minPriceFilter;
  double? maxPriceFilter;
  late bool isVisible;
  late bool isButtonSelected;
  final double minPrice = 5000.0;
  final double maxPrice = 500000.0;
  final double priceIncrement = 1000.0;
  List<bool> buttonSelectedStates = [true, false, false, false, false];
  /*
  List<String> provincesAvailable = [
    'Bengo',
    'Benguela',
    'Bié',
    'Cabinda',
    'Cuando Cubango',
    'Cuanza Norte',
    'Cuanza Sul',
    'Cunene',
    'Huambo',
    'Huíla',
    'Luanda',
    'Lunda Norte',
    'Lunda Sul',
    'Malanje',
    'Moxico',
    'Namibe',
    'Uíge',
    'Zaire',
  ];
  */
  List<String> provincesAvailable = [
    'Todas Provincias', // Add "Todas Provincias" as the first element
    'Cuando Cubango',
    'Huíla',
    'Bié',
  ];

  int get divisions {
    return ((maxPrice - minPrice) / priceIncrement).ceil();
  }

  @override
  void initState() {
    isVisible = false;
    isButtonSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SearchField(
          controller: _searchController,
          label: 'Pesquise aqui...',
          icon: FontAwesomeIcons.magnifyingGlass,
          onChanged: (value) {
            query = value;
            setState(() {
              if (value.trim().isNotEmpty) {
                isVisible = true;
              } else {
                isVisible = false;
              }
            });
          },
          isVisible: isVisible,
        ),
        ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.brown,
            iconColor: Colors.brown,
            leading: const Icon(FontAwesomeIcons.filter, color: Colors.brown),
            title: const Text('Por Categorias',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
            children: [
              Wrap(
                spacing: 5.0,
                children: [
                  _buildFilterButton(
                    buttonText: 'Todos',
                    onPressed: () {
                      setState(() {
                        topPickedFilter = null;
                        categoryFilter = null;
                        minPriceFilter = null;
                        maxPriceFilter = null;
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[0],
                    index: 0,
                  ),
                  _buildFilterButton(
                    buttonText: 'Promoções',
                    onPressed: () {
                      setState(() {
                        topPickedFilter = true;

                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[1],
                    index: 1,
                  ),
                  _buildFilterButton(
                    buttonText: 'Apartamentos',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'apartamento';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[2],
                    index: 2,
                  ),
                  _buildFilterButton(
                    buttonText: 'Casas',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'casa';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[3],
                    index: 3,
                  ),
                  _buildFilterButton(
                    buttonText: 'Quartos',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'quartos';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[4],
                    index: 4,
                  ),
                ],
              ),
            ]),
        ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.brown,
            iconColor: Colors.brown,
            leading: const Icon(FontAwesomeIcons.filterCircleDollar,
                color: Colors.brown),
            title: const Text('Por Preços',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
            children: [
              RangeSlider(
                activeColor: Colors.brown,
                inactiveColor: Colors.grey,
                values: RangeValues(minPriceFilter?.toDouble() ?? minPrice,
                    maxPriceFilter?.toDouble() ?? maxPrice),
                min: minPrice,
                max: maxPrice,
                divisions: divisions,
                labels: RangeLabels(
                  KwanzaFormatter.formatKwanza(double.parse(
                    '${minPriceFilter ?? 5000}',
                  )),
                  KwanzaFormatter.formatKwanza(double.parse(
                    '${maxPriceFilter ?? 500000}',
                  )),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    minPriceFilter = values.start.round().toDouble();
                    maxPriceFilter = values.end.round().toDouble();
                  });
                },
              ),
            ]),
        StreamBuilder<List<AdvertisementModel>>(
          stream: advertisementManager.getAllAds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressOnFecthing();
            } else if (snapshot.hasError) {
              return const ErrorIconOnFetching();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              if (query.isEmpty) {
                return const NoResultsFoundWidget();
              } else {
                return const NoResultsFoundWidget();
              }
            } else {
              List<AdvertisementModel> filteredAds =
                  snapshot.data!.where((ads) {
                bool titleMatches = ads.title!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());

                bool priceAddress = ads.address!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());
                bool category = ads.type!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());
                bool province = ads.province!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());

                if (query.isEmpty ||
                    titleMatches ||
                    priceAddress ||
                    category ||
                    province) {
                  if (topPickedFilter != null &&
                      ads.isPromo != topPickedFilter) {
                    return false;
                  }

                  if (categoryFilter != null &&
                      !ads.type
                          .toString()
                          .toLowerCase()
                          .contains(categoryFilter!)) {
                    return false;
                  }

                  if (provinceFilter != null &&
                      !ads.province
                          .toString()
                          .toLowerCase()
                          .contains(provinceFilter!)) {
                    return false;
                  }

                  if (minPriceFilter != null &&
                      (ads.monthlyPrice as double) < minPriceFilter!) {
                    return false;
                  }

                  if (maxPriceFilter != null &&
                      (ads.monthlyPrice as double) > maxPriceFilter!) {
                    return false;
                  }

                  return true;
                }

                return false;
              }).toList();

              if (filteredAds.isEmpty) {
                return const NoResultsFoundWidget();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anúncios Listados: ${filteredAds.length}',
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
                      itemCount: filteredAds.length,
                      itemBuilder: (context, index) {
                        var data = filteredAds[index].toJson();
                        AdvertisementModel advertisement = filteredAds[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            SaleDetailsScreen.routeName,
                            arguments: advertisement,
                          ),
                          child: SizedBox(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BounceInDown(
                                          child: Text(
                                            filteredAds[index].title!,
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
                                          content: filteredAds[index].province!,
                                          icon: FontAwesomeIcons.locationPin,
                                        ),
                                        TopPickedCardContent(
                                          content: filteredAds[index].address!,
                                          icon: FontAwesomeIcons.mapLocation,
                                        ),
                                        TopPickedCardContent(
                                          content: KwanzaFormatter.formatKwanza(
                                              double.parse(
                                            filteredAds[index]
                                                .monthlyPrice
                                                .toString(),
                                          )),
                                          icon: FontAwesomeIcons.moneyBill,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildFilterButton({
    required String buttonText,
    required VoidCallback onPressed,
    required bool isSelected,
    required int index,
  }) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
        setState(() {
          for (int i = 0; i < buttonSelectedStates.length; i++) {
            buttonSelectedStates[i] = i == index;
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.brown : Colors.brown.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 2,
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
