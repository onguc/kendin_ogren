import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/repo/folder_repo.dart';

class DropDownButtonFolder extends StatefulWidget {
  DropDownButtonFolder();

  Folder _selectedFolder;

  Future<Folder> selectedFolder() async {
    if (_selectedFolder == null)
      return await _selectedFolder;
    else {
      return _selectedFolder;
    }
  }

  @override
  _DropDownButtonFolderState createState() => _DropDownButtonFolderState();
}

class _DropDownButtonFolderState extends State<DropDownButtonFolder> {
  List<DropdownMenuItem<Folder>> dropDownMenuOptions = [];

  @override
  Future<void> initState() {
    fillFolderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Folder>(
        isExpanded: true,
        value: widget._selectedFolder,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        elevation: 54,
        underline: Container(
          height: 1,
          color: Colors.blue,
        ),
        onChanged: (Folder data) {
          setState(() {
            widget._selectedFolder = data;
          });
        },
        items: dropDownMenuOptions);
  }

  fillFolderList() async {
    FolderRepo folderRepo = FolderRepo();
    List<Folder> folders = await folderRepo.getAll();
    setState(() {
      if (folders == null) {
        folders = [];
      } else {
        widget._selectedFolder = folders[0];
      }

      dropDownMenuOptions =
          folders.map<DropdownMenuItem<Folder>>((Folder folder) {
        return DropdownMenuItem<Folder>(
          value: folder,
          child: Text(folder.name),
        );
      }).toList();
    });
//    List<Folder> folders = [];
//    Folder folder1 = Folder();
//    folder1.id = 1;
//    folder1.name = 'test1';
//    folders.add(folder1);
//
//    Folder folder2 = Folder();
//    folder2.id = 2;
//    folder2.name = 'test2';
//    folders.add(folder2);
  }
}
