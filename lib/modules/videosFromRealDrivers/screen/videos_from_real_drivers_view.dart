import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/youtube_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideosFromRealDriversScreen extends StatefulWidget {
  const VideosFromRealDriversScreen({super.key});

  @override
  State<VideosFromRealDriversScreen> createState() =>
      _VideosFromRealDriversScreenState();
}

class _VideosFromRealDriversScreenState
    extends State<VideosFromRealDriversScreen> {
  List<DocumentSnapshot> documents = [];
  bool isLoading = true;
  Future<List<DocumentSnapshot>> getAllDocuments() async {
    try {
      // Reference to the collection

      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('videos');

      // Fetch documents
      QuerySnapshot querySnapshot =
          await collectionRef.orderBy('createdAt').get();

      // Extract the documents
      List<DocumentSnapshot> documents = querySnapshot.docs;

      return documents.reversed.toList();
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return [];
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    documents = await getAllDocuments();

    setState(() {
      isLoading = false;
    });
    // Do something with the documents
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CentreLoading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Videos",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(children: [
                ...documents.map((e) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YouTubePlayerCard(
                                videoId: e["videoId"],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonImageView(url: e["url"]),
                      ),
                    )),
              ]),
            ),
          );
  }
}
