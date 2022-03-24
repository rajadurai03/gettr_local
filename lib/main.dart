import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    modelData = supportsDataList;
    categoryData = categotyDataList;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
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
    return SizedBox(
      height: kToolbarHeight * 1.8,
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          scrollDirection: Axis.horizontal,
          primary: false,
          shrinkWrap: true,
          itemCount: modelData.length,
          itemBuilder: ((context, index) {
            var data = modelData[index];

            if (index < 6) {
              return chatTile(context, data);
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
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.blueAccent),
                        ),
                      )));
            } else {
              return const SizedBox();
            }
          })),
    );
  }

  Widget chatTile(BuildContext context, LiveModel model) {
    var axisSize = kToolbarHeight;
    return Container(
        margin: EdgeInsets.only(left: 8, right: axisSize / 3),
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
                    color: model.status == 1 ? Colors.red : Colors.transparent,
                    // border color
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
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
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "LIVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
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
          selectedColor: Colors.blueAccent,
          selected: filter.getchecked!,
          shape: StadiumBorder(
              side: BorderSide(
                  color: filter.getchecked! ? Colors.blueAccent : Colors.grey,
                  width: 0.5)),
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              categoryData.forEach((data) => data.setchecked = false);

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

          Positioned(top: 18,left:28,child:  Row(children: [
            Container(

                padding: const EdgeInsets.only(left:4,right:4,top:2,bottom:2),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Colors.red
                ),
                child: Row(children: const [
                  Icon(Icons.sensors,color: Colors.white,size: 12,),
                  SizedBox(width: 2,),
                  Text("LIVE",style: TextStyle(color: Colors.white,fontSize: 10),)
                ],)
            ),
            const SizedBox(width: 4),
            const Text("1.3M Views",style: TextStyle(color: Colors.white,fontSize: 10),)

          ],),),

          const Positioned(top: 18,right: 28,child:  Icon(Icons.more_horiz,color: Colors.white,) )

          ],
        ),
        Container(
          padding:const EdgeInsets.only(top: 8,bottom: 16,right: 16,left: 16),
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
            const  SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.streamTitle!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500,height: 1.3),
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
                      const SizedBox(
                        width: 4,
                      ),
                      (model.verifiedUser! == true)
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.redAccent,
                              size: 16,
                            )
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
const SizedBox(height:8)
      ],
    );
  }
}
