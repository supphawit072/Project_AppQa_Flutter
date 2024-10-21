import 'package:flutter/material.dart';
import 'package:test/controllers/form_controllers.dart';

class FormFormScreen extends StatefulWidget {
  @override
  _FormFormScreenState createState() => _FormFormScreenState();
}

class _FormFormScreenState extends State<FormFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FormController _courseController = FormController();

  // Text Editing Controllers
  final TextEditingController _curriculumController = TextEditingController();
  final TextEditingController _courseCodeFKController = TextEditingController();
  final TextEditingController _courseNameFKController = TextEditingController();
  final TextEditingController _creditsFKController = TextEditingController();
  final TextEditingController _groupsFKController = TextEditingController();
  final TextEditingController _instructorFKController = TextEditingController();

  // Grade fields controllers
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bPlusController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cPlusController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  final TextEditingController _dPlusController = TextEditingController();
  final TextEditingController _dController = TextEditingController();
  final TextEditingController _eController = TextEditingController();
  final TextEditingController _fController = TextEditingController();
  final TextEditingController _fPercentController = TextEditingController();
  final TextEditingController _iController = TextEditingController();
  final TextEditingController _wController = TextEditingController();
  final TextEditingController _vgController = TextEditingController();
  final TextEditingController _gController = TextEditingController();
  final TextEditingController _sController = TextEditingController();
  final TextEditingController _uController = TextEditingController();

  // Total Grade field
  int totalGrade = 0;

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect values from controllers
      final String curriculum = _curriculumController.text;
      final String courseCodeFK = _courseCodeFKController.text;
      final String courseNameFK = _courseNameFKController.text;
      final int creditsFK = int.tryParse(_creditsFKController.text) ?? 0;
      final String groupsFK = _groupsFKController.text;
      final String instructorFK = _instructorFKController.text;

      // Collecting grade values
      final int A = int.tryParse(_aController.text) ?? 0;
      final int BPlus = int.tryParse(_bPlusController.text) ?? 0;
      final int B = int.tryParse(_bController.text) ?? 0;
      final int CPlus = int.tryParse(_cPlusController.text) ?? 0;
      final int C = int.tryParse(_cController.text) ?? 0;
      final int DPlus = int.tryParse(_dPlusController.text) ?? 0;
      final int D = int.tryParse(_dController.text) ?? 0;
      final int E = int.tryParse(_eController.text) ?? 0;
      final int F = int.tryParse(_fController.text) ?? 0;
      final int FPercent = int.tryParse(_fPercentController.text) ?? 0;
      final int I = int.tryParse(_iController.text) ?? 0;
      final int W = int.tryParse(_wController.text) ?? 0;
      final int VG = int.tryParse(_vgController.text) ?? 0;
      final int G = int.tryParse(_gController.text) ?? 0;
      final int S = int.tryParse(_sController.text) ?? 0;
      final int U = int.tryParse(_uController.text) ?? 0;

      // Calculate the total grade
      setState(() {
        totalGrade = A +
            BPlus +
            B +
            CPlus +
            C +
            DPlus +
            D +
            E +
            F +
            FPercent +
            I +
            W +
            VG +
            G +
            S +
            U;
      });

      // Print data before sending
      print('Form data being sent:');
      print({
        'curriculum': curriculum,
        'coursecodeFK': courseCodeFK,
        'coursenameFK': courseNameFK,
        'creditsFK': creditsFK,
        'groupsFK': groupsFK,
        'instructorFK': instructorFK,
        'A': A,
        'B_plus': BPlus,
        'B': B,
        'C_plus': CPlus,
        'C': C,
        'D_plus': DPlus,
        'D': D,
        'E': E,
        'F': F,
        'F_percent': FPercent,
        'I': I,
        'W': W,
        'VG': VG,
        'G': G,
        'S': S,
        'U': U,
        'total': totalGrade,
      });

      try {
        await _courseController.createForm(
          context,
          curriculum: curriculum,
          coursecodeFK: courseCodeFK,
          coursenameFK: courseNameFK,
          creditsFK: creditsFK,
          groupsFK: groupsFK,
          instructorFK: instructorFK,
          A: A,
          BPlus: BPlus,
          B: B,
          CPlus: CPlus,
          C: C,
          DPlus: DPlus,
          D: D,
          E: E,
          F: F,
          FPercent: FPercent,
          I: I,
          W: W,
          VG: VG,
          G: G,
          S: S,
          U: U,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('วิชาใหม่ถูกสร้างสำเร็จ, Total Grade: $totalGrade'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('เกิดข้อผิดพลาดในการสร้างเเบบฟอร์มได้: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างรายวิชาใหม่'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'สร้างรายวิชาใหม่',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Curriculum
                    TextFormField(
                      controller: _curriculumController,
                      decoration: InputDecoration(
                        labelText: 'Curriculum',
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Course Code FK
                    TextFormField(
                      controller: _courseCodeFKController,
                      decoration: InputDecoration(
                        labelText: 'รหัสวิชา',
                        prefixIcon: Icon(Icons.code),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกรหัสวิชา';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Course Name FK
                    TextFormField(
                      controller: _courseNameFKController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อวิชา',
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Credits FK
                    TextFormField(
                      controller: _creditsFKController,
                      decoration: InputDecoration(
                        labelText: 'หน่วยกิต',
                        prefixIcon: Icon(Icons.star),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกหน่วยกิต';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Groups FK
                    TextFormField(
                      controller: _groupsFKController,
                      decoration: InputDecoration(
                        labelText: 'กลุ่ม',
                        prefixIcon: Icon(Icons.group),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Instructor FK
                    TextFormField(
                      controller: _instructorFKController,
                      decoration: InputDecoration(
                        labelText: 'ผู้สอน',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Grades Fields (Example for A and B_plus)
                    TextFormField(
                      controller: _aController,
                      decoration: InputDecoration(
                        labelText: 'A Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bPlusController,
                      decoration: InputDecoration(
                        labelText: 'B+ Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bController,
                      decoration: InputDecoration(
                        labelText: 'B Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _cPlusController,
                      decoration: InputDecoration(
                        labelText: 'C+ Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _cController,
                      decoration: InputDecoration(
                        labelText: 'C Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _dPlusController,
                      decoration: InputDecoration(
                        labelText: 'D+ Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _dController,
                      decoration: InputDecoration(
                        labelText: 'D Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _eController,
                      decoration: InputDecoration(
                        labelText: 'E Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _fController,
                      decoration: InputDecoration(
                        labelText: 'F Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _fPercentController,
                      decoration: InputDecoration(
                        labelText: 'F% Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _iController,
                      decoration: InputDecoration(
                        labelText: 'I Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _wController,
                      decoration: InputDecoration(
                        labelText: 'W Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _vgController,
                      decoration: InputDecoration(
                        labelText: 'VG Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _gController,
                      decoration: InputDecoration(
                        labelText: 'G Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _sController,
                      decoration: InputDecoration(
                        labelText: 'S Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _uController,
                      decoration: InputDecoration(
                        labelText: 'U Grades',
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 16),
                    // Total Grade Display
                    Text('Total Grade: $totalGrade',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('สร้างรายวิชา'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
