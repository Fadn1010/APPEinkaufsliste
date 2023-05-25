import 'package:flutter/material.dart';
import 'package:testeins/model/einkaufen.dart';
import 'package:testeins/ui/ui_shopping.dart';


//import 'package:flutter_slidable/flutter_slidable.dart';

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
      appBar: AppDesign(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildListView(),
            const SizedBox(height: 20),
            buildPlusButton(),
          ],
        ),
      ),
    );
  }

  Widget buildPlusButton() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(const Color(0xFFffcdb2)),
        ),
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            liste.add(ShoppingItem("", 0, false));
          });
        },
      ),
    );
  }

  Widget buildListView (){
    return Expanded(
      child: Scrollbar(
        trackVisibility: true,
        thumbVisibility: true,
        thickness: 10,
        radius: const Radius.circular(5),
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
            return buildListItem(index);
          },
        ),
      ),
    );
  }

  Widget  buildListItem(int index) {
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
                leading: Container(
                  // Anfang
                  width: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    controller: amountControllers[index],
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        setState(() {
                          liste[index].amount = 0;
                        });
                      } else if (RegExp(r'^\d{1,2}$')
                          .hasMatch(value.toString())) {
                        setState(() {
                          liste[index].amount = int.parse(value);
                        });
                      } else {
                        showAmountPopup();
                        amountControllers[index].clear();
                      }
                    },
                  ),
                ),
                title: TextField(
                  //Mitte
                  decoration: const InputDecoration(
                    hintText: 'Item',
                    hintStyle: TextStyle(fontSize: 12),
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
                      showNamePopup();
                      nameControllers[index].clear();
                    }
                  },
                ),
                trailing: Container(
                  //Ende
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
                        showCheckboxPopup();
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
              child: const Icon(Icons.delete, color: Color(0xFF2f2d7d), size: 25.0),
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

  void showAmountPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("The entered value is not a number. Please correct it."),
        actions: [
          createCloseButton(context),
        ],
      ),
    );
  }

  void showNamePopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Please enter a correct name for the shopping item."),
        actions: [
          createCloseButton(context),
        ],
      ),
    );
  }

  void showCheckboxPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text("Please enter an amount and the name of the shopping item."),
        actions: [
          createCloseButton(context),
        ],
      ),
    );
  }
}
