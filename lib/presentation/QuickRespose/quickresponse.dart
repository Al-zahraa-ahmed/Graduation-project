import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class QuickResponseScreen extends StatelessWidget {
  const QuickResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [
            Color(0xffEAEAFA),
            Color(0xffADADEB)
          ])
        ),
       ),
       Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 90,
            centerTitle: true,
            leading: Row(
              children: [
                SizedBox(width: 20),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Color(0xffD6D6F5)),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.chevron_left),
                ),
              ],
            ),
            title: Text("Quick Response", style: Textstyles.medium25),
          ),
      ),
     
      ],
    );
  }
}



class QuickResponsePage extends StatefulWidget {
  const QuickResponsePage({super.key});

  @override
  State<QuickResponsePage> createState() => _QuickResponsePageState();
}

class _QuickResponsePageState extends State<QuickResponsePage> {

  List<String> responses = [
    "I need medical help",
    "Where is the bus station?",
    "How much does this cost?",
    "Can you help me?",
    "Nice to meet you",
    "I am deaf.",
    "I feel uncomfortable",
    "I appreciate your help",
    "Call the police",
  ];

  List<int> selectedItems = [];
  bool selectionMode = false;

  void toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
      } else {
        selectedItems.add(index);
      }

      if (selectedItems.isEmpty) {
        selectionMode = false;
      }
    });
  }

  void startSelection(int index) {
    setState(() {
      selectionMode = true;
      selectedItems.add(index);
    });
  }
  void addPhrase() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Phrase"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter phrase",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    responses.add(controller.text);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [
            Color(0xffEAEAFA),
            Color(0xffADADEB)
          ])
        ),
       ),
        Scaffold(
              
         backgroundColor:  Colors.transparent,
              
         appBar: AppBar(
           centerTitle: selectionMode?null :true,
           elevation: 0,
           backgroundColor:
           Colors.transparent,
            // Colors.deepPurple,
              
           leading: selectionMode
               ? IconButton(
                   icon: const Icon(Icons.close),
                   onPressed: () {
                     setState(() {
                       selectionMode = false;
                       selectedItems.clear();
                     });
                   },
                 )
               :  IconButton(onPressed: () {
                 
               },icon:Icon(Icons.chevron_left)  ),
              
           title: Text(
             selectionMode
                 ? "${selectedItems.length} Selected"
                 : "Quick Response",
           ),
              
           actions: selectionMode
               ? [
                   TextButton(
                     onPressed: () {
                       setState(() {
                         selectedItems =
                             List.generate(responses.length, (index) => index);
                       });
                     },
                     child: const Text(
                       "Select All",
                       style: TextStyle(color: Colors.black),
                     ),
                   )
                 ]
               : [],
         ),
              
         body: ListView.builder(
           
           padding: const EdgeInsets.all(16),
           itemCount: responses.length,
           itemBuilder: (context, index) {
              
             bool isSelected = selectedItems.contains(index);
              
             return GestureDetector(
               onTap: () {
                 if (selectionMode) {
                   toggleSelection(index);
                 } else {
                   print("Clicked ${responses[index]}");
                 }
               },
              
               onLongPress: () {
                 startSelection(index);
               },
              
               child: Container(
                 margin: const EdgeInsets.only(bottom: 14),
                 padding: const EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 16,
                 ),
              
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(.08),
                       blurRadius: 8,
                       offset: const Offset(0, 3),
                     )
                   ],
                 ),
              
                 child: Row(
                   children: [
              
                     if (selectionMode)
                       Icon(
                         isSelected
                             ? Icons.check_circle
                             : Icons.circle_outlined,
                         color: Colors.deepPurple,
                       )
                     else
                       const Icon(
                         Icons.record_voice_over,
                         color: Colors.deepPurple,
                       ),
              
                     const SizedBox(width: 12),
              
                     Expanded(
                       child: Text(
                         responses[index],
                         style: const TextStyle(
                           color: Color(0xff5B5BD7),
                           fontSize: 20,
                           fontWeight: FontWeight.w500,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             );
           },
         ),
              
         bottomNavigationBar: selectionMode
             ? Container(
                 height: 70,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.vertical(
                     top: Radius.circular(20),
                   ),
                   boxShadow: [
                     BoxShadow(
                       blurRadius: 10,
                       color: Colors.black12,
                     )
                   ],
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
              
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: const [
                         Icon(Icons.delete, color: Colors.deepPurple),
                         SizedBox(height: 4),
                         Text("Delete")
                       ],
                     ),
              
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: const [
                         Icon(Icons.edit, color: Colors.deepPurple),
                         SizedBox(height: 4),
                         Text("Edit")
                       ],
                     ),
              
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: const [
                         Icon(Icons.push_pin, color: Colors.deepPurple),
                         SizedBox(height: 4),
                         Text("Pin")
                       ],
                     ),
                   ],
                 ),
               )
             : Container(
               padding: const EdgeInsets.all(16),
               color: Colors.transparent,
               child: GestureDetector(
                 onTap: addPhrase,
                 child: Container(
                   padding: EdgeInsets.only(left: 12),
                   height: 50,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(25),
                     border: Border.all(color: Colors.white),
                   ),
                   child: const Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Icon(Icons.add, color: Colors.white),
                       SizedBox(width: 8),
                       Text(
                         "Add Your Phrase",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                         ),
                       ),
                     ],
                   ),
                 ),
               )),
              ),
        ],
      ),
    );
  }
}