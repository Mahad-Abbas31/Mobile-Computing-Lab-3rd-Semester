import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: EmployeeApp(),
));

class Employee {
  String name, gender, department;
  DateTime date;
  double salary;
  bool active;

  Employee(this.name, this.gender, this.department,
      this.date, this.salary, this.active);
}

class EmployeeApp extends StatefulWidget {
  const EmployeeApp({super.key});

  @override
  State<EmployeeApp> createState() => _EmployeeAppState();
}

class _EmployeeAppState extends State<EmployeeApp> {
  List<Employee> employees = [
    Employee('Ali', 'Male', 'IT', DateTime(2025, 1, 10), 50000, true),
    Employee('Sara', 'Female', 'HR', DateTime(2024, 5, 12), 60000, true),
  ];

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void addEmployee() {
    String name = '';
    String gender = 'Male';
    String department = 'IT';
    DateTime date = DateTime.now();
    double salary = 50000;
    bool active = true;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, refresh) => Padding(
          padding: EdgeInsets.fromLTRB(
            16, 16, 16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Add Employee',
                      style: TextStyle(fontSize: 22)),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Enter name' : null,
                    onSaved: (v) => name = v!.trim(),
                  ),
                  DropdownButtonFormField<String>(
                    value: department,
                    decoration: const InputDecoration(labelText: 'Department'),
                    items: ['IT', 'HR', 'Finance', 'Marketing']
                        .map((d) => DropdownMenuItem(
                              value: d, child: Text(d)))
                        .toList(),
                    onChanged: (v) => refresh(() => department = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (v) => refresh(() => gender = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (v) => refresh(() => gender = v!),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) refresh(() => date = picked);
                    },
                    child: Text('Joining date: ${date.day}/${date.month}/${date.year}'),
                  ),
                  Text('Salary: ${salary.round()}'),
                  Slider(
                    value: salary,
                    min: 20000,
                    max: 200000,
                    divisions: 18,
                    onChanged: (v) => refresh(() => salary = v),
                  ),
                  SwitchListTile(
                    title: const Text('Active employee'),
                    value: active,
                    onChanged: (v) => refresh(() => active = v),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      formKey.currentState!.save();
                      setState(() => employees.add(
                          Employee(name, gender, department, date, salary, active)));
                      Navigator.pop(sheetContext);
                      message('Employee added');
                    },
                    child: const Text('Save Employee'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void editEmployee(Employee e) {
    final controller = TextEditingController(text: e.name);
    String department = e.department;
    bool active = e.active;

    showBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Employee', style: TextStyle(fontSize: 20)),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            DropdownButton<String>(
              value: department,
              items: ['IT', 'HR', 'Finance', 'Marketing']
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => department = v!),
            ),
            SwitchListTile(
              title: const Text('Active'),
              value: active,
              onChanged: (v) => setState(() => active = v),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  message('Name cannot be empty');
                  return;
                }
                setState(() {
                  e.name = controller.text.trim();
                  e.department = department;
                  e.active = active;
                });
                Navigator.pop(sheetContext);
                message('Employee updated');
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void deleteEmployee(Employee e) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete employee?'),
        content: Text('Remove ${e.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => employees.remove(e));
      message('Employee deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Management'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Employees'),
            Tab(text: 'Analytics'),
          ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, i) {
              final e = employees[i];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(e.name),
                subtitle: Text(
                  '${e.department} | ${e.salary.round()} | '
                  '${e.active ? "Active" : "Inactive"}',
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: Text(e.name)),
                      body: Center(
                        child: Text(
                          'Gender: ${e.gender}\n'
                          'Department: ${e.department}\n'
                          'Joining date: ${e.date.day}/${e.date.month}/${e.date.year}\n'
                          'Salary: ${e.salary.round()}\n'
                          'Status: ${e.active ? "Active" : "Inactive"}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'Edit') editEmployee(e);
                    if (v == 'Delete') deleteEmployee(e);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'Edit', child: Text('Edit')),
                    PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  ],
                ),
              );
            },
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Status')),
              ],
              rows: employees.map((e) => DataRow(cells: [
                DataCell(Text(e.name)),
                DataCell(Text(e.department)),
                DataCell(Text(e.active ? 'Active' : 'Inactive')),
              ])).toList(),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: addEmployee,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
