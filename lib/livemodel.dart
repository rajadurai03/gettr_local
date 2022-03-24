class LiveData {
  int? maxVisible = 3;
  List<LiveModel>? data;

  LiveData({this.maxVisible, this.data});
}

class LiveModel {
  String? userID;
  String? image;
  String? name;
  int? status;
  bool? verifiedUser;
  String? streamImage;
  String? streamVideo;
  String? streamTitle;
  String? streamChannel;

  LiveModel(
      {this.userID,
      this.image,
      this.name,
      this.status,
      this.verifiedUser,
      this.streamTitle,
      this.streamImage,
      this.streamVideo,
      this.streamChannel});
}

class CategoryList {
  int? id;
  String? categoryName;
  bool? isChecked = false;

  CategoryList({this.id, this.categoryName, this.isChecked});

  bool? get getchecked => isChecked;

  set setchecked(bool value) {
    isChecked = value;
  }
}

List<CategoryList> categotyDataList = [
  CategoryList(
    id: 0,
    categoryName: "All",
    isChecked: true,
  ),
  CategoryList(
    id: 1,
    categoryName: "Entertainment",
    isChecked: false,
  ),
  CategoryList(
    id: 2,
    categoryName: "Comedy",
    isChecked: false,
  ),
  CategoryList(
    id: 3,
    categoryName: "Music",
    isChecked: false,
  ),
  CategoryList(
    id: 4,
    categoryName: "Prank",
    isChecked: false,
  ),
  CategoryList(
    id: 5,
    categoryName: "Cute/ Funny",
    isChecked: false,
  ),
  CategoryList(
    id: 6,
    categoryName: "Food",
    isChecked: false,
  ),
];

List<LiveModel> supportsDataList = [
  LiveModel(
    userID: "@Ironman",
    name: "Raja Durai",
    status: 1,
    image:
        "https://www.pinkvilla.com/imageresize/chris_future_thor.jpg?width=752&format=webp&t=pvorg",
    verifiedUser: true,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://i.insider.com/5c9a8e398629137be250fd22?width=700",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@parthasarthi kanagasabai",
    name: "Partha",
    status: 1,
    image:
        "https://thelesfilms.files.wordpress.com/2013/04/robertdowneyjrarrivalsironman3premierefahfqofz98kx.jpg",
    verifiedUser: true,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@Gopu_1245",
    name: "Gopu",
    status: 2,
    image:
        "https://ca-times.brightspotcdn.com/dims4/default/64766b5/2147483647/strip/true/crop/5696x8542+0+0/resize/840x1260!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F2f%2Fdf%2Ff0e9e39844fa87745f29d02c422b%2Fla-en-mark-ruffalo-pernille-loof-thomas-loof-24.JPG",
    verifiedUser: true,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://bgr.com/wp-content/uploads/2019/03/avengers-endgame-sign-2.jpg?quality=82&strip=all",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@venugopal_ramachandran",
    name: "VenuGopal",
    status: 2,
    image:
        "https://static01.nyt.com/images/2021/11/21/arts/21RENNER1/28RENNER1-mediumSquareAt3X.jpg",
    verifiedUser: false,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://www.thewrap.com/wp-content/uploads/2021/11/the-avengers.jpg",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@anandaraj_98",
    name: "Anandraj",
    status: 2,
    image:
        "https://www.pinkvilla.com/files/styles/amp_metadata_content_image/public/sebastian_stan_candidate_crush_main.jpg",
    verifiedUser: false,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://s3.amazonaws.com/static.rogerebert.com/uploads/collection/primary_image/the-history-of-marvel-movies/hero_the-history-of-marvel-movies.jpg",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@jagadeesan_vaithiyanathan_t.s",
    name: "Jagadeesan",
    status: 3,
    image:
        "https://www.giantfreakinrobot.com/wp-content/uploads/2021/08/sebastian-stan-winder-solider-e1629394854352-900x506.jpg",
    verifiedUser: true,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://www.gannett-cdn.com/presto/2021/12/16/USAT/2dfe2aea-12e1-4308-975d-8057110e658b-nhw_still_107_copy.jpg?width=2560",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@premkuar_gf",
    name: "PremKumar",
    status: 3,
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU5ch-cyZfsalVLKhvcziOpwcYIupAag5kBk1azKYhoVEZFgbm",
    verifiedUser: false,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
  LiveModel(
    userID: "@balamuragan_baskar_94",
    name: "BalaMurugan",
    status: 3,
    image:
        "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR8aL--nXG15st6MG-nAXulnYh0tAOg4qgNfhYhF8UOFxpMoLNX",
    verifiedUser: true,
    streamTitle:
        "LIVE : Chief Guest Ironman attend the Meeting @ 5pm indian Time",
    streamImage:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamVideo:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2020/12/Iron-man-3-tony-stark-Armor-wars.jpg",
    streamChannel: "NewsMax",
  ),
];
