import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:listradios/models/data/radio.dart';
import 'package:listradios/pages/radio_details/widgets/frp_player.dart';

class RadioDetailPage extends StatefulWidget {
  final Radios radio;

  const RadioDetailPage({super.key, required this.radio});

  @override
  State<RadioDetailPage> createState() => RadioDetailPageState();
}

class RadioDetailPageState extends State<RadioDetailPage> {
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();
  late final FRPSource frpSource;

  @override
  void initState() {
    super.initState();
    _flutterRadioPlayer.initPlayer();
    frpSource = FRPSource(
      mediaSources: <MediaSources>[
        MediaSources(
          url: widget.radio.url,
          description: widget.radio.name,
          isPrimary: true,
          title: widget.radio.name,
          isAac: true,
        ),
      ],
    );
    _flutterRadioPlayer.addMediaSources(frpSource);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(2, 6, 23, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(widget.radio.name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 16,
              )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.radio.image)),
                          color: const Color.fromRGBO(255, 255, 255, 0.06))),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(widget.radio.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(widget.radio.country,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.white70,
                            fontSize: 20,
                          )),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    FRPlayer(
                      flutterRadioPlayer: _flutterRadioPlayer,
                      frpSource: frpSource,
                      useIcyData: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPopScope() {
    _flutterRadioPlayer.stop();
    return Future.value(true);
  }
}
