import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
import 'package:mobile/src/app/pages/profile/profile_controller.dart';
import 'package:mobile/src/app/pages/profile/view/profile_car_detail.view.dart';
import 'package:mobile/src/app/pages/profile/view/profile_customer_detail.view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class ProfileDetail extends View {
  int idDoc;
  int idOwner;
  ProfileDetail({Key key, this.idDoc, this.idOwner}) : super(key: key);

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends ViewState<ProfileDetail, ProfileController> {
  _ProfileDetailState() : super(ProfileController(ProfileRepository()));
  bool isOwner = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getProfileById(widget.idDoc, controller));
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserOwner());
  }

  Future<void> checkUserOwner() async {
    final resultIsOwner = await Utils.isUserCanAction(widget.idOwner);
    isOwner = resultIsOwner;
    setState(() {
      isOwner = resultIsOwner;
    });
  }

  Future getProfileById(int idDoc, ProfileController controller) async {
    await controller.getDocumentByIdController(idDoc);
  }

  @override
  Widget buildPage() {
    // TODO: implement buildPage
    final data = controller.profileDetailResponse?.result;
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[100],
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.keyboard_backspace, size: 30.0),
                  color: Colors.white,
                ),
                Text(
                  data?.id != null ? '${Strings.profile} ${data?.id}' : '---',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ],
            ),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
               IconButton(
                 onPressed: () => getProfileById(widget.idDoc, controller),
                 icon: const Icon(Icons.refresh, size: 30.0),
                 color: Colors.white,
               ),
              data?.status != Constant.STATUS_PROFILE_APPROVED && isOwner
                  ? IconButton(
                      onPressed: () {
                        final newDataNeedUpdate = new CarProfileData();
                        List<String> imgsOption = [];
                        newDataNeedUpdate.id = data?.id;
                        newDataNeedUpdate.latitude = data?.latitude;
                        newDataNeedUpdate.longitude = data?.longitude;
                        newDataNeedUpdate.customerId = data?.customer?.id;
                        newDataNeedUpdate.licensePlates = data?.licensePlates;
                        newDataNeedUpdate.chassisNumber = data?.chassisNumber;
                        newDataNeedUpdate.vehicleNumber = data?.vehicleNumber;
                        newDataNeedUpdate.printeMattersNumber =
                            data?.printeMattersNumber;
                        newDataNeedUpdate.contractNumber = data?.contractNumber;
                        newDataNeedUpdate.effectiveDate = data?.effectiveDate;
                        newDataNeedUpdate.priceCar = data?.priceCar;
                        if (data?.manufacturingYear != null) {
                          newDataNeedUpdate.manufacturingYear =
                              data?.manufacturingYear;
                        } else {
                          newDataNeedUpdate.manufacturingYear = 0;
                        }
                        newDataNeedUpdate.usedYear = data?.usedYear;
                        newDataNeedUpdate.vehicleStatus = data?.vehicleStatus;
                        newDataNeedUpdate.scratches = data?.scratches;
                        newDataNeedUpdate.upgradeCar = data?.upgradeCar;
                        newDataNeedUpdate.note = data?.note;
                        newDataNeedUpdate.typeCar =
                            data?.carCategory?.parent?.name;
                        newDataNeedUpdate.cylinder = data?.cylinder;
                        newDataNeedUpdate.categoryId = data?.carCategory?.id;
                        newDataNeedUpdate.car = data?.carCategory?.name;
                        newDataNeedUpdate.imgCarFrontPositionRight =
                            data?.imgCarFrontPositionRight;
                        newDataNeedUpdate.imgCarFrontPositionLeft =
                            data?.imgCarFrontPositionLeft;
                        newDataNeedUpdate.imgCarRearPositionLeft =
                            data?.imgCarRearPositionLeft;
                        newDataNeedUpdate.imgCarRearPositionRight =
                            data?.imgCarRearPositionRight;
                        newDataNeedUpdate.imgChassis = data?.imgChassis;
                        newDataNeedUpdate.imgWindshield = data?.imgWindshield;
                        newDataNeedUpdate.video = data?.video;
                        newDataNeedUpdate.videoThumbnail = data?.video;
                        newDataNeedUpdate.status = data?.status;
                        newDataNeedUpdate.vehicleStatusIsNormal =
                            data.vehicleStatusIsNormal;
                        newDataNeedUpdate.isScratched = data.isScratched;
                        newDataNeedUpdate.extraAccessories =
                            data.extraAccessories;
                        if (data?.imageExtends.length > 0) {
                          data?.imageExtends
                              .map((item) => imgsOption.add(item.url))
                              .toList();
                          newDataNeedUpdate.imageOptions = imgsOption;
                        }
                        List<String> listImagesExtendID = [];
                        newDataNeedUpdate.listImagesExtendID =
                            listImagesExtendID;
                        data?.imageExtends?.forEach((element) {
                          listImagesExtendID.add(element.id.toString());
                        });
                        NavigatorUtilities.push(
                            context,
                            CarInfoPage(
                              data: newDataNeedUpdate,
                              profileId: '${widget.idDoc}',
                              isUpdate: Constant.flag_update_ioc,
                            ));
                      },
                      icon: const Icon(Icons.edit, size: 30.0),
                      color: Colors.white,
                    )
                  : SizedBox(),
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.orange,
                  width: 2.0,
                ),
              )),
              tabs: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: Text(
                        Strings.CUSTOMER,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: Text(
                        Strings.CAR,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: data != null
              ? TabBarView(
                  children: [
                    ProfileCustomerDetailPage(data),
                    ProfileDetailCarPage(data),
                  ],
                )
              : SizedBox(),
        ),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
