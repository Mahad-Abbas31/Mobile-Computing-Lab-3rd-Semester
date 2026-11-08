
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Employee {
  int id;
  String name;
  String email;
  String phone;
  String gender;
  String department;
  DateTime joiningDate;
  double salary;
  bool active;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.department,
    required this.joiningDate,
    required this.salary,
    required this.active,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Employee> employees = [
    Employee(
      id: 1,
      name: 'Mahad Abbas',
      email: 'ali@example.com',
      phone: '03001234567',
      gender: 'Male',
      department: 'IT',
      joiningDate: DateTime(2025, 1, 15),
      salary: 80000,
      active: true,
    ),
    Employee(
      id: 2,
      name: 'Sara',
      email: 'sara@example.com',
      phone: '03111234567',
      gender: 'Female',
      department: 'HR',
      joiningDate: DateTime(2025, 5, 10),
      salary: 65000,
      active: true,
    ),
  ];

  int nextId = 3;
  PersistentBottomSheetController? sheetController;

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void addEmployee() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return EmployeeForm(
          onCancel: () => Navigator.pop(sheetContext),
          onSave: (employee) {
            setState(() {
              employee.id = nextId++;
              employees.add(employee);
            });
            Navigator.pop(sheetContext);
            showMessage('Employee added successfully');
          },
        );
      },
    );
  }

  void editEmployee(Employee employee) {
    sheetController = Scaffold.of(context).showBottomSheet(
      (sheetContext) {
        return EmployeeForm(
          employee: employee,
          onCancel: () => sheetController?.close(),
          onSave: (updated) {
            setState(() {
              final index =
                  employees.indexWhere((e) => e.id == updated.id);
              if (index != -1) {
                employees[index] = updated;
              }
            });
            sheetController?.close();
            showMessage('Employee updated successfully');
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      enableDrag: true,
    );
  }

  void deleteEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Employee?'),
        content: Text('Delete ${employee.name} from the records?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                employees.removeWhere((e) => e.id == employee.id);
              });
              Navigator.pop(dialogContext);
              showMessage('Employee deleted successfully');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (tabContext) => Scaffold(
          appBar: AppBar(
            title: const Text('Employee Management'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.people), text: 'Employees'),
                Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              employees.isEmpty
                  ? const Center(child: Text('No employees found'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final employee = employees[index];

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(employee.name[0]),
                            ),
                            title: Text(employee.name),
                            subtitle: Text(
                              '${employee.department} • '
                              'Rs. ${employee.salary.toInt()}\n'
                              '${employee.active ? 'Active' : 'Inactive'}',
                            ),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EmployeeDetails(
                                    employee: employee,
                                  ),
                                ),
                              );
                            },
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  editEmployee(employee);
                                } else if (value == 'delete') {
                                  deleteEmployee(employee);
                                }
                              },
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              AnalyticsView(employees: employees),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: addEmployee,
            icon: const Icon(Icons.add),
            label: const Text('Add Employee'),
          ),
        ),
      ),
    );
  }
}

class EmployeeForm extends StatefulWidget {
  final Employee? employee;
  final ValueChanged<Employee> onSave;
  final VoidCallback onCancel;

  const EmployeeForm({
    super.key,
    this.employee,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  late String gender;
  late String department;
  late DateTime joiningDate;
  late double salary;
  late bool active;

  final departments = [
    'IT',
    'HR',
    'Finance',
    'Marketing',
    'Sales',
  ];

  @override
  void initState() {
    super.initState();

    final e = widget.employee;

    nameController = TextEditingController(text: e?.name ?? '');
    emailController = TextEditingController(text: e?.email ?? '');
    phoneController = TextEditingController(text: e?.phone ?? '');

    gender = e?.gender ?? 'Male';
    department = e?.department ?? 'IT';
    joiningDate = e?.joiningDate ?? DateTime.now();
    salary = e?.salary ?? 50000;
    active = e?.active ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: joiningDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted) {
      setState(() {
        joiningDate = date;
      });
    }
  }

  void submitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final old = widget.employee;

    final employee = Employee(
      id: old?.id ?? 0,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      gender: gender,
      department: department,
      joiningDate: joiningDate,
      salary: salary,
      active: active,
    );

    widget.onSave(employee);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.employee == null
                    ? 'Add Employee'
                    : 'Edit Employee',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter employee name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^\d{10,15}$')
                          .hasMatch(value.trim())) {
                    return 'Enter 10–15 digits without spaces';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              const Text('Gender'),
              RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: gender,
                onChanged: (value) {
                  setState(() => gender = value!);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: gender,
                onChanged: (value) {
                  setState(() => gender = value!);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              RadioListTile<String>(
                title: const Text('Other'),
                value: 'Other',
                groupValue: gender,
                onChanged: (value) {
                  setState(() => gender = value!);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),

              DropdownButtonFormField<String>(
                value: department,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                items: departments.map((d) {
                  return DropdownMenuItem(
                    value: d,
                    child: Text(d),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => department = value);
                  }
                },
              ),
              const SizedBox(height: 12),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Joining Date'),
                subtitle: Text(
                  '${joiningDate.day}/'
                  '${joiningDate.month}/'
                  '${joiningDate.year}',
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: chooseDate,
              ),

              Text('Salary: Rs. ${salary.toInt()}'),
              Slider(
                value: salary,
                min: 20000,
                max: 200000,
                divisions: 36,
                label: salary.toInt().toString(),
                onChanged: (value) {
                  setState(() => salary = value);
                },
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Employment Status'),
                subtitle: Text(active ? 'Active' : 'Inactive'),
                value: active,
                onChanged: (value) {
                  setState(() => active = value);
                },
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onCancel,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: submitForm,
                      child: Text(
                        widget.employee == null ? 'Add' : 'Update',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeDetails extends StatelessWidget {
  final Employee employee;

  const EmployeeDetails({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                employee.name[0],
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 20),
            detail('Name', employee.name),
            detail('Email', employee.email),
            detail('Phone', employee.phone),
            detail('Gender', employee.gender),
            detail('Department', employee.department),
            detail(
              'Joining Date',
              '${employee.joiningDate.day}/'
                  '${employee.joiningDate.month}/'
                  '${employee.joiningDate.year}',
            ),
            detail('Salary', 'Rs. ${employee.salary.toInt()}'),
            detail(
              'Status',
              employee.active ? 'Active' : 'Inactive',
            ),
          ],
        ),
      ),
    );
  }

  Widget detail(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }
}

class AnalyticsView extends StatelessWidget {
  final List<Employee> employees;

  const AnalyticsView({
    super.key,
    required this.employees,
  });

  @override
  Widget build(BuildContext context) {
    final activeCount = employees.where((e) => e.active).length;
    final inactiveCount = employees.length - activeCount;

    final departmentCounts = <String, int>{};

    for (final employee in employees) {
      departmentCounts[employee.department] =
          (departmentCounts[employee.department] ?? 0) + 1;
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            statCard('Total', employees.length),
            statCard('Active', activeCount),
            statCard('Inactive', inactiveCount),
          ],
        ),
        const SizedBox(height: 24),

        Text(
          'Employee Records',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        if (employees.isEmpty)
          const Text('No records available')
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Salary')),
                DataColumn(label: Text('Status')),
              ],
              rows: employees.map((e) {
                return DataRow(
                  cells: [
                    DataCell(Text(e.name)),
                    DataCell(Text(e.department)),
                    DataCell(Text(e.salary.toInt().toString())),
                    DataCell(Text(e.active ? 'Active' : 'Inactive')),
                  ],
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 24),
        Text(
          'Department Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        ...departmentCounts.entries.map((entry) {
          return ListTile(
            leading: const Icon(Icons.business),
            title: Text(entry.key),
            trailing: Text('${entry.value} employees'),
          );
        }),
      ],
    );
  }

  Widget statCard(String title, int count) {
    return SizedBox(
      width: 140,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title),
              const SizedBox(height: 8),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}