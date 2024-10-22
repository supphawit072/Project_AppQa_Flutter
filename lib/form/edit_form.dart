import 'package:flutter/material.dart';
import 'package:test/models/form_midel.dart'; // Ensure this imports the correct model

class EditFormPage extends StatefulWidget {
  final FormModel formModel;

  const EditFormPage({super.key, required this.formModel});

  @override
  _EditFormPageState createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final TextEditingController _curriculumController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _curriculumController.text = widget.formModel.curriculum;
    _courseCodeController.text = widget.formModel.coursecodeFk;
    _courseNameController.text = widget.formModel.coursenameFk;
    _creditsController.text = widget.formModel.creditsFk.toString();
    _groupController.text = widget.formModel.groupsFk;
    _instructorController.text = widget.formModel.instructorFk;
  }

  Future<void> _updateForm() async {
    // Implement your update logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[700], // Dark purple for AppBar
      ),
      body: Center(
        // Center the content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Aligns content to the center
            children: [
              _buildTextField(_curriculumController, 'Curriculum'),
              const SizedBox(height: 16),
              _buildTextField(_courseCodeController, 'Course Code'),
              const SizedBox(height: 16),
              _buildTextField(_courseNameController, 'Course Name'),
              const SizedBox(height: 16),
              _buildTextField(
                _creditsController,
                'Credits',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(_groupController, 'Group'),
              const SizedBox(height: 16),
              _buildTextField(_instructorController, 'Instructor'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call update method here
                  _updateForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple[700], // Purple color for button
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Update Form',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ), // White text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom TextField builder for consistency
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepPurple[700]), // Label color
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.deepPurple[700]!), // Border color
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
