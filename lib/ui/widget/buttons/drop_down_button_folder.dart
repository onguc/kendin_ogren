import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/repo/folder_repo.dart';

class FolderDropDownButton extends StatefulWidget {
  FolderDropDownButton();

  @override
  _FolderDropDownButtonState createState() => _FolderDropDownButtonState();
}

class _FolderDropDownButtonState extends State<FolderDropDownButton> {
  List<Folder> folderList;
  Folder selectedFolder;

  @override
  void initState() {
    FolderRepo folderRepo = FolderRepo();
    setState(() async {
      folderList = await folderRepo.getAll();
      if (folderList == null) {
      } else {
        selectedFolder = folderList[0];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Folder>(
        isExpanded: true,
        itemHeight: kMinInteractiveDimension,
        value: selectedFolder,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 54,
        underline: Container(
          height: 1,
          color: Colors.blue,
        ),
        onChanged: (Folder data) {
          setState(() {
            selectedFolder = data;
          });
        },
        items: folderList.map<DropdownMenuItem<Folder>>((Folder folder) {
          return DropdownMenuItem<Folder>(
            value: folder,
            child: Text(folder.name),
          );
        }).toList());
  }

  Future<List<Folder>> getRepo() async {
    FolderRepo folderRepo = FolderRepo();
    List<Folder> folders = await folderRepo.getAll();
    if (folders == null) {
    } else {}
    return folders;
  }
}
