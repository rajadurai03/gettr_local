import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gettr_demo/constants.dart';
import 'package:gettr_demo/story_json.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  final String isLive;

  // ignore: use_key_in_widget_constructors
  const StoryItem({
    required this.img,
    required this.name,
    required this.isLive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLive == 'true' ? Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              CircleAvatar(
               backgroundColor: AppColor().redAccent,
               radius: 37,
               child: CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 34,
                 child: CircleAvatar(
                   backgroundImage: NetworkImage(img), //NetworkImage
                   radius: 32,
                 ), //CircleAvatar
               ), //CircleAvatar
              ),
               Positioned(
                bottom: -2.0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white, // border color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 1),
                    decoration: BoxDecoration(
                      color: AppColor().redAccent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "LIVE",
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 65,
            child: Center(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ) : isLive == 'Online' ? Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(profile),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.circle,
                      color: AppColor().lightBlue,
                      size: 15,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: SizedBox(
              width: 65,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ) : Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(profile),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top:3.0),
            child: SizedBox(
              width: 65,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
