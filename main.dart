import 'dart:io';
import 'dashboard.dart';
class Teacher {
  final int id;
  final String password;
  
  Teacher({required this.id, required this.password});
}
class Student {
  String id;
  String name;
  String password;
  int teacherId;
  List<Course> courses;
  double totalMarksObtained;
  double totalMaxMarks;
  double percentage;
  String grade;

  Student({
    required this.id,
    required this.name,
    required this.password,
    required this.teacherId,
    required this.courses,
    required this.totalMarksObtained,
    required this.totalMaxMarks,
    required this.percentage,
    required this.grade,
  });
}

class Course {
  String name;
  double marksObtained;
  double maxMarks;

  Course({required this.name, required this.marksObtained, required this.maxMarks});
}
void editCourseMarks(List<Student> students, String studentId, String courseName) {
  bool studentFound = false;
  bool courseFound = false;

  for (var student in students) {
    if (student.id == studentId) {
      studentFound = true;

      for (var course in student.courses) {
        if (course.name == courseName) {
          courseFound = true;

          print("Current marks: ${course.marksObtained}");
          print("Enter new marks: ");

          double newMarks = double.parse(stdin.readLineSync()!);

          course.marksObtained = newMarks;

          print("Marks for $courseName updated to $newMarks.");
        }
      }

      if (!courseFound) {
        print("Invalid course ID: $courseName.");
      }
    }
  }

  if (!studentFound) {
    print("Invalid student ID: $studentId.");
  }
}

void printReport(Student student) {
  // ignore: unnecessary_null_comparison
  if (student.percentage == 0 || student.grade == '') {
    calculateStudentResult(student);
  }
  
  print('Report for Student ID: ${student.id}');
  print('Name: ${student.name}');
  print('Teacher ID: ${student.teacherId}');
  print('Courses and Marks:');
  for (Course course in student.courses) {
    print('${course.name}: ${course.marksObtained}/${course.maxMarks}');
  }
  print('Total Marks Obtained: ${student.totalMarksObtained}');
  print('Total Max Marks: ${student.totalMaxMarks}');
  print('Percentage: ${student.percentage}%');
  print('Grade: ${student.grade}');
}

void calculateStudentResult(Student student) {
  int totalMarksObtained = 0;
  int totalMaxMarks = 0;

  for (var course in student.courses) {
    totalMarksObtained += course.marksObtained.toInt();
    totalMaxMarks += course.maxMarks.toInt();
  }

  double percentage = totalMarksObtained / totalMaxMarks * 100;
  String grade;

  if (percentage >= 90) {
    grade = 'A';
  } else if (percentage >= 80) {
    grade = 'B';
  } else if (percentage >= 70) {
    grade = 'C';
  } else if (percentage >= 60) {
    grade = 'D';
  } else {
    grade = 'F';
  }

  student.totalMarksObtained = totalMarksObtained.toDouble();
  student.totalMaxMarks = totalMaxMarks.toDouble();

  student.percentage = percentage;
  student.grade = grade;
}


void main(){

  final teachers = [
    Teacher(id: 1, password: 'teacher1'),
    Teacher(id: 2, password: 'teacher2'),
  ];
  List<Student> students = [
    Student(
      id: '001',
      name: 'Azhar',
      password: 'pass001',
      teacherId: 1,
      courses: [
        Course(name: 'Maths', marksObtained: 80, maxMarks: 100),
        Course(name: 'Physics', marksObtained: 75, maxMarks: 100),
        Course(name: 'Chemistry', marksObtained: 85, maxMarks: 100),
      ],
      totalMarksObtained: 0,
      totalMaxMarks: 0,
      percentage: 0,
      grade: '',
    ),
    Student(
      id: '002',
      name: 'Muddar',
      password: 'pass002',
      teacherId: 2,
      courses: [
        Course(name: 'Maths', marksObtained: 90, maxMarks: 100),
        Course(name: 'Physics', marksObtained: 85, maxMarks: 100),
        Course(name: 'Chemistry', marksObtained: 95, maxMarks: 100),
      ],
      totalMarksObtained: 270,
      totalMaxMarks: 300,
      percentage: 90,
      grade: 'A',
    ),
    
    // add more students here
  ];

  print("\nWelcome select a number from following options to select your identity \n\n 1. Teacher \n 2. Student");
  int? iden = int.parse(stdin.readLineSync()!);
  if(iden == 1){
      print("Enter Your Credentials to Login");
      print("Enter Your ID");
      int id = int.parse(stdin.readLineSync()!);
      print("Enter Your Password");
      String? pass = stdin.readLineSync();

      bool isTeacherFound = false;
      for (var teacher in teachers) {
        if (teacher.id == id && teacher.password == pass) {
          isTeacherFound = true;
          break;
        }
      }

      if (isTeacherFound) {
        // teacher is found, do something
        // print("object");
        for (var student in students) {
          if (student.teacherId == id) {
            print("${student.id}: ${student.name}");
          }
        }
        stdout.write('Enter the ID of the student to show course marks: ');
        String? stdId = stdin.readLineSync();

        // search for the student with the given ID
        Student selectedStudent = students.firstWhere((student) => student.id == stdId);

        // print the courses and their marks
        for (var i = 0; i < selectedStudent.courses.length; i++) {
          print('${selectedStudent.courses[i].name}: ${selectedStudent.courses[i].marksObtained}');
        }

        print("Enter the course name for which you want to edit marks or type report to generate Report:");
        String? courseName = stdin.readLineSync();
        if(courseName != "report"){
          editCourseMarks(students, stdId!, courseName!); // calling function
        }else{
          printReport(selectedStudent);
        }
        


      } else {
        // teacher is not found, show error message
        print("Error! Teacher not Found");
      }

      
  }
  else if(iden == 2){
      // print("Enter Your roll no.");
      // int? rollNo = int.parse(stdin.readLineSync()!);
      // print("Enter Your Batch");
      // int? batch = int.parse(stdin.readLineSync()!);
      // print("Enter Your Department");
      // String? dept = stdin.readLineSync();
      // print("Welcome Roll No. ${rollNo} of Batch ${batch} from ${dept} \n\n");
      // print("Here are your Grades");
      // Grades g1 = Grades();
      // g1.display();

      print("Enter Your Credentials to Login");
      print("Enter Your ID");
      String? stId = stdin.readLineSync();
      print("Enter Your Password");
      String? stPass = stdin.readLineSync();

      bool isStudentFound = false;
      for (var student in students) {
        if (student.id == stId && student.password == stPass) {
          isStudentFound = true;
          break;
        }
      }
      Student selectedStudent1 = students.firstWhere((student) => student.id == stId);
      printReport(selectedStudent1);
  }
  else{
    print("Enter correct input !!!");  
  }
  
}