import 'dart:async';

import 'package:flutter/material.dart';

class CronometroTela extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<CronometroTela> {
  int studyMinutes = 30;
  int breakMinutes = 15;
  Timer? _studyTimer;
  Timer? _breakTimer;
  Duration remainingStudyTime = Duration(minutes: 30);
  Duration remainingBreakTime = Duration(minutes: 15);

  void startStudyTimer() {
    _studyTimer?.cancel();
    _studyTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingStudyTime.inSeconds > 0) {
          remainingStudyTime -= Duration(seconds: 1);
        } else {
          _studyTimer?.cancel();
        }
      });
    });
  }

  void startBreakTimer() {
    _breakTimer?.cancel();
    _breakTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingBreakTime.inSeconds > 0) {
          remainingBreakTime -= Duration(seconds: 1);
        } else {
          _breakTimer?.cancel();
        }
      });
    });
  }

  void stopTimers() {
    _studyTimer?.cancel();
    _breakTimer?.cancel();
  }

  void resetTimers() {
    setState(() {
      stopTimers();
      remainingStudyTime = Duration(minutes: studyMinutes);
      remainingBreakTime = Duration(minutes: breakMinutes);
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro Pomodoro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tempo de Estudo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
            Text(
              formatDuration(remainingStudyTime),
              style: TextStyle(
                fontSize: 72,
                color: Colors.yellow[700],
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Tempo de Descanso',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[600],
              ),
            ),
            Text(
              formatDuration(remainingBreakTime),
              style: TextStyle(
                fontSize: 72,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: startStudyTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Iniciar Estudo'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: startBreakTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300],
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Iniciar Descanso'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: stopTimers,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Parar'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: resetTimers,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300],
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Resetar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}