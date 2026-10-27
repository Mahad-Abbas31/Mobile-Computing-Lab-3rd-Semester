
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartCampusApp());
}

// Root application with light and dark theme support.
class SmartCampusApp extends StatefulWidget {
  const SmartCampusApp({super.key});

  @override
  State<SmartCampusApp> createState() => _SmartCampusAppState();
}

class _SmartCampusAppState extends State<SmartCampusApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Campus',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: CampusHome(
        isDark: isDark,
        onThemeChanged: (value) {
          setState(() => isDark = value);
        },
      ),
    );
  }
}

// Main screen with four tabs and drawer navigation.
class CampusHome extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const CampusHome({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<CampusHome> createState() => _CampusHomeState();
}

class _CampusHomeState extends State<CampusHome> {
  final List<Map<String, String>> students = [
    {'name': 'Mahad Abbas', 'degree': 'BS Computer Science', 'id': 'CS-101'},
    {'name': 'Sara Ahmed', 'degree': 'BS Software Engineering', 'id': 'SE-102'},
    {'name': 'Ali Khan', 'degree': 'BS Computer Science', 'id': 'CS-103'},
  ];

  final List<Map<String, String>> events = [
    {'title': 'Tech Seminar', 'date': '30 Oct 2026', 'time': '10:00 AM'},
    {'title': 'Sports Day', 'date': '02 Nov 2026', 'time': '09:00 AM'},
  ];

  final List<Map<String, String>> schedules = [
    {'course': 'Mobile Computing', 'room': 'Lab 7', 'time': '09:00 AM'},
    {'course': 'Data Structures', 'room': 'Room 12', 'time': '11:00 AM'},
    {'course': 'Database Systems', 'room': 'Room 8', 'time': '01:00 PM'},
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Modal bottom sheet for adding students or events.
  void addRecord(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return AddRecordSheet(
          type: type,
          onSave: (record) {
            setState(() {
              if (type == 'Student') {
                students.add({
                  'name': record['name']!,
                  'degree': record['degree']!,
                  'id': record['id']!,
                });
              } else {
                events.add({
                  'title': record['name']!,
                  'date': record['date']!,
                  'time': record['time']!,
                });
              }
            });

            Navigator.pop(sheetContext);
            showMessage('$type Added Successfully');
          },
        );
      },
    );
  }

  // Navigate to a separate detail screen.
  void openDetails(String title, Map<String, String> details) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(title: title, details: details),
      ),
    );
  }

  // Persistent bottom sheet for editing existing data.
  void editRecord() {
    Scaffold.of(context).showBottomSheet(
      (sheetContext) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Update Campus Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Updated announcement',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(sheetContext);
                showMessage('Update submitted');
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  // Confirm deletions with a Cupertino-style dialog.
  void confirmDelete(int index) {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Delete Student'),
        content: const Text('Are you sure you want to remove this student?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              setState(() => students.removeAt(index));
              Navigator.pop(dialogContext);
              showMessage('Student Removed Successfully');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tablet = width >= 600;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Campus'),
          actions: [
            IconButton(
              tooltip: 'Settings',
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    isDark: widget.isDark,
                    onThemeChanged: widget.onThemeChanged,
                  ),
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
              Tab(icon: Icon(Icons.school), text: 'Student'),
              Tab(icon: Icon(Icons.people), text: 'Faculty'),
              Tab(icon: Icon(Icons.admin_panel_settings), text: 'Admin'),
            ],
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.account_balance, color: Colors.white, size: 42),
                    SizedBox(height: 8),
                    Text(
                      'Smart Campus Portal',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(
                        isDark: widget.isDark,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & FAQs'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Feedback Form'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeedbackScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  showMessage('Logout requested');
                },
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // TAB 1: Dashboard
            ListView(
              padding: EdgeInsets.all(tablet ? 28 : 16),
              children: [
                Text(
                  'Campus Dashboard',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: tablet ? 4 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: tablet ? 1.6 : 1.4,
                  children: [
                    statCard('Students', '${students.length}', Icons.school),
                    statCard('Faculty', '24', Icons.people),
                    statCard('Events', '${events.length}', Icons.event),
                    statCard('Courses', '12', Icons.menu_book),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Campus Announcements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.campaign, color: Colors.teal),
                    title: Text('Midterm Examination Notice'),
                    subtitle: Text('Check the university examination schedule.'),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ...events.map(
                  (event) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.event),
                      title: Text(event['title']!),
                      subtitle: Text(
                        '${event['date']} • ${event['time']}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => openDetails('Event Details', event),
                    ),
                  ),
                ),
              ],
            ),

            // TAB 2: Student Portal
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(tablet ? 28 : 16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: tablet
                            ? Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 42,
                                    child: Text('MA', style: TextStyle(fontSize: 24)),
                                  ),
                                  const SizedBox(width: 20),
                                  profileText(),
                                ],
                              )
                            : Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 42,
                                    child: Text('MA', style: TextStyle(fontSize: 24)),
                                  ),
                                  const SizedBox(height: 12),
                                  profileText(),
                                ],
                              ),
                      ),
                      const SizedBox(height: 20),
                      const Card(
                        child: ListTile(
                          leading: Icon(Icons.check_circle, color: Colors.green),
                          title: Text('Attendance Summary'),
                          subtitle: Text('Present: 85%  |  Absent: 15%'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enrolled Courses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...schedules.map(
                        (course) => Card(
                          child: ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(course['course']!),
                            subtitle: Text('Room: ${course['room']}'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () => openDetails('Course Details', course),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // TAB 3: Faculty Portal
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Class Schedules',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...schedules.map(
                  (item) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text(item['course']!),
                      subtitle: Text('${item['time']} • ${item['room']}'),
                      onTap: () => openDetails('Class Schedule', item),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AttendanceScreen(students: students),
                    ),
                  ),
                  icon: const Icon(Icons.fact_check),
                  label: const Text('Mark Attendance'),
                ),
                const SizedBox(height: 12),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.analytics),
                    title: Text('Course Analytics'),
                    subtitle: Text('Average attendance: 85%'),
                  ),
                ),
              ],
            ),

            // TAB 4: Admin Panel
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Admin Panel',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => addRecord('Student'),
                        icon: const Icon(Icons.person_add),
                        label: const Text('Add Student'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => addRecord('Event'),
                        icon: const Icon(Icons.event),
                        label: const Text('Add Event'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: editRecord,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Existing Data'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Students List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Degree')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: List.generate(students.length, (index) {
                      final student = students[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(student['id']!)),
                          DataCell(Text(student['name']!)),
                          DataCell(Text(student['degree']!)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  tooltip: 'View details',
                                  icon: const Icon(Icons.visibility),
                                  onPressed: () => openDetails(
                                    'Student Details',
                                    student,
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Delete student',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => confirmDelete(index),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Event Records',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ...events.map(
                  (event) => ListTile(
                    leading: const Icon(Icons.event_note),
                    title: Text(event['title']!),
                    subtitle: Text('${event['date']} • ${event['time']}'),
                    onTap: () => openDetails('Event Details', event),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => showMessage('Report generated successfully'),
                  icon: const Icon(Icons.summarize),
                  label: const Text('Generate Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.teal),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 22)),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget profileText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mahad Abbas',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('BS Computer Science'),
        Text('Student ID: CS-101'),
      ],
    );
  }
}

// Reusable details screen. Navigator.pop() returns to the previous screen.
class DetailScreen extends StatelessWidget {
  final String title;
  final Map<String, String> details;

  const DetailScreen({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: details.entries.map((entry) {
          return Card(
            child: ListTile(
              title: Text(entry.key.toUpperCase()),
              subtitle: Text(entry.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Form for adding students and campus events.
class AddRecordSheet extends StatefulWidget {
  final String type;
  final ValueChanged<Map<String, String>> onSave;

  const AddRecordSheet({
    super.key,
    required this.type,
    required this.onSave,
  });

  @override
  State<AddRecordSheet> createState() => _AddRecordSheetState();
}

class _AddRecordSheetState extends State<AddRecordSheet> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  String degree = 'BS Computer Science';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.type == 'Student';

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add ${widget.type}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: isStudent ? 'Student Name' : 'Event Name',
                border: const OutlineInputBorder(),
              ),
            ),
            if (isStudent) ...[
              const SizedBox(height: 12),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: degree,
                decoration: const InputDecoration(
                  labelText: 'Degree Program',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'BS Computer Science',
                  'BS Software Engineering',
                  'BS Artificial Intelligence',
                ].map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => degree = value);
                },
              ),
            ] else ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  selectedDate == null
                      ? 'Select Event Date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),
              ),
              OutlinedButton.icon(
                onPressed: pickTime,
                icon: const Icon(Icons.access_time),
                label: Text(
                  selectedTime == null
                      ? 'Select Event Time'
                      : selectedTime!.format(context),
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty ||
                      (isStudent && idController.text.trim().isEmpty) ||
                      (!isStudent &&
                          (selectedDate == null || selectedTime == null))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error: Missing Fields')),
                    );
                    return;
                  }

                  widget.onSave({
                    'name': nameController.text.trim(),
                    'id': idController.text.trim(),
                    'degree': degree,
                    'date': selectedDate == null
                        ? ''
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    'time': selectedTime?.format(context) ?? '',
                  });
                },
                child: const Text('Save Record'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings screen with responsive layout and interactive preferences.
class SettingsScreen extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool emailUpdates = false;
  bool privateProfile = true;
  double volume = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final tablet = constraints.maxWidth >= 600;

          final options = [
            SwitchListTile(
              secondary: const Icon(Icons.notifications_active),
              title: const Text('Push Notifications'),
              subtitle: const Text('Receive campus alerts'),
              value: notifications,
              onChanged: (value) => setState(() => notifications = value),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.email_outlined),
              title: const Text('Email Updates'),
              value: emailUpdates,
              onChanged: (value) => setState(() => emailUpdates = value),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              value: widget.isDark,
              onChanged: widget.onThemeChanged,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.lock_outline),
              title: const Text('Private Profile'),
              value: privateProfile,
              onChanged: (value) => setState(() => privateProfile = value),
            ),
            ListTile(
              leading: const Icon(Icons.shield_outlined),
              title: const Text('Privacy'),
              subtitle: const Text('Manage profile visibility'),
              onTap: () => showInfo('Privacy', 'Control who can view your profile.'),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Account'),
              subtitle: const Text('Manage account information'),
              onTap: () => showInfo('Account', 'Account settings and information.'),
            ),
          ];

          return ListView(
            padding: EdgeInsets.all(tablet ? 28 : 12),
            children: [
              if (tablet)
                Center(
                  child: SizedBox(width: 700, child: Column(children: options)),
                )
              else
                ...options,
              const Divider(),
              const ListTile(
                leading: Icon(Icons.volume_up),
                title: Text('Notification Volume'),
              ),
              Slider(
                value: volume,
                min: 0,
                max: 100,
                divisions: 10,
                label: '${volume.round()}%',
                onChanged: (value) => setState(() => volume = value),
              ),
              Center(child: Text('${volume.round()}%')),
            ],
          );
        },
      ),
    );
  }

  void showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Feedback form with radio buttons and checkboxes.
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final nameController = TextEditingController();
  final feedbackController = TextEditingController();
  String rating = 'Good';
  bool facilities = false;
  bool teaching = false;
  bool appExperience = false;

  @override
  void dispose() {
    nameController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Form')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Rate your campus experience'),
          ...['Excellent', 'Good', 'Average', 'Poor'].map(
            (value) => RadioListTile<String>(
              title: Text(value),
              value: value,
              groupValue: rating,
              onChanged: (value) => setState(() => rating = value!),
            ),
          ),
          const Divider(),
          const Text('What would you like to give feedback about?'),
          CheckboxListTile(
            title: const Text('Campus Facilities'),
            value: facilities,
            onChanged: (value) => setState(() => facilities = value!),
          ),
          CheckboxListTile(
            title: const Text('Teaching'),
            value: teaching,
            onChanged: (value) => setState(() => teaching = value!),
          ),
          CheckboxListTile(
            title: const Text('App Experience'),
            value: appExperience,
            onChanged: (value) => setState(() => appExperience = value!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: feedbackController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Your Feedback',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty ||
                  feedbackController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: Missing Fields')),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback Submitted Successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit Feedback'),
          ),
        ],
      ),
    );
  }
}

// Help section with expandable FAQs.
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<bool> expanded = [false, false, false];

  final List<Map<String, String>> faqs = [
    {
      'question': 'How can I view my courses?',
      'answer': 'Open the Student tab to see enrolled courses.',
    },
    {
      'question': 'How can I report a problem?',
      'answer': 'Open the drawer and select Feedback Form.',
    },
    {
      'question': 'How can I change the theme?',
      'answer': 'Open Settings and enable or disable Dark Mode.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & FAQs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() => expanded[index] = isExpanded);
          },
          children: List.generate(faqs.length, (index) {
            return ExpansionPanel(
              isExpanded: expanded[index],
              headerBuilder: (context, isExpanded) {
                return ListTile(title: Text(faqs[index]['question']!));
              },
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(faqs[index]['answer']!),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Faculty attendance screen.
class AttendanceScreen extends StatefulWidget {
  final List<Map<String, String>> students;

  const AttendanceScreen({super.key, required this.students});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<String, bool> attendance = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...widget.students.map((student) {
            final id = student['id']!;
            return CheckboxListTile(
              title: Text(student['name']!),
              subtitle: Text(id),
              value: attendance[id] ?? true,
              onChanged: (value) => setState(() => attendance[id] = value!),
              secondary: const Icon(Icons.person),
            );
          }),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attendance Saved Successfully')),
              );
            },
            child: const Text('Save Attendance'),
          ),
        ],
      ),
    );
  }
}