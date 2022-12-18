import 'dart:io';

import 'package:flutter/material.dart';
import '../../Service/Model/Helper.dart';
import '../../Service/Model/Notification.dart';
import '../../Screen/Widget/MyBottomSheet.dart';
import '../../Screen/Widget/TextField.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DownloaderHelper downloaderHelper = DownloaderHelper();
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  bool? isDownloading;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  void fieldValidate() {
    if (_globalKey.currentState!.validate()) {
      _validate();
    }
  }

  void _validate() async {
    setState(() {
      isLoading = true;
    });
    var data = await downloaderHelper
        .getVideoInfo(Uri.parse(textEditingController.text));
    setState(() {
      isLoading = false;
    });
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MyBottomSheet(
            imageUrl: data['image'].toString(),
            title: data['title'],
            author: data["author"],
            duration: data['duration'].toString(),
            mp3Size: data['mp3'],
            mp4Size: data['mp4'],
            mp3Method: () async {
              isDownloading = true;
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text('Audio Start Downloading')
                    ],
                  ),
                ));
              });
              await downloaderHelper.downloadMp3(data['id'], data['title']);
              setState(() {
                isDownloading = false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.download_done,
                          color: Colors.green,
                          size: 30,
                        ),
                        Text('  Audio Downloaded')
                      ],
                    )));
              });
            },
            isDownloading: isDownloading,
            mp4Method: () async {
              setState(() {
                isDownloading = true;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text('Video Start Downloading')
                    ],
                  ),
                ));
              });
              await downloaderHelper.downloadMp4(data['id'], data['title']);
              setState(() {
                isDownloading = false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.download_done,
                        color: Colors.green,
                        size: 30,
                      ),
                      Text(
                        'Video Downloaded'
                      )
                    ],
                  ),
                ));
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Youtube Downloader',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                radius: 96,
                backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1427292844612595720/RC1YSvuT_400x400.jpg'
                ),
              ),
              SizedBox(height: 10,),
              InputField(
                title: 'Video URL',
                hint: 'Enter youtube video URL here',
                fieldController: textEditingController,
                onFieldSubmitted: (value){
                  print(value);
                  fieldValidate();
                },
                validator: (value){
                  if(textEditingController.text.isEmpty){
                    return 'Please fill the empty box';
                  }
                  String y1 = "youtu.be";
                  String y2 = "youtube.com";
                  if(!textEditingController.text.contains('youtu')){
                    return 'Please Enter a Youtube URL';
                  }
                },
              ),
              ElevatedButton(
                onPressed: fieldValidate,
                child: const Text(
                  'Download',
                ),
              ),
              SizedBox(height: 15,),
              if(isLoading)const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
