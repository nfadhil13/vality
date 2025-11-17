import 'dart:io';

void main() {
  final lcovFile = File('${Directory.current.path}/coverage/lcov.info');
  final tempFile = File('${Directory.current.path}/coverage/lcov_temp.info');

  if (lcovFile.existsSync()) {
    final lines = lcovFile.readAsLinesSync();
    final tempFileSink = tempFile.openWrite();

    for (var line in lines) {
      if (line.startsWith('SF:')) {
        tempFileSink.writeln(
          'SF:${Directory.current.path}${line.substring(3)}',
        );
      } else {
        tempFileSink.writeln(line);
      }
    }

    tempFileSink.close();
    tempFile.renameSync(lcovFile.path);
    print('File ${lcovFile.path} has been fixed.');
  } else {
    print('File ${lcovFile.path} does not exist.');
  }
}
