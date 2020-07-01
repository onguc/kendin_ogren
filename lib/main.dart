import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/presentation/folder_icon_icons.dart';
import 'package:kendin_ogren/repo/dictionary_repo.dart';
import 'package:kendin_ogren/repo/folder_repo.dart';
import 'package:kendin_ogren/ui/widget/card_add_folder.dart';
import 'package:kendin_ogren/ui/widget/dailog/alert_dictionary.dart';
import 'package:kendin_ogren/ui/widget/dictionary_list.dart';

void main() => runApp(MaterialApp(
      home: MyStatelessWidget(),
      theme: ThemeData(
          accentColor: Colors.redAccent,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(),
              textTheme: ButtonTextTheme.normal)),
    ));

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controlDbIfFirstAppAddTestWords();

    var dictionaryList = DictionaryList(scaffoldKey: scaffoldKey);
    var dictionaryListState = dictionaryList.dictionaryListState;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      // bu kod klavye açıldığında taşmayı engeller. Bottom overflowed by 183 pixels gibi hataları giderir
      appBar: AppBar(
        title: const Text('Kendin Öğren'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_box),
            tooltip: 'Kelime Ekle',
            onPressed: () {
              createAlertDialogKelimeEkle(
                  context, dictionaryListState.addItemInListView);
            },
          ),
          IconButton(
            icon: const Icon(create_new_folder),
            tooltip: 'Klasör Ekle',
            onPressed: () {
              createAlertDialogKlasorOlustur(context);
            },
          ),
//          IconButton(
//            icon: const Icon(Icons.delete),
//            tooltip: 'Kelimeleri Sil',
//            onPressed: () {
//              dictionaryListState.deleteItems();
//            },
//          ),
        ],
      ),
      body: dictionaryList,
    );
  }

  controlDbIfFirstAppAddTestWords() async {
    FolderRepo folderRepo = FolderRepo();
    List<Folder> all = await folderRepo.getAll();
    if (all == null || all.length == 0) {
      Folder folder = Folder();
      folder.name = 'Test Klasör';
      int id = await folderRepo.add(folder);
      _addDictionaryForFirsInstallation(id);
    }
  }

  _addDictionaryForFirsInstallation(int idFolder) {
    DictionaryRepo dictionaryRepo = DictionaryRepo();
    Dictionary dictionary = Dictionary();
    dictionary.word = 'How are you';
    dictionary.explanation = 'Nasılsın';
    dictionary.idFolder = idFolder;
    for (int i = 0; i < 5; i++) {
      dictionaryRepo.add(dictionary);
    }
  }

  createAlertDialogKlasorOlustur(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Klasör Ekle"),
            content: CardAddFolder(scaffoldKey: scaffoldKey),
          );
        });
  }

  createAlertDialogKelimeEkle(
      BuildContext context, final Function addItemInListView) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertAddDictionary(addItemInListView: addItemInListView);
        }).then((value) {});
  }

//void openPage(BuildContext context) {
//  Navigator.push(context, MaterialPageRoute(
//    builder: (BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: const Text('Next page'),
//        ),
//        body: const Center(
//          child: Text(
//            'This is the next page',
//            style: TextStyle(fontSize: 24),
//          ),
//        ),
//      );
//    },
//  ));
//}
}
