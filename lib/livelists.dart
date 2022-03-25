import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gettr_demo/constants.dart';

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
      appBar: AppBar(
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios, color: AppColor().lightBlue),
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
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Text(_selected,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 8,
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
                width: axisSize - 6,
                height: axisSize - 6,
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
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  (model.verifiedUser! == true)
                      ? Icon(
                          Icons.check_circle,
                          color: AppColor().redAccent,
                          size: 16,
                        )
                      : const SizedBox()
                ],
              ),
              subtitle: Text(
                model.userID!,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: model.status == 1
                  ? Text("LIVE",
                      style: TextStyle(
                          color: AppColor().redAccent, fontWeight: FontWeight.w600))
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
                                color: AppColor().lightBlue,
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
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            height: 120,
            alignment: Alignment.center,
            child: ListView.separated(
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
                itemBuilder: (context, index) {
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
                                  color: AppColor().lightBlue)
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
                }),
          );
        });
  }
}
