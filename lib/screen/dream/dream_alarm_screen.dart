import 'package:dream_catcher/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class DreamAlarmScreen extends StatefulWidget {
  const DreamAlarmScreen({Key? key}) : super(key: key);

  @override
  State<DreamAlarmScreen> createState() => _DreamAlarmScreenState();
}

class _DreamAlarmScreenState extends State<DreamAlarmScreen> {
  // 임시 알람 데이터
  final List<DreamAlarm> _alarms = [
    DreamAlarm(
      id: '1',
      time: const TimeOfDay(hour: 22, minute: 0),
      isEnabled: true,
      label: '취침 전 꿈 기록',
      repeatDays: {1, 2, 3, 4, 5},
    ),
    DreamAlarm(
      id: '2',
      time: const TimeOfDay(hour: 7, minute: 30),
      isEnabled: false,
      label: '아침 꿈 기록',
      repeatDays: {1, 3, 5},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF6666CC)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '꿈 알람 설정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF6666CC)),
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],
      ),
      body: _alarms.isEmpty ? _buildEmptyState() : _buildAlarmList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6666CC),
        onPressed: () {
          _showAddAlarmDialog();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const CommonBottomNavBar(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.alarm_off,
            size: 70,
            color: const Color(0xFF6666CC).withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          const Text(
            '설정된 알람이 없습니다',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '+ 버튼을 눌러 꿈 기록을 위한 알람을 추가하세요',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8080B2),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _alarms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildAlarmItem(_alarms[index]);
      },
    );
  }

  Widget _buildAlarmItem(DreamAlarm alarm) {
    final repeatText = alarm.repeatDays.isEmpty
        ? '반복 없음'
        : _getRepeatDaysText(alarm.repeatDays);

    return Dismissible(
      key: Key(alarm.id),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _alarms.remove(alarm);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('알람이 삭제되었습니다'),
            backgroundColor: const Color(0xFF6666CC),
            action: SnackBarAction(
              label: '실행 취소',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _alarms.insert(_alarms.indexOf(alarm), alarm);
                });
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          _showEditAlarmDialog(alarm);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0F000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(alarm.time),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: alarm.isEnabled
                          ? const Color(0xFF4D4D99)
                          : const Color(0xFF8080B2),
                    ),
                  ),
                  Switch(
                    value: alarm.isEnabled,
                    onChanged: (value) {
                      setState(() {
                        alarm.isEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6666CC),
                    trackColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFFE1E1F9);
                        }
                        return const Color(0xFFE0E0E0);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                alarm.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: alarm.isEnabled
                      ? const Color(0xFF4D4D99)
                      : const Color(0xFF8080B2),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    repeatText,
                    style: TextStyle(
                      fontSize: 14,
                      color: alarm.isEnabled
                          ? const Color(0xFF8080B2)
                          : const Color(0xFFB2B2E5),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.nightlight_round,
                        size: 16,
                        color: alarm.isEnabled
                            ? const Color(0xFF6666CC)
                            : const Color(0xFFB2B2E5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '꿈 인터뷰',
                        style: TextStyle(
                          fontSize: 14,
                          color: alarm.isEnabled
                              ? const Color(0xFF6666CC)
                              : const Color(0xFFB2B2E5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getRepeatDaysText(Set<int> repeatDays) {
    if (repeatDays.length == 7) {
      return '매일';
    } else if (repeatDays.containsAll({1, 2, 3, 4, 5}) &&
        !repeatDays.contains(6) &&
        !repeatDays.contains(7)) {
      return '주중';
    } else if (!repeatDays.contains(1) &&
        !repeatDays.contains(2) &&
        !repeatDays.contains(3) &&
        !repeatDays.contains(4) &&
        !repeatDays.contains(5) &&
        repeatDays.contains(6) &&
        repeatDays.contains(7)) {
      return '주말';
    } else {
      final dayNames = ['월', '화', '수', '목', '금', '토', '일'];
      final days = <String>[];
      for (int i = 1; i <= 7; i++) {
        if (repeatDays.contains(i)) {
          days.add(dayNames[i - 1]);
        }
      }
      return days.join(', ');
    }
  }

  void _showAddAlarmDialog() {
    var time = TimeOfDay.now();
    var label = '꿈 기록';
    Set<int> repeatDays = {};
    bool isEnabled = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '새 알람 추가',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D4D99),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.close, color: Color(0xFF8080B2)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildTimePicker(time, (newTime) {
                          time = newTime;
                        }),
                        const SizedBox(height: 24),
                        _buildLabelField(label, (newLabel) {
                          label = newLabel;
                        }),
                        const SizedBox(height: 24),
                        _buildRepeatDaysSelector(repeatDays, (newDays) {
                          setState(() {
                            repeatDays = newDays;
                          });
                        }),
                        const SizedBox(height: 24),
                        _buildEnableSwitch(isEnabled, (newValue) {
                          setState(() {
                            isEnabled = newValue;
                          });
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          final newAlarm = DreamAlarm(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            time: time,
                            isEnabled: isEnabled,
                            label: label,
                            repeatDays: repeatDays,
                          );
                          setState(() {
                            _alarms.add(newAlarm);
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6666CC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        // 화면 갱신
      });
    });
  }

  void _showEditAlarmDialog(DreamAlarm alarm) {
    var time = alarm.time;
    var label = alarm.label;
    var repeatDays = Set<int>.from(alarm.repeatDays);
    var isEnabled = alarm.isEnabled;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '알람 편집',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D4D99),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.close, color: Color(0xFF8080B2)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildTimePicker(time, (newTime) {
                          time = newTime;
                        }),
                        const SizedBox(height: 24),
                        _buildLabelField(label, (newLabel) {
                          label = newLabel;
                        }),
                        const SizedBox(height: 24),
                        _buildRepeatDaysSelector(repeatDays, (newDays) {
                          setState(() {
                            repeatDays = newDays;
                          });
                        }),
                        const SizedBox(height: 24),
                        _buildEnableSwitch(isEnabled, (newValue) {
                          setState(() {
                            isEnabled = newValue;
                          });
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _deleteAlarm(alarm);
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red[400],
                              side: BorderSide(color: Colors.red[400]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              '삭제',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                alarm.time = time;
                                alarm.label = label;
                                alarm.repeatDays = repeatDays;
                                alarm.isEnabled = isEnabled;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6666CC),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              '저장',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        // 화면 갱신
      });
    });
  }

  Widget _buildTimePicker(
      TimeOfDay initialTime, Function(TimeOfDay) onTimeChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '시간',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: initialTime,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF6666CC),
                      onSurface: Color(0xFF4D4D99),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedTime != null) {
              onTimeChanged(pickedTime);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFB2B2E5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(initialTime),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4D4D99),
                  ),
                ),
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF6666CC),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelField(
      String initialLabel, Function(String) onLabelChanged) {
    final controller = TextEditingController(text: initialLabel);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '레이블',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '알람 이름을 입력하세요',
            hintStyle: const TextStyle(color: Color(0xFF8080B2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB2B2E5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB2B2E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6666CC)),
            ),
            prefixIcon: const Icon(Icons.label, color: Color(0xFF6666CC)),
          ),
          onChanged: (value) {
            onLabelChanged(value);
          },
        ),
      ],
    );
  }

  Widget _buildRepeatDaysSelector(
      Set<int> selectedDays, Function(Set<int>) onDaysChanged) {
    final dayNames = ['월', '화', '수', '목', '금', '토', '일'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '반복',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final dayIndex = index + 1;
            final isSelected = selectedDays.contains(dayIndex);
            return GestureDetector(
              onTap: () {
                final newDays = Set<int>.from(selectedDays);
                if (isSelected) {
                  newDays.remove(dayIndex);
                } else {
                  newDays.add(dayIndex);
                }
                onDaysChanged(newDays);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF6666CC) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6666CC)
                        : const Color(0xFFB2B2E5),
                  ),
                ),
                child: Center(
                  child: Text(
                    dayNames[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? Colors.white : const Color(0xFF8080B2),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                onDaysChanged({1, 2, 3, 4, 5});
              },
              child: const Text(
                '주중',
                style: TextStyle(
                  color: Color(0xFF6666CC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onDaysChanged({6, 7});
              },
              child: const Text(
                '주말',
                style: TextStyle(
                  color: Color(0xFF6666CC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onDaysChanged({1, 2, 3, 4, 5, 6, 7});
              },
              child: const Text(
                '매일',
                style: TextStyle(
                  color: Color(0xFF6666CC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onDaysChanged({});
              },
              child: const Text(
                '해제',
                style: TextStyle(
                  color: Color(0xFF8080B2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEnableSwitch(bool isEnabled, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '알람 활성화',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: (value) {
            onChanged(value);
          },
          activeColor: const Color(0xFF6666CC),
          trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFFE1E1F9);
              }
              return const Color(0xFFE0E0E0);
            },
          ),
        ),
      ],
    );
  }

  void _deleteAlarm(DreamAlarm alarm) {
    setState(() {
      _alarms.remove(alarm);
    });
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '꿈 알람이란?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('꿈 알람은 정해진 시간에 꿈 인터뷰를 시작하도록 알림을 제공합니다.'),
              SizedBox(height: 12),
              Text('• 취침 전: 잠들기 전 꿈을 기록하고 싶은 의도 설정'),
              SizedBox(height: 8),
              Text('• 기상 직후: 깨어난 직후 꿈을 기억하기 쉬울 때 알림'),
              SizedBox(height: 8),
              Text('• 반복 설정: 특정 요일에만 알람이 울리도록 설정 가능'),
              SizedBox(height: 12),
              Text('알람이 울리면 꿈 인터뷰가 자동으로 시작되어 AI와 대화를 통해 꿈을 기록할 수 있습니다.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '확인',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6666CC),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DreamAlarm {
  final String id;
  TimeOfDay time;
  bool isEnabled;
  String label;
  Set<int> repeatDays; // 1(월) ~ 7(일)

  DreamAlarm({
    required this.id,
    required this.time,
    required this.isEnabled,
    required this.label,
    required this.repeatDays,
  });
}
