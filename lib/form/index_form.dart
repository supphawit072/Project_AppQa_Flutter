import 'package:flutter/material.dart';
import 'package:test/controllers/form_controllers.dart';
import 'package:test/form/edit_form.dart';
import 'package:test/form/newform.dart';
import 'package:test/home/admin_home.dart';
import 'package:test/models/form_midel.dart';

class IndexForm extends StatefulWidget {
  const IndexForm({super.key});

  @override
  State<IndexForm> createState() => _IndexFormState();
}

class _IndexFormState extends State<IndexForm> {
  final FormController _formController = FormController();
  final TextEditingController _searchController = TextEditingController();
  FormModel? _searchedForm;

  Future<void> _searchForm(BuildContext context) async {
    try {
      final form =
          await _formController.getForm(context, _searchController.text);
      setState(() {
        _searchedForm = form;
      });
    } catch (e) {
      print(e);
      setState(() {
        _searchedForm = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteForm(BuildContext context, String formId) async {
    try {
      await _formController.deleteForm(context, formId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form deleted successfully')),
      );
      _searchForm(context); // Refresh the list after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting form: $e')),
      );
    }
  }

  void _closeSearch() {
    setState(() {
      _searchedForm = null; // Reset search to show all forms
      _searchController.clear(); // Clear the search input
    });
  }

  void _editForm(FormModel form) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFormPage(formModel: form),
      ),
    );
  }

  void _navigateToAddForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormFormScreen(), // Navigate to FormFormScreen
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(), // Navigate to HomeScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Forms',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[700],
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: _navigateToHome, // Navigate to HomeScreen
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by Form ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: () => _searchForm(context),
                ),
              ],
            ),
          ),
          if (_searchedForm != null)
            Expanded(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        'Form ID: ${_searchedForm!.formId}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Text('Curriculum: ${_searchedForm!.curriculum}'),
                          Text('Course Code: ${_searchedForm!.coursecodeFk}'),
                          Text('Course Name: ${_searchedForm!.coursenameFk}'),
                          Text('Credits: ${_searchedForm!.creditsFk}'),
                          Text('Group: ${_searchedForm!.groupsFk}'),
                          Text('Instructor: ${_searchedForm!.instructorFk}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editForm(_searchedForm!);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteForm(context, _searchedForm!.formId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _closeSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[700],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ปิด',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: FutureBuilder<List<FormModel>>(
                future: _formController.getForms(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No forms available'));
                  } else {
                    final forms = snapshot.data!;
                    return ListView.builder(
                      itemCount: forms.length,
                      itemBuilder: (context, index) {
                        final form = forms[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              'Form ID: ${form.formId}',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8.0),
                                Text('Curriculum: ${form.curriculum}'),
                                Text('Course Code: ${form.coursecodeFk}'),
                                Text('Course Name: ${form.coursenameFk}'),
                                Text('Credits: ${form.creditsFk}'),
                                Text('Group: ${form.groupsFk}'),
                                Text('Instructor: ${form.instructorFk}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _editForm(form);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _deleteForm(context, form.formId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _navigateToAddForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[700],
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'เพิ่มเเบบฟอม',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
