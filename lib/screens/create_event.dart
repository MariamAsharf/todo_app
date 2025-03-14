import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/provider/create_event_provider.dart';
import 'package:todo_app/widgets/select_category_item.dart';

import '../firebase/firebase_manager.dart';

class CreateEvent extends StatelessWidget {
  static const String routeName = "Create Event";

  CreateEvent({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateEventProvider(),
      builder: (context, child) {
        var provider = Provider.of<CreateEventProvider>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "Create Event",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/${provider.categoryItems[provider.selectedCategory]}.png",
                      height: 170,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.changeCategoru(index);
                          },
                          child: SelectCategoryItem(
                            text: provider.categoryItems[index],
                            isSelected: provider.selectedCategory == index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemCount: provider.categoryItems.length,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).hintColor),
                    decoration: InputDecoration(
                      labelText: "Event Title",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).hintColor),
                      prefixIcon: Icon(
                        Icons.edit_note,
                        color: Theme.of(context).focusColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).hintColor),
                    decoration: InputDecoration(
                      labelText: "Event Description",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).hintColor,
                      ),
                      SizedBox(width: 2.5),
                      Text(
                        "Event Date",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          var date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now().subtract(
                              Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              Duration(days: 365),
                            ),
                          );
                          if (date != null) {
                            provider.changeData(date);
                          }
                        },
                        child: Text(
                          "${provider.selectedDate.toString().substring(0, 10)}",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      SizedBox(width: 2.5),
                      Text(
                        "Event Time",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                      Text(
                        "Choose Time",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).scaffoldBackgroundColor,
                      ),
                      side: WidgetStatePropertyAll(
                        BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(Icons.my_location,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Choose Event Location",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).primaryColor)
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                      TaskModel model = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: provider.selectedDate.millisecondsSinceEpoch,
                          category: provider.selectedCategoryName,
                      );
                      FirebaseManager.addEvent(model).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "Add Event",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
