import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CronogramaTela extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<CronogramaTela> {
  int studyMinutes = 0;
  int studySeconds = 0;
  int breakMinutes = 0;
  int breakSeconds = 0;

  bool isRunning = false;
  String activeTimer = 'study'; // 'study' or 'break'

  late Duration studyDuration;
  late Duration breakDuration;

  @override
  void initState() {
    super.initState();
    studyDuration = Duration(minutes: studyMinutes, seconds: studySeconds);
    breakDuration = Duration(minutes: breakMinutes, seconds: breakSeconds);
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });
    if (activeTimer == 'study') {
      _startStudyTimer();
    } else {
      _startBreakTimer();
    }
  }

  void _startStudyTimer() {
    if (studyDuration.inSeconds > 0) {
      Future.delayed(Duration(seconds: 1), () {
        if (isRunning && studyDuration.inSeconds > 0) {
          setState(() {
            studyDuration -= Duration(seconds: 1);
          });
          _startStudyTimer();
        }
      });
    } else {
      setState(() {
        activeTimer = 'break';
      });
      _startBreakTimer();
    }
  }

  void _startBreakTimer() {
    if (breakDuration.inSeconds > 0) {
      Future.delayed(Duration(seconds: 1), () {
        if (isRunning && breakDuration.inSeconds > 0) {
          setState(() {
            breakDuration -= Duration(seconds: 1);
          });
          _startBreakTimer();
        }
      });
    } else {
      setState(() {
        activeTimer = 'study';
        isRunning = false; // Stop the timer when both are done
      });
    }
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      studyDuration = Duration(minutes: studyMinutes, seconds: studySeconds);
      breakDuration = Duration(minutes: breakMinutes, seconds: breakSeconds);
      activeTimer = 'study';
    });
  }

  void _editTime({bool isStudy = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int tempMinutes = isStudy ? studyMinutes : breakMinutes;
        int tempSeconds = isStudy ? studySeconds : breakSeconds;
        return AlertDialog(
          title: Text(isStudy ? 'Editar Tempo de Estudo' : 'Editar Tempo de Descanso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: tempMinutes,
                onChanged: (value) {
                  setState(() {
                    tempMinutes = value;
                  });
                },
              ),
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: tempSeconds,
                onChanged: (value) {
                  setState(() {
                    tempSeconds = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  if (isStudy) {
                    studyMinutes = tempMinutes;
                    studySeconds = tempSeconds;
                    studyDuration = Duration(minutes: studyMinutes, seconds: studySeconds);
                  } else {
                    breakMinutes = tempMinutes;
                    breakSeconds = tempSeconds;
                    breakDuration = Duration(minutes: breakMinutes, seconds: breakSeconds);
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro de Estudo e Descanso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerCard(
              title: 'Tempo de Estudo',
              duration: studyDuration,
              onTap: () => _editTime(isStudy: true),
            ),
            SizedBox(height: 20),
            TimerCard(
              title: 'Tempo de Descanso',
              duration: breakDuration,
              onTap: () => _editTime(isStudy: false),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? null : startTimer,
                  child: Text('Iniciar'),
                ),
                ElevatedButton(
                  onPressed: isRunning ? pauseTimer : null,
                  child: Text('Pausar'),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Restaurar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  final String title;
  final Duration duration;
  final VoidCallback onTap;

  TimerCard({required this.title, required this.duration, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '$minutes:$seconds',
                style: TextStyle(fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}