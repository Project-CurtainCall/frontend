import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _saveContact() {
    final String name = _nameController.text;
    final String phoneNumber = _phoneController.text;

    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      // 저장 로직 추가
      print('Contact saved: $name, $phoneNumber');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('저장이 완료되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } else {
      // 입력 값이 비어있는 경우 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이름과 전화번호를 입력하세요.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _onPhoneChanged(String value) {
    String formattedNumber = _formatPhoneNumber(value.replaceAll('-', ''));
    _phoneController.value = TextEditingValue(
      text: formattedNumber,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }

  String _formatPhoneNumber(String number) {
    if (number.startsWith('010')) {
      if (number.length > 3 && number.length <= 7) {
        return '${number.substring(0, 3)}-${number.substring(3)}';
      } else if (number.length > 7) {
        return '${number.substring(0, 3)}-${number.substring(3, 7)}-${number.substring(7)}';
      }
    } else if (number.startsWith('02')) {
      if (number.length == 9) {
        return '${number.substring(0, 2)}-${number.substring(2, 5)}-${number.substring(5)}';
      } else if (number.length == 10) {
        return '${number.substring(0, 2)}-${number.substring(2, 6)}-${number.substring(6)}';
      } else if (number.length > 2 && number.length < 9) {
        return '${number.substring(0, 2)}-${number.substring(2)}';
      }
    } else {
      if (number.length > 3 && number.length <= 6) {
        return '${number.substring(0, 3)}-${number.substring(3)}';
      } else if (number.length > 6) {
        return '${number.substring(0, 3)}-${number.substring(3, 6)}-${number.substring(6)}';
      }
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '번호 추가',
            style: TextStyle(color: Colors.black),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.person_add, size: 60), // 아이콘 크기 줄임
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100], // 배경색 설정
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ), // 위쪽만 둥글게 설정
              ),
              child: Container(
                margin: const EdgeInsets.all(0.0), // 흰색 배경 마진 설정
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // 흰색 배경 설정
                  borderRadius: BorderRadius.circular(16), // 위아래 모서리 둥글게
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text(
                          '       이름 >',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8), // 한 칸 띄우기
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 8.0), // 간격을 줄이기 위해 height 조정
                    Row(
                      children: [
                        const Text(
                          '전화번호 >',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8), // 한 칸 띄우기
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: _onPhoneChanged,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveContact,
            child: const Text('저장'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            BottomIconButton(
              icon: Icons.add,
              label: '연락처 추가',
              onPressed: () {},
            ),
            const Spacer(),
            BottomIconButton(
              icon: Icons.person,
              label: '연락처',
              onPressed: () {
                Navigator.pushNamed(context, '/contacts');
              },
            ),
            const Spacer(),
            BottomIconButton(
              icon: Icons.dialpad,
              label: '키패드',
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            const Spacer(),
            BottomIconButton(
              icon: Icons.history,
              label: '최근 기록',
              onPressed: () {
                Navigator.pushNamed(context, '/recent_calls');
              },
            ),
            const Spacer(),
            BottomIconButton(
              icon: Icons.settings,
              label: '설정',
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const BottomIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 20), // 아이콘 크기 줄임
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
