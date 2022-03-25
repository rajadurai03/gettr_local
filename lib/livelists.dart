import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gettr_demo/constants.dart';
import 'package:gettr_demo/widget.dart';

import 'livemodel.dart';

class LiveList extends StatefulWidget {
  final List<LiveModel> liveModelList;

  const LiveList({Key? key, required this.liveModelList}) : super(key: key);

  @override
  State<LiveList> createState() => _LiveListState();
}

String _selected = 'Most Relevant';
int _selectedIndex = 0;
List<String> _items = ['Most Relevant', 'New Activity'];

class _LiveListState extends State<LiveList> {
  var axisSize = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios, color: AppColor().blueAccent),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: const Text(
            'Followed Hosts',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [filterMenu(), menuList()],
        ),
      ),
    );
  }

  Widget filterMenu() {
    return InkWell(
      onTap: () {
        showModal(context);
      },
      child: Container(
          padding: EdgeInsets.only(left: 16,bottom: 8,top: 16),
          child: Row(
            children: [
              Text(_selected,
                  style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black87)),
              const SizedBox(
                width: 2,
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              )
            ],
          )),
    );
  }

  Widget menuList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.liveModelList.length,
        itemBuilder: (context, index) {
          var model = widget.liveModelList[index];
          return ListTile(
              leading: Container(
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
              title: Row(
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black87),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  (model.verifiedUser! == true)
                      ? SvgPicture.asset(
                      assetVerification,
                      semanticsLabel: 'verification Logo'
                  )
                      : const SizedBox()
                ],
              ),
              subtitle: Text(
                model.userID!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey,fontSize: 14),
              ),
              trailing: model.status == 1
                  ? Text("LIVE",
                      style: TextStyle(
                          color: AppColor().redAccent, fontWeight: FontWeight.w600,fontSize: 12))
                  : model.status == 2
                      ? Container(
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
                                color: AppColor().blueAccent,
                              ), // inner content
                            ),
                          ),
                        )
                      : const SizedBox());
        });
  }

  void showModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (context) {
          return
            Container(
                decoration: getBoxDecoration(),
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    const SizedBox(
                      height: kToolbarHeight / 2,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: kToolbarHeight / 1.5,
                        height: 4,
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: kToolbarHeight /1.5 ,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: _items.length,
                      separatorBuilder: (context, int) {
                        return Column(
                          children: const [
                            SizedBox(
                              height: 30,
                            ),
                            // Divider(),
                          ],
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {

                        return InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _items[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                _selectedIndex == index
                                    ? Icon(Icons.check_circle,
                                    color: AppColor().blueAccent)
                                    : Container()
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selected = _items[index];
                                _selectedIndex = index;
                              });
                              Navigator.of(context).pop();
                            });
                      },
                    ),
                    const SizedBox(
                      height: kToolbarHeight/1.5,
                    ),


                  ],
                ));



        });
  }
}
