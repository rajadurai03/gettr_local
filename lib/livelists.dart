import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'livemodel.dart';

class LiveList extends StatefulWidget {
  final List<LiveModel> liveModelList;

  const LiveList({Key? key, required this.liveModelList}) : super(key: key);

  @override
  State<LiveList> createState() => _LiveListState();
}

class _LiveListState extends State<LiveList> {
  var axisSize = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [filterMenu(), menuList()],
          ),
        ),
      ),
    );
  }

  Widget filterMenu() {
    return InkWell(
      onTap: (){
        
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children:const [
            Text("New activity",
                style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 8,),
            Icon(Icons.keyboard_arrow_down,color: Colors.grey,)],
        )
      ),
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
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.redAccent,
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
                  ? const Text("LIVE",
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.w600))
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ), // inner content
                            ),
                          ),
                        )
                      : const SizedBox());
        });
  }
}
