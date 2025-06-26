import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/profile/data/model/group_model.dart';

class CreateGroupController extends GetxController{
  TextEditingController groupNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<GroupModel> groupList = [];
  
  void createGroup(){
    final GroupModel groupModel = GroupModel('assets/profile/image/my_group_img_1.png', "Besties", "No Description For Now", ["hilamsam19", "earthexplorer2", "quasar2read00"]);
    final GroupModel groupModel2 = GroupModel('assets/profile/image/my_group_img_2.png', "QuickReadFlows", "No Description For Now", ["hilamsam19", "quasar2read00"]);
    final GroupModel groupModel3 = GroupModel('assets/profile/image/my_group_img_3.png', "WeLoveSpace", "No Description For Now", ["earthexplorer2", "quasar2read00"]);
    groupList.addAll([groupModel, groupModel2, groupModel3]);
  }
}