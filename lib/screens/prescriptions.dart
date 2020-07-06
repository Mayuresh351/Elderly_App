import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

int count;
String filename;
bool showSpinner = false;

class ImageScreen extends StatefulWidget {
  static String id = 'ImageScreen';
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File image;
  var user = UserData();
  Widget makeImageGrid() {
    return Container(
      child: StreamBuilder(
        stream: getImageStatus(),
        builder: (context, snapshot) {
          return new GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: count,
              itemBuilder: (context, index) {
                return ImageGridItem(index + 1, image);
              });
        },
      ),
    );
  }

  Stream<DocumentSnapshot> getImageStatus() async* {
    String uid;
    print('stream');
    await user.currentUser().then((value) {
      uid = value.uid;
    });
    yield* Firestore.instance.collection('UserData').document(uid).snapshots();
  }

  Future getImage() async {
    var NewImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(NewImage);

    setState(() {
      try {
        image = NewImage;
      } catch (e) {
        print(e);
      }
    });
  }

  Future uploadIt() async {
    String filename;
    await user.currentUser().then((value) {
      filename = value.uid;
    });
    try {
      dynamic name = 'image_$count.png';
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('/$filename/image_$count2.png');
      StorageUploadTask uploadTask = await firebaseStorageRef.putFile(image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      if (uploadTask.isCanceled || uploadTask.isPaused) {
        setState(() {
          showSpinner = false;
        });
      } else {
        setState(() {
          print(imgList);
          imgList.add('image_$count2.png');
          if (uploadTask.isSuccessful) {
            print('yes');
            user.updateImage(true);
            showSpinner = false;
            requestedindexes.clear();
            initState();
          }
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        showSpinner = false;
      });
    }
  }

  void changedata() {
    user.getImageNo().then((value) {
      count = value;
      print(count);
      print('yo');
    });
    user.getImageList().then((value) {
      imgList = value;
      print(imgList);
    });
  }

  @override
  void initState() {
    super.initState();
    user.getImageNo().then((value) {
      count = value;
      print(count);
      print('yo');
    });
    user.getImageList().then((value) {
      imgList = value;
      print(imgList);
    });
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWidgetColor,
          title: Text(
            'Upload Prescriptions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: (count != 0)
              ? makeImageGrid()
              : Center(
                  child: Container(
                    child: Text('Press + to add an Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6F8FC),
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await getImage();
//          if(image !=null){
            await uploadIt();
//          }
          },
          backgroundColor: kWidgetColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}


class ImageGridItem extends StatefulWidget {
  ImageGridItem(int index, File image1) {
    this.index1 = index;
    this.image = image1;
  }

  int index1;
  File image;
  var user = UserData();
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  var user = UserData();
  String filename;
  Uint8List imageFile;

  void getImage() async {
    int MAX_SIZE = 7 * 1024 * 1024;
    if (!requestedindexes.contains(widget.index1)) {
      print(requestedindexes);
      await user.currentUser().then((value) {
        filename = value.uid;
      });
      print(widget.index1);
      StorageReference photosReference =
          FirebaseStorage.instance.ref().child('/$filename');
      photosReference
          .child(imgList[widget.index1])
          .getData(MAX_SIZE)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget.index1, () {
          return data;
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
      requestedindexes.add(widget.index1);
    }
  }

  Widget decideWidget() {
//    if (imageFile == null) {
//      return Center(child: Text('No Data'));
//    }
    if (imageFile != null) {
      print('imageblock');
      return Image.memory(
        imageFile,
        fit: BoxFit.cover,
      );
    }
//    else if(imageFile==null && widget.index1 == count && widget.image!=null){
//      print('')
//      return Image.file(widget.image,fit: BoxFit.cover);
//    }
    else {
      print('empty block');
      return Container(
        child: Center(
          child: Text('No Data'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (!imageData.containsKey(widget.index1)) {
      getImage();
    } else {
      this.setState(() {
        imageFile = imageData[widget.index1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
      onLongPress: () async {
        await user.currentUser().then((value) {
          filename = value.uid;
        });
        print('$filename/${imgList[widget.index1]}');
        StorageReference photosReference = await FirebaseStorage.instance
            .ref()
            .child('/$filename/${imgList[widget.index1]}');
        await photosReference.delete();
        imgList.removeAt(widget.index1);
        imageData.remove(widget.index1 - 1);
        requestedindexes.removeAt(widget.index1 - 1);
        user.updateImage(false);
        imageFile = null;
        initState();
        dispose();
      },
      child: decideWidget(),
    ));
  }
}
