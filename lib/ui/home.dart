import 'package:flutter/material.dart';
import 'package:testeins/model/einkaufen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingToDo extends StatefulWidget {
  const ShoppingToDo({Key? key}) : super(key: key);

  @override
  State<ShoppingToDo> createState() => _ShoppingToDoState();
}

class _ShoppingToDoState extends State<ShoppingToDo> {
  List<ShoppingItem> liste = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> amountControllers = [];

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in amountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Einkaufsliste',
            style: TextStyle(color: Color(0xFF2f2d7d), fontSize: 30),
          ),
          backgroundColor: Color(0xFFffcdb2),
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                thickness: 10,
                radius: Radius.circular(5),
                interactive: true,
                child: ListView.builder(
                  itemCount: liste.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Cette vérification est necessaire pour ajouter ch
                    if (index >= nameControllers.length) {
                      nameControllers.add(TextEditingController());
                    }
                    if (index >= amountControllers.length) {
                      amountControllers.add(TextEditingController());
                    }
                    return Hinzufuegen(index);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 50,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFffcdb2)),
                ),
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    liste.add(ShoppingItem("", 0, false));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding Hinzufuegen(int index) {
    // return Slidable(
    //   actionPane: SlidableDrawerActionPane(),
    //   secondaryActions: [
    //     IconSlideAction(
    //       caption: 'Löschen',
    //       color: Colors.red,
    //       icon: Icons.delete,
    //       onTap: () {
    //         setState(() {
    //           liste.removeAt(index);
    //           nameControllers.removeAt(index);
    //           amountControllers.removeAt(index);
    //         });
    //       },
    //     ),
    //   ],
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: ListTile(
                minLeadingWidth: 30,
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Item',
                  ),
                  style: TextStyle(
                    decoration: liste[index].isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  controller: nameControllers[index],
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      setState(() {
                        liste[index].name = '';
                      });
                    } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                      setState(() {
                        liste[index].name = value;
                      });
                    } else {
                      PopupName();
                      nameControllers[index].clear();
                    }
                  },
                ),
                leading: Container(
                  width: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      // labelStyle: TextStyle(fontSize: 15),
                      hintText: 'Amount',
                    ),
                    controller: amountControllers[index],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (RegExp(r'^\d{1,2}$').hasMatch(value.toString())) {
                        setState(() {
                          liste[index].amount = int.parse(value);
                        });
                      } else {
                        PopupMenge();
                        amountControllers[index].clear();
                      }
                    },
                  ),
                ),
                trailing: Container(
                  width: 20,
                  child: Checkbox(
                    value: liste[index].isChecked,
                    onChanged: (value) {
                      if (liste[index].name.isNotEmpty &&
                          liste[index].amount > 0) {
                        setState(() {
                          liste[index].isChecked = value!;
                        });
                      } else {
                        PopupCheckbox();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            // delete Part
            width: 50,
            height: 70,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: Icon(Icons.delete, color: Color(0xFF2f2d7d), size: 25.0),
              onPressed: () {
                setState(() {
                  liste.removeAt(index);
                  nameControllers.removeAt(index);
                  amountControllers.removeAt(index);
                });
              },
            ),
          ),
        ],
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
