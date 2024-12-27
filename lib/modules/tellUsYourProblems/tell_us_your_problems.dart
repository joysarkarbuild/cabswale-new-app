import 'dart:io';

import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final TextEditingController _problemController = TextEditingController();
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  late AudioPlayer _audioPlayer;
  bool _isRecordingAudio = false;
  bool _isPlayingAudio = false;
  String? _audioFilePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeAudioRecorder();
    initializeAudioPlayer();
  }

  Future<void> initializeAudioRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }

    await _audioRecorder.openRecorder();
  }

  Future<void> initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlayingAudio = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _problemController.dispose();
    _audioRecorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startAudioRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    _audioFilePath = path.join(directory.path, 'audio.aac');
    await _audioRecorder.startRecorder(
      toFile: _audioFilePath,
    );
    setState(() {
      _isRecordingAudio = true;
    });
  }

  Future<void> stopAudioRecording() async {
    await _audioRecorder.stopRecorder();
    setState(() {
      _isRecordingAudio = false;
    });
  }

  Future<void> playPauseAudio() async {
    if (_isPlayingAudio) {
      await _audioPlayer.pause();
    } else {
      if (_audioFilePath != null) {
        await _audioPlayer.setFilePath(_audioFilePath!);
        await _audioPlayer.play();
      }
    }
  }

  Future<void> removeAudio() async {
    _audioFilePath = null;
    setState(() {});
  }

  Future<String?> uploadAudioToFirebase(String filePath) async {
    try {
      File file = File(filePath);
      String fileName = path.basename(filePath);
      Reference storageRef = FirebaseStorage.instance.ref().child(
          'audios/${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toString()}$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      await uploadTask;
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: "Error uploading audio: $e");
      return null;
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void handleSubmit() async {
    if (_audioFilePath != null || _problemController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String? audioURL;
      if (_audioFilePath != null) {
        audioURL = await uploadAudioToFirebase(_audioFilePath!);
      }

      await FirebaseFirestore.instance
          .collection("community")
          .doc("problems")
          .collection("list")
          .add({
        "audio": audioURL,
        "id": FirebaseAuth.instance.currentUser!.uid,
        "problem": _problemController.text,
        "createdAt": DateTime.now(),
        "name": DriverService.instance.driverModel!.name,
        "phoneNo": DriverService.instance.driverModel!.phoneNo,
      });

      await FirebaseFirestore.instance
          .collection("community")
          .doc("problems")
          .get()
          .then(((value) async {
        int count = value.data()!["count"];
        await FirebaseFirestore.instance
            .collection("community")
            .doc("problems")
            .update({"count": count + 1});
      }));

      setState(() {
        _isLoading = false;
      });

      showToast("Problem reported successfully");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      _problemController.clear();
      _audioFilePath = null;
    } else {
      SnackbarUtils.showErrorSnackBar(
          message: "Please write something or record audio!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Report a Problem'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerImage(bannerId: "problem"),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _problemController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Tell us your problem',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        icon: Icon(
                          _isRecordingAudio
                              ? Icons.pause
                              : (_audioFilePath != null && _isPlayingAudio
                                  ? Icons.pause
                                  : (_audioFilePath != null
                                      ? Icons.play_arrow
                                      : Icons.mic)),
                          color: Colors.green,
                        ),
                        label: Text(
                          _isRecordingAudio
                              ? 'Pause'
                              : (_audioFilePath != null && _isPlayingAudio
                                  ? 'Pause'
                                  : (_audioFilePath != null
                                      ? 'Play Audio'
                                      : 'Record Audio')),
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_isRecordingAudio) {
                            await stopAudioRecording();
                          } else if (_audioFilePath != null) {
                            await playPauseAudio();
                          } else {
                            await startAudioRecording();
                          }
                        },
                      ),
                    ],
                  ),
                  if (_audioFilePath != null)
                    TextButton(
                      onPressed: removeAudio,
                      child: Text('Clear Audio and Record Again'),
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: handleSubmit,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "If you are facing any issues, connect with us",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  String url = 'https://wa.me/9368006253/';
                                  // if (await canLaunch(url)) {
                                  await launchUrl(Uri.parse(url));
                                  debugPrint('sending message: $url');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.42,
                                      40), // Adjust the size as per your requirement
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical:
                                          6), // Adjust the padding as per your requirement
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/whatsapp.svg',
                                      height: 26,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'WhatsApp',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  launchUrl(Uri.parse("tel:+91940389036"));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.42,
                                      40), // Adjust the size as per your requirement
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical:
                                          6), // Adjust the padding as per your requirement
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Call',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Text(
                        "Timing: Monday to Sunday 9am to 12am",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
