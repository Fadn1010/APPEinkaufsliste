import 'package:flutter/material.dart';
import 'package:testeins/model/einkaufen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoEinkaufen extends StatefulWidget {
  const ToDoEinkaufen({Key? key}) : super(key: key);

  @override
  State<ToDoEinkaufen> createState() => _ToDoEinkaufenState();
}

class _ToDoEinkaufenState extends State<ToDoEinkaufen> {
  List<ArtikelListe> liste = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Einkaufsliste',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          backgroundColor: Color(0xFFffcdb2),
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: liste.length,
                itemBuilder: (BuildContext context, int index) {
                  return Hinzufuegen(index);
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 80,
              height: 80,
              child: ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  shape: MaterialStateProperty.all(CircleBorder()),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFffcdb2)),
                ),
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    liste.add(ArtikelListe("", 0,
                        false)); // Füge ein Listenelement mit leerem Namen, Menge und nicht ausgewähltem Zustand hinzu
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Slidable Hinzufuegen(int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Löschen',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              liste.removeAt(index);
            });
          },
        ),
      ],
      child: ListTile(
        title: TextField(
          // in der Mitte
          onChanged: (value) {
            if (RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
              setState(() {
                liste[index].name = value;
              });
            } else {
              PopupName();
              setState(() {
                liste[index].name = "";
              });
            }
          },
          decoration: InputDecoration(
            labelText: 'Einkaufsliste Name',
          ),
        ),
        leading: Container(
          // am Ende
          width: 100,
          child: TextField(
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (RegExp(r'^\d{1,2}$').hasMatch(value.toString())) {
                setState(() {
                  liste[index].menge = int.parse(value);
                });
              } else {
                PopupMenge();
              }
            },
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 15),
              labelText: 'Menge',
            ),
          ),
        ),
        trailing: Checkbox(
          // am Anfang
          value: liste[index].checked, // Verwende den Wert aus der ArtikelListe
          onChanged: (value) {
            if (liste[index].name != null &&
                liste[index].name.isNotEmpty &&
                liste[index].menge != null &&
                liste[index].menge > 0) {
              // Führen Sie den Code aus, wenn liste[index].name und liste[index].menge nicht leer oder null sind
              setState(() {
                liste[index].checked = value!;
              });
            } else {
              PopupCheckbox();
            }
          },
        ),
      ),
    );
  }

  void PopupMenge() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Der eingegebene Wert ist keine Zahl. Bitte korrigieren."),
        actions: [
          ElevatedButton(
            child: Text("close"),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                // liste[index].menge = // Das Mengenfeld leeren
              });
            },
          ),
        ],
      ),
    );
  }

  void PopupName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            "Bitte einen Namen des Einkaufsartikels ein. Bitte korrigieren."),
        actions: [
          ElevatedButton(
            child: Text("close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void PopupCheckbox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            "Bitte gib eine Menge und den Namen des Einkaufsartikels ein."),
        actions: [
          ElevatedButton(
            child: Text("close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
