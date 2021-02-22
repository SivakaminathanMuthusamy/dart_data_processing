import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Error - Please provide a file to read");
    exit(1);
  }
  String fileName = arguments.first;
  List<String> fileContent = File(fileName).readAsLinesSync();
  Map<String, double> finalTaskData = {};
  double totalTaskDuration = 0;
  for (String line in fileContent) {
    List<String> data = line.split(",");
    String duration = data[3].replaceAll('"', '');
    double currentTaskDuration = double.parse(duration);
    String taskTag = data[5].replaceAll('"', '');
    //print('$taskTag : $taskDuration');
    double previousTaskDuration = finalTaskData[taskTag] ?? 0;
    totalTaskDuration = currentTaskDuration + previousTaskDuration;
    finalTaskData[taskTag] = totalTaskDuration;
  }
  for (var entry in finalTaskData.entries) {
    String taskName = entry.key;
    if (taskName == '') {
      taskName = "Unallocated";
    }
    String taskDuration = entry.value.toStringAsFixed(1);
    print("$taskName : ${taskDuration}h");
  }
}
