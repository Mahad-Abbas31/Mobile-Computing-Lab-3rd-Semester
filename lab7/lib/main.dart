
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> students = ['Ali', 'Mahad Abbas', 'Sara', 'Ahmed', 'Usman'];

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isStudent = false;
  String gender = 'Male';
  String course = 'Flutter';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double volume = 50;
  String result = '';

  void addStudent() {
    setState(() {
      students.add('Student ${students.length + 1}');
    });
  }

  void pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void submitForm() {
    setState(() {
      result = 'Name: ${nameController.text}\n'
          'Email: ${emailController.text}\n'
          'Student: ${isStudent ? "Yes" : "No"}\n'
          'Gender: $gender\n'
          'Course: $course\n'
          'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}\n'
          'Time: ${selectedTime.format(context)}\n'
          'Slider: ${volume.round()}';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Students (${students.length})'),
          backgroundColor: const Color.fromARGB(255, 255, 135, 165),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(text: 'Profile', icon: Icon(Icons.person)),
              Tab(text: 'Settings', icon: Icon(Icons.settings)),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // HOME TAB
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Students List',
                    style: TextStyle(fontSize: 22)),

                ...students.map((name) => ListTile(
                      leading: CircleAvatar(child: Text(name[0])),
                      title: Text(name),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$name selected')),
                        );
                      },
                    )),

                const Divider(),
                const Text('Student Registration',
                    style: TextStyle(fontSize: 22)),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),

                CheckboxListTile(
                  title: const Text('Are you a student?'),
                  value: isStudent,
                  onChanged: (value) {
                    setState(() => isStudent = value!);
                  },
                ),

                const Text('Gender'),

                RadioListTile(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() => gender = value!);
                  },
                ),

                RadioListTile(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() => gender = value!);
                  },
                ),

                const Text('Course'),

                DropdownButton<String>(
                  value: course,
                  isExpanded: true,
                  items: ['Flutter', 'Java', 'Python', 'C++']
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => course = value!);
                  },
                ),

                ElevatedButton(
                  onPressed: pickDate,
                  child: Text(
                    'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ),

                ElevatedButton(
                  onPressed: pickTime,
                  child: Text('Time: ${selectedTime.format(context)}'),
                ),

                const Text('Slider'),

                Slider(
                  value: volume,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() => volume = value);
                  },
                ),

                Text('Value: ${volume.round()}'),

                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Submit Form'),
                ),

                if (result.isNotEmpty) Text(result),
              ],
            ),

            // PROFILE TAB
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 80),
                  Text('My Profile'),
                  Text('BS Computer Science'),
                ],
              ),
            ),

            // SETTINGS TAB
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings clicked!')),
                  );
                },
                child: const Text('Test Settings'),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: addStudent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
