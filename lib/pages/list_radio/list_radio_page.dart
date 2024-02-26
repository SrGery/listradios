import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listradios/pages/list_radio/application/list_radio_bloc.dart';
import 'package:listradios/utils/navigation.dart';
import '../../services/repositories/radio_repository.dart';
import '../radio_details/radio_details_page.dart';

class ListRadioPage extends StatefulWidget {
  const ListRadioPage({super.key});

  @override
  State<ListRadioPage> createState() => _ListRadioPageState();
}

class _ListRadioPageState extends State<ListRadioPage> {
  late final ListRadioBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = ListRadioBloc(
      repository: RepositoryProvider.of<RadioRepository>(context),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: const ListRadioPageBody(),
    );
  }
}

class ListRadioPageBody extends StatefulWidget {
  const ListRadioPageBody({super.key});

  @override
  State<ListRadioPageBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<ListRadioPageBody> {
  @override
  void initState() {
    super.initState();

    context.read<ListRadioBloc>().add(GetRadioEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 6, 23, 1),
      body: SafeArea(
        child: BlocBuilder<ListRadioBloc, ListRadioState>(
          builder: (context, state) {
            switch (state) {
              case HomeInitialState():
              case HomeLoadingState():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case HomeLoadedState():
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 44),
                            const Text(
                              'Top 10 Radios',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                aspectRatio: 1.0,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                initialPage: 0,
                                autoPlay: false,
                                disableCenter: true,
                                animateToClosest: true,
                              ),
                              items: state.radioStations.map((radio) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            RadioDetailPage(
                                              radio: radio,
                                            ));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    NetworkImage(radio.image)),
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.06)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.5),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      14,
                                                                  vertical: 12),
                                                          child: Text(
                                                            radio.name,
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'All Radios',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        children: state.radioStations.map((radio) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        RadioDetailPage(
                                          radio: radio,
                                        ));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.06),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(radio.image),
                                                  fit: BoxFit.cover)),
                                          height: 150,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  radio.name,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  radio.country,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    )
                  ],
                );
              case HomeErrorState():
                return Center(
                  child: Container(
                    color: Colors.red,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
