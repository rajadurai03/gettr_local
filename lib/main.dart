import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gettr_demo/constants.dart';
import 'package:gettr_demo/story_item.dart';
import 'package:gettr_demo/story_json.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'livelists.dart';
import 'livemodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        fontFamily: 'Antarctica Beta',
      ),
      home: const MyHomePage(title: 'Live'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LiveModel> modelData = List<LiveModel>.empty(growable: true);
  List<CategoryList> categoryData = List<CategoryList>.empty(growable: true);

  bool isLoadingVertical = false;

  @override
  void initState() {
    _loadMoreVertical();
    super.initState();
  }

  Future _loadMoreVertical() async {
    // setState(() {
    //   isLoadingVertical = true;
    // });

    // Add in an artificial delay
    // await Future.delayed(const Duration(seconds: 2));

    InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LiveList(
                        liveModelList: modelData,
                      )));
        },
        child: Container(
            padding: const EdgeInsets.only(left: 12, right: 24),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "View all",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: AppColor().lightBlue),
              ),
            )));

    // setState(() {
    //   isLoadingVertical = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    modelData = supportsDataList;
    categoryData = categotyDataList;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(modelData[0].image!),
                      // color: Colors.red,
                    )),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            liveChatList(context),
            const Divider(),
            categoryFilter(context),
            const Divider(),
            liveData(context),
          ]),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget liveChatList(BuildContext context) {
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //       children: List.generate(stories.length, (index) {
    //         return StoryItem(
    //           img: stories[index]['img'],
    //           name: stories[index]['name'],
    //           isLive: stories[index]['isLive'],
    //         );
    //       })),
    // );
    return SizedBox(
      height: kToolbarHeight * 2,
      child: ListView.separated(
          padding: const EdgeInsets.only(left: 10, right: 10),
          scrollDirection: Axis.horizontal,
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            var data = modelData[index];
            // return chatTile(context, data);
            if (index < 6) {
              return StoryItem(
                img: stories[index]['img'],
                name: stories[index]['name'],
                isLive: stories[index]['isLive'],
              );
            } else if (index == 6) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveList(
                              liveModelList: modelData,
                            )));
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 12, right: 24),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor().blueAccent),
                        ),
                      )));
            } else {
              return const SizedBox();
            }
          }

          ),
    );
  }

  Widget chatTile(BuildContext context, LiveModel model) {
    var axisSize = kToolbarHeight;
    return Container(
        // margin: EdgeInsets.only(left: 15, right:),
        alignment: Alignment.center,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: axisSize,
                  height: axisSize,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: model.status == 1
                        ? AppColor().redAccent
                        : Colors.transparent,
                    // border color
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.image!),
                        ),
                      ),
                    ),
                  ),
                ),
                model.status == 1
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white, // border color
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              color: AppColor().redAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "LIVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                model.status == 2
                    ? Positioned(
                        bottom: 6,
                        right: 3,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.white, // border color
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor().lightBlue,
                              ), // inner content
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Text(
              model.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.0,
              ),
            ),
          ],
        ));
  }

  Widget categoryFilter(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - 8,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 15, right: 15),
          scrollDirection: Axis.horizontal,
          primary: false,
          shrinkWrap: true,
          itemCount: categoryData.length,
          itemBuilder: ((context, index) {
            var data = categoryData[index];

            return categoryTile(context, data);
          })),
    );
  }

  Widget categoryTile(BuildContext context, CategoryList filter) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: RawChip(
          elevation: 0,
          label: Text(filter.categoryName!),
          labelStyle: TextStyle(
              color: filter.getchecked! ? Colors.white : Colors.black),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          backgroundColor: Colors.white,
          selectedColor: AppColor().darkBlue,
          selected: filter.getchecked!,
          shape: StadiumBorder(
              side: BorderSide(
                  color: filter.getchecked!
                      ? const Color(0XFF232255)
                      : Colors.grey,
                  width: 0.5)),
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              for (var data in categoryData) {
                data.setchecked = false;
              }

              if (filter.getchecked == false) {
                filter.setchecked = true;
              } else {
                filter.setchecked = false;
              }
            });
          }),
    );
  }

  Widget liveData(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        primary: false,
        shrinkWrap: true,
        itemCount: modelData.length,
        itemBuilder: ((context, index) {
          var data = modelData[index];
          return liveTile(context, data);
        }));
  }

  Widget liveTile(BuildContext context, LiveModel model) {
    var axisSize = kToolbarHeight;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: axisSize * 4,
              margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(model.streamImage!),
                ),
              ),
            ),
            Positioned(
              top: 18,
              left: 22,
              child: Row(
                children: [
                  SvgPicture.asset(
                    assetLiveMenu,
                    semanticsLabel: 'live now icon',
                    height: 30,
                    // width: 50,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    model.views!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Positioned(
                top: 18,
                right: 28,
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ))
          ],
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: axisSize - 16,
                height: axisSize - 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.image!),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.streamTitle!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, height: 1.3),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        model.streamChannel!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      (model.verifiedUser! == true)
                          ? SvgPicture.asset(assetVerification,
                              semanticsLabel: 'verification Logo')
                          : const SizedBox(),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          model.userID!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}

class DemoItem extends StatelessWidget {
  final int position;

  const DemoItem(
    this.position, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                    height: 40.0,
                    width: 40.0,
                  ),
                  SizedBox(width: 8.0),
                  Text("Item $position"),
                ],
              ),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed vulputate orci. Proin id scelerisque velit. Fusce at ligula ligula. Donec fringilla sapien odio, et faucibus tortor finibus sed. Aenean rutrum ipsum in sagittis auctor. Pellentesque mattis luctus consequat. Sed eget sapien ut nibh rhoncus cursus. Donec eget nisl aliquam, ornare sapien sit amet, lacinia quam."),
            ],
          ),
        ),
      ),
    );
  }
}
