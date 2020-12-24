import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/app/pages/profile/profile_controller.dart';
import 'package:mobile/src/app/pages/profile/view/list_profile_offline.view.dart';
import 'package:mobile/src/app/pages/profile/view/profile_detail.view.dart';
import 'package:mobile/src/app/pages/profile/view/search_advanced_profile.view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Loading/LoadingJumpingLine.dart';
import 'package:mobile/src/utility/Loading/LoadingStyleGrid.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

class ListProfilePage extends View {
  final String param;

  ListProfilePage(this.param);

  @override
  _ListProfilePageState createState() => _ListProfilePageState();
}

class _ListProfilePageState
    extends ViewState<ListProfilePage, ProfileController> {
  _ListProfilePageState() : super(ProfileController(ProfileRepository()));

  var _size;
  double _headerHeight = 0;
  var page = 1;
  var limit = 10;
  final valueSearch = TextEditingController();
  Map<String, dynamic> objectSearch = new Map();
  var listProfileOffline;
  var flagCheckOnline = true;
  var userInfo;

  var flagLoading = false;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    controller.getAllProfile(objectSearch, false);
    LocalStorageService.savePageList(1);
    WidgetsBinding.instance.addPostFrameCallback((_) => getProfileOffline());
    WidgetsBinding.instance.addPostFrameCallback((_) => functionCheckOnline());
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserLocalStore());
  }

  @override
  void dispose() {
    LocalStorageService.savePageList(1);
    super.dispose();
  }

  //TODO get user localStore
  Future<void> getUserLocalStore() async {}
  //TODO get profile offline form controller
  Future<void> getProfileOffline() async {
    listProfileOffline = await controller.getListProfileOffile();
  }

  //TODO check online or offline
  Future<void> functionCheckOnline() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (await Utils.isInternetConnected()) {
      flagCheckOnline = true;
    } else
      flagCheckOnline = false;
  }

  @override
  Widget buildPage() {
    _size = MediaQuery.of(context).size;
    _headerHeight = _size.height * .22;
    List listListOffine = listProfileOffline != null ? listProfileOffline : [];
    final listProfileAll = controller.getAllProfilesPagination();
    final List newItems = [...listListOffine, ...listProfileAll];

    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
        home: Scaffold(
            key: RIKeys.riKey1,
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () async {
                      final user = await LocalStorageService.getUserInfor();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MainHomePage(user)));
                    });
              }),
              title: Text(Strings.profile,
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
              actions: <Widget>[
                isOnline
                    ? IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 30.0,
                        color: Colors.white,
                        onPressed: () {
                          final param = Strings.key_create_profile;
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new CustomerListPage(param: param)));
                        })
                    : SizedBox(),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return ShowDialogSearch(
                              objectSearch: objectSearch,
                              controller: controller);
                        });
                  },
                ),
                SizedBox(
                  width: 10.0,
                )
              ],
              bottom: PreferredSize(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 0, 13, 20),
                    child: Container(
                      height: 50.0,
                      child: TextField(
                        controller: valueSearch,
                        onChanged: (text) {
                          objectSearch['value'] = valueSearch.text;
                          controller.getAllProfile(objectSearch, false);
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue[400],
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0))),
                            labelText: Strings.search_profile,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                preferredSize: const Size.fromHeight(80.0),
              ),
            ),
            body: SafeArea(
                right: true,
                top: true,
                bottom: true,
                left: true,
                child: (newItems.length >= 0)
                    ? Listitem(newItems, widget.param, controller, objectSearch,
                        isOnline)
                    : LoadingStyleGrid())));
  }

  @override
  void onConnectivityListener(bool result) {
    setState(() {
      isOnline = result;
    });
  }
}

class Listitem extends StatefulWidget {
  List items;
  final param;
  ProfileController controller;
  Map<String, dynamic> objectSearch;
  bool isOnline;

  Listitem(this.items, this.param, this.controller, this.objectSearch,
      this.isOnline);

  @override
  _ListitemState createState() => _ListitemState();
}

class _ListitemState extends State<Listitem> {
  Size _size;
  bool isLoading = false;

  @override
  void dispose() {
    LocalStorageService.savePageList(1);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 1));
    await widget.controller.getAllProfile(widget.objectSearch, true);
    setState(() {
      isLoading = false;
    });
  }

  Future _loadDataTop() async {
    await widget.controller.getAllProfile(widget.objectSearch, false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: <Widget>[
          (widget.isOnline == false)
              ? WidgetUitlites.offlineView(context)
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Strings.list_profile,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          WidgetUitlites.processBarWidget(context),
          Expanded(
              child: Container(
                  child: (widget.items?.length <= 0)
                      ? Scaffold(
                          body: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    ImagePath.search,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(Strings.empty_data),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Scaffold(
                          body: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!isLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  _loadData();
                                  // start loading data
                                  setState(() {
                                    isLoading = true;
                                  });
                                }
                              },
                              child: CustomScrollView(
                                slivers: <Widget>[
                                  SliverList(
                                      delegate: SliverChildListDelegate([
                                    Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: widget.items?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              child: widget
                                                      ?.items[index]?.isOnline

                                                  ///TODO List doc online
                                                  ? ListTile(
                                                      onTap: () {
                                                        if (widget.isOnline ==
                                                            false) return null;
                                                        if (widget.items[index]
                                                                .status ==
                                                            'DRAFT') {
                                                          var data =
                                                              new CarProfileData();
                                                          data.latitude = widget
                                                              .items[index]
                                                              ?.latitude;
                                                          data.longitude =
                                                              widget
                                                                  .items[index]
                                                                  ?.longitude;
                                                          data.createdById =
                                                              widget
                                                                  .items[index]
                                                                  ?.createdBy
                                                                  ?.id;
                                                          data.id = widget
                                                              .items[index]?.id;
                                                          data.customerId =
                                                              widget
                                                                  .items[index]
                                                                  ?.customer
                                                                  ?.id;
                                                          data.licensePlates =
                                                              widget
                                                                  .items[index]
                                                                  ?.licensePlates;
                                                          data.chassisNumber =
                                                              widget
                                                                  .items[index]
                                                                  ?.chassisNumber;
                                                          data.vehicleNumber =
                                                              widget
                                                                  .items[index]
                                                                  ?.vehicleNumber;
                                                          data.printeMattersNumber =
                                                              widget
                                                                  .items[index]
                                                                  ?.printeMattersNumber;
                                                          data.contractNumber =
                                                              widget
                                                                  .items[index]
                                                                  ?.contractNumber;
                                                          data.effectiveDate =
                                                              widget
                                                                  .items[index]
                                                                  ?.effectiveDate;
                                                          data.priceCar = widget
                                                              .items[index]
                                                              ?.priceCar;
                                                          data.manufacturingYear = widget
                                                                      .items[
                                                                          index]
                                                                      ?.manufacturingYear !=
                                                                  null
                                                              ? widget
                                                                  .items[index]
                                                                  ?.manufacturingYear
                                                              : 0;
                                                          data.usedYear = widget
                                                              .items[index]
                                                              ?.usedYear;
                                                          data.vehicleStatus =
                                                              widget
                                                                  .items[index]
                                                                  ?.vehicleStatus;
                                                          data.scratches =
                                                              widget
                                                                  .items[index]
                                                                  ?.scratches;
                                                          data.upgradeCar =
                                                              widget
                                                                  .items[index]
                                                                  ?.upgradeCar;
                                                          data.note = widget
                                                              .items[index]
                                                              ?.note;
                                                          data.typeCar = widget
                                                              .items[index]
                                                              ?.carCategory
                                                              ?.parent
                                                              ?.name;
                                                          data.cylinder = widget
                                                              .items[index]
                                                              ?.cylinder;
                                                          data.categoryId =
                                                              widget
                                                                  .items[index]
                                                                  ?.carCategory
                                                                  ?.id;
                                                          data.car = widget
                                                              .items[index]
                                                              ?.carCategory
                                                              ?.name;
                                                          data.imgCarFrontPositionRight =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgCarFrontPositionRight;
                                                          data.imgCarFrontPositionLeft =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgCarFrontPositionLeft;
                                                          data.imgCarRearPositionLeft =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgCarRearPositionLeft;
                                                          data.imgCarRearPositionRight =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgCarRearPositionRight;
                                                          data.imgWindshield =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgWindshield;
                                                          data.imgChassis =
                                                              widget
                                                                  .items[index]
                                                                  ?.imgChassis;
                                                          data.video = widget
                                                              .items[index]
                                                              ?.video;
                                                          data.videoThumbnail =
                                                              widget
                                                                  .items[index]
                                                                  ?.video;
                                                          data.status = widget
                                                              .items[index]
                                                              ?.status;
                                                          data.vehicleStatusIsNormal =
                                                              data.vehicleStatusIsNormal;
                                                          data.isScratched =
                                                              data.isScratched;
                                                          data.extraAccessories =
                                                              data.extraAccessories;

                                                          List<String>
                                                              listImagesExtendID =
                                                              [];
                                                          data.listImagesExtendID =
                                                              listImagesExtendID;
                                                          widget.items[index]
                                                              ?.imageExtends
                                                              ?.forEach(
                                                                  (element) {
                                                            listImagesExtendID
                                                                .add(element.id
                                                                    .toString());
                                                          });

                                                          if (widget
                                                                  .items[index]
                                                                  ?.imageExtends
                                                                  .length >
                                                              0) {
                                                            List<String>
                                                                imgsOption = [];
                                                            for (int i = 0;
                                                                i <
                                                                    widget
                                                                        .items[
                                                                            index]
                                                                        .imageExtends
                                                                        .length;
                                                                i++) {
                                                              imgsOption.add(widget
                                                                  .items[index]
                                                                  .imageExtends[
                                                                      i]
                                                                  .url);
                                                            }
                                                            data.imageOptions =
                                                                imgsOption;
                                                          }
                                                          if (widget
                                                                  .items[index]
                                                                  ?.customer
                                                                  ?.id !=
                                                              null) {
                                                            NavigatorUtilities
                                                                .push(
                                                                    context,
                                                                    CarInfoPage(
                                                                      data:
                                                                          data,
                                                                      profileId:
                                                                          '${widget.items[index].id}',
                                                                    ));
                                                          } else {
                                                            final param_create_profile =
                                                                Strings
                                                                    .key_create_profile;
                                                            NavigatorUtilities.push(
                                                                context,
                                                                CustomerListPage(
                                                                  dataIocOffline:
                                                                      data,
                                                                  param:
                                                                      param_create_profile,
                                                                ));
                                                          }
                                                        } else {
                                                          NavigatorUtilities
                                                              .push(
                                                                  context,
                                                                  ProfileDetail(
                                                                    idOwner: widget
                                                                        .items[
                                                                            index]
                                                                        ?.createdBy
                                                                        ?.id,
                                                                    idDoc: widget
                                                                        .items[
                                                                            index]
                                                                        .id,
                                                                  ));
                                                        }
                                                      },
                                                      title: Container(
                                                        margin: EdgeInsets.zero,
                                                        child: new Container(
                                                          height: 100.0,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                            child: widget.items[index]?.imgCarFrontPositionRight != null
                                                                                ? Image.network("${widget.items[index]?.imgCarFrontPositionRight}", width: 60, height: 60, fit: BoxFit.cover)
                                                                                : Image.asset(
                                                                                    ImagePath.thumb,
                                                                                    width: 60,
                                                                                    height: 60,
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Text(
                                                                                          widget.items[index]?.licensePlates != null ? '${widget.items[index]?.licensePlates}' : '---',
                                                                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 8.0,
                                                                                        ),
                                                                                        Text(
                                                                                          widget.items[index]?.customer?.fullName != null ? widget.items[index]?.customer?.fullName : '---',
                                                                                          style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Stack(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  children: <Widget>[
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      children: <Widget>[
                                                                                        Text(
                                                                                          widget.items[index]?.status == 'COMPLETED' ? Strings.completed : (widget.items[index]?.status == 'DRAFT' ? Strings.draft : (widget.items[index]?.status == 'REJECTED' ? Strings.rejected : (widget.items[index]?.status == 'APPROVED' ? Strings.approved : Strings.deactive))),
                                                                                          style: TextStyle(color: widget.items[index]?.status == 'COMPLETED' ? Colors.green[800] : (widget.items[index]?.status == 'DRAFT' ? Colors.orange : (widget.items[index]?.status == 'REJECTED' ? Colors.red : (widget.items[index]?.status == 'APPROVED' ? Colors.lightBlue : Colors.red[200])))),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 8.0,
                                                                                        ),
                                                                                        Text(
                                                                                          widget.items[index]?.createdAt != null
                                                                                              ?
                                                                                              // '${DateFormat.yMd().format(DateTime.parse('${widget.items[index]?.createdAt}'))}'
                                                                                              // '${DateTime.parse()}'
                                                                                              '${DateTime.parse('${widget.items[index]?.createdAt}').day}/${DateTime.parse('${widget.items[index]?.createdAt}').month}/${DateTime.parse('${widget.items[index]?.createdAt}').year}'
                                                                                              : '---',
                                                                                          style: TextStyle(color: Colors.blue[600]),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  :

                                                  ///TODO List doc offline
                                                  ListProfileOffline(
                                                      widget.items[index],
                                                      index),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ]))
                                ],
                              )),
                        ))),
          isLoading ? LoadingStypeLine() : SizedBox()
        ],
      ),
    );
  }
}

class RIKeys {
  static final riKey1 = const Key('__RIKEY_PROFILE__');
}
