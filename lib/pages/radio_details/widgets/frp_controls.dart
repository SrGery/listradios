import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_player_event.dart';

class FRPPlayerControls extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final Function addSourceFunction;
  final Function(String status) updateCurrentStatus;

  const FRPPlayerControls({
    Key? key,
    required this.flutterRadioPlayer,
    required this.addSourceFunction,
    required this.updateCurrentStatus,
  }) : super(key: key);

  @override
  State<FRPPlayerControls> createState() => _FRPPlayerControlsState();
}

class _FRPPlayerControlsState extends State<FRPPlayerControls> {
  String latestPlaybackStatus = "flutter_radio_stopped";
  String currentPlaying = "N/A";
  double volume = 0.5;
  final nowPlayingTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.flutterRadioPlayer.frpEventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FRPPlayerEvents frpEvent =
              FRPPlayerEvents.fromJson(jsonDecode(snapshot.data as String));
          if (kDebugMode) {
            print("====== EVENT START =====");
            print("Playback status: ${frpEvent.playbackStatus}");
            print("Icy details: ${frpEvent.icyMetaDetails}");
            print("Other: ${frpEvent.data}");
            print("====== EVENT END =====");
          }
          if (frpEvent.playbackStatus != null) {
            latestPlaybackStatus = frpEvent.playbackStatus!;
            widget.updateCurrentStatus(latestPlaybackStatus);
          }
          if (frpEvent.icyMetaDetails != null) {
            currentPlaying = frpEvent.icyMetaDetails!;
            nowPlayingTextController.text = frpEvent.icyMetaDetails!;
          }
          var statusIcon = const Icon(Icons.pause_circle_filled);
          switch (frpEvent.playbackStatus) {
            case "flutter_radio_playing":
              statusIcon = const Icon(Icons.pause_circle_filled);
              break;
            case "flutter_radio_paused":
              statusIcon = const Icon(Icons.play_circle_filled);
              break;
            case "flutter_radio_loading":
              statusIcon = const Icon(Icons.refresh_rounded);
              break;
            case "flutter_radio_stopped":
              statusIcon = const Icon(Icons.play_circle_filled);
              break;
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Slider(
                    activeColor: const Color.fromRGBO(0, 220, 130, 1),
                    value: volume,
                    onChanged: (value) {
                      setState(() {
                        volume = value;
                        widget.flutterRadioPlayer.setVolume(volume);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 70,
                        color: const Color.fromRGBO(0, 220, 130, 1),
                        onPressed: () async {
                          widget.flutterRadioPlayer.playOrPause();
                          resetNowPlayingInfo();
                        },
                        icon: statusIcon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (latestPlaybackStatus == "flutter_radio_stopped") {
          return IconButton(
              iconSize: 70,
              color: const Color.fromRGBO(0, 220, 130, 1),
              onPressed: () async {
                widget.addSourceFunction();
              },
              icon: const Icon(Icons.play_circle_filled));
        }
        return const Text("Determining state ...");
      },
    );
  }

  void resetNowPlayingInfo() {
    currentPlaying = "N/A";
  }
}
