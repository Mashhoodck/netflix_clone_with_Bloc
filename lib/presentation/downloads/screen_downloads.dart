import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/application/downloads/downloads_bloc.dart';

import 'package:netflix_bloc/core/colors/colors.dart';
import 'package:netflix_bloc/core/constant.dart';

import '../widgets/app_bar/app_bar.dart';

class SCreenDownloads extends StatelessWidget {
  SCreenDownloads({Key? key}) : super(key: key);

  List widgetList = const [
    SmartDownloads(),
    Section1(),
    Section2(),
    Section3()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarWidget(
              title: 'Downloads',
            )),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: ((context, index) {
              return widgetList[index];
            }),
            itemCount: widgetList.length));
  }
}

class Section1 extends StatelessWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Indroducing Downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWihiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        kHight10,
        Text(
          "We will download a personalised selection of\nmovies and shows for you, so there is always something to watch on your\ndevice",
          style: TextStyle(color: Colors.grey, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        BlocBuilder<DownloadsBloc, DownloadState>(
          builder: (context, state) {
            var _images = state.downloads;
            if (_images!.length > 2) {
              _images = _images;
            }
            return SizedBox(
              width: size.width,
              height: size.height * 0.60,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                            child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          radius: size.width * 0.35,
                        )),
                        DownloadImageWifget(
                          imageList: '$imageAppendUrl${_images[0].posterpath}',
                          angleRotaion: 20,
                          magrin: const EdgeInsets.only(left: 130, bottom: 50),
                          size: Size(size.width * 0.4, size.height * 0.48),
                        ),
                        DownloadImageWifget(
                          angleRotaion: -20,
                          imageList:
                              '$imageAppendUrl${_images[1].posterpath ?? ""}',
                          magrin: const EdgeInsets.only(right: 130, bottom: 50),
                          size: Size(size.width * 0.4, size.height * 0.48),
                        ),
                        DownloadImageWifget(
                          imageList:
                              '$imageAppendUrl${_images[2].posterpath ?? ""}',
                          magrin: const EdgeInsets.only(bottom: 10),
                          size: Size(size.width * 0.4, size.height * 0.58),
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: MaterialButton(
            onPressed: () {},
            color: kButtonCOlor,
            child: const Text(
              "Setup",
              style: TextStyle(
                  color: kWihiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          color: kWihiteColor,
          child: const Text(
            "See what you can download",
            style: TextStyle(
                color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class SmartDownloads extends StatelessWidget {
  const SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
        kWidth10,
        Text("Smart downloads")
      ],
    );
  }
}

class DownloadImageWifget extends StatelessWidget {
  const DownloadImageWifget(
      {Key? key,
      required this.imageList,
      required this.magrin,
      this.angleRotaion = 0,
      required this.size})
      : super(key: key);

  final String imageList;
  final EdgeInsets magrin;
  final double angleRotaion;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleRotaion * pi / 180,
      child: Container(
        margin: magrin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageList),
          ),
        ),
      ),
    );
  }
}
