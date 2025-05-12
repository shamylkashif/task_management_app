import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../models/task.dart';
import '../../provider/auth-provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../view/home/widgets/task_widget.dart';
import '../../view/tasks/task_view.dart';
import '../../utils/strings.dart';
import '../../main.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();

  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

        return Scaffold(
          backgroundColor: Colors.white,
          // ✅ Floating Action Buttons
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: _buildFloatingActionButtons(),

          // ✅ Use built-in AppBar
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(CupertinoIcons.trash, color: Colors.black, size: 30),
                onPressed: () {
                  base.dataStore.box.isEmpty
                      ? warningNoTask(context)
                      : deleteAllTask(context);
                },
              ),
            ],
          ),

          drawer: MySlider(),

          body: Column(
            children: [
              _buildTopSection(tasks, textTheme),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(thickness: 2, indent: 100),
              ),
              Expanded(
                child: tasks.isNotEmpty
                    ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task = tasks[index];
                    return Dismissible(
                      direction: DismissDirection.horizontal,
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete_outline, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(MyString.deletedTask, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      onDismissed: (direction) {
                        base.dataStore.dalateTask(task: task);
                      },
                      key: Key(task.id),
                      child: TaskWidget(task: task),
                    );
                  },
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeIn(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          lottieURL,
                          animate: tasks.isNotEmpty ? false : true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInUp(
                      from: 30,
                      child: const Text(MyString.doneAllTask),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopSection(List<Task> tasks, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
      width: double.infinity,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(MyColors.primaryColor),
              backgroundColor: Colors.grey,
              value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
            ),
          ),
          const SizedBox(width: 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MyString.mainTitle, style: textTheme.displayLarge),
              const SizedBox(height: 3),
              Text("${checkDoneTask(tasks)} of ${tasks.length} task", style: textTheme.titleMedium),
            ],
          )
        ],
      ),
    );
  }

  // Floating Action Buttons including Logout
  Widget _buildFloatingActionButtons() {
    final AuthProvider authProvider = AuthProvider();
    return Stack(
      children: [
        Positioned(
          right: 260, // Move the logout button to the opposite side of the FAB
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () async {
              await  authProvider.signOut();
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.logout),
          ),
        ),
        Positioned(
          right: 20, // Position of the original FAB
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => TaskView(
                    taskControllerForSubtitle: null,
                    taskControllerForTitle: null,
                    task: null,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

// My Slider Drawer remains the same
class MySlider extends StatelessWidget {
  MySlider({Key? key}) : super(key: key);

  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: MyColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/img/main.png'),
          ),
          const SizedBox(
            height: 8,
          ),
          Text("Shamyl Kashif", style: textTheme.displayMedium),
          Text("Flutter Intern", style: textTheme.displaySmall),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () => print("$i Selected"),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: Icon(
                        icons[i],
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        texts[i],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
