import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:voyage/menu/drawer.widget.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'ajout_modif_contact.dart';

class ContactPage extends StatefulWidget {
  final ContactService contactService = ContactService();

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton(
                "Ajout",
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AjoutModifContactPage();
                  })).then((value) {
                    setState(() {});
                  });
                },
                borderRadius: 10,
                borderColor: Colors.blue,
                btnColor: Colors.blue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _fetchData(),
          ],
        ),
      ),
    );
  }

  Widget _fetchData() {
    return FutureBuilder<List<Contact>>(
      future: widget.contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) {
          return _buildDataTable(contacts.data!);
        } else if (contacts.hasError) {
          return Center(
            child: Text("Error fetching contacts"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildDataTable(List<Contact> list) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom", "Téléphone", "Action"],
        ["nom", "tel", ""],
        false,
        0,
        list,
            (Contact c) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(
                modifMode: true,
                contact: c,
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        },
            (Contact c) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Supprimer Contact"),
                content: const Text("Etes vous sûr de vouloir supprimer ce Contact"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton(
                        "Oui",
                            () {
                          widget.contactService.supprimerContact(c).then((value) {
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          });
                        },
                        width: 100,
                        borderRadius: 5,
                        btnColor: Colors.green,
                        borderColor: Colors.green,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FormHelper.submitButton(
                        "Non",
                            () {
                          Navigator.of(context).pop();
                        },
                        width: 100,
                        borderRadius: 5,
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        headingRowColor: Colors.orange,
        isScrollable: true,
        columnTextFontSize: 20,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columnName, asc) {},
      ),
    );
  }
}
