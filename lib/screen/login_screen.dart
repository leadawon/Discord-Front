import 'package:flutter/material.dart';
import 'package:discord_front/screen/signup_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:discord_front/screen/home_screen.dart';
import 'package:discord_front/config/palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Email 형식 체크
    if (email.isEmpty || !email.contains('@') || password.isEmpty || !(password.length < 6)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('유효한 Email또는 Password를 입력해주세요'),
        ),
      );
      return; // 이메일이 유효하지 않으면 함수 종료
    }

    // final response = await http.post(
    //   Uri.parse('http://your-backend-url.com/login'), // 백엔드 URL 수정 필요
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'password': password,
    //     'email': email,
    //   }),
    // );

    // 가상의 응답 생성
    // 백엔드 구현이 완료되면 실제 HTTP 요청으로 대체
    final response = http.Response(
      jsonEncode({'result': true}), // true 또는 false로 변경하여 테스트
      200, // HTTP 상태 코드
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // 응답 처리
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson['result']) {
        // 로그인 성공, 홈 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(useremail: email)),
        );
      } else {
        // 로그인 실패
        _showDialog('Login failed. Please check your credentials.');
      }
    } else {
      // 서버 에러 또는 기타 오류
      _showDialog('Error: ${response.statusCode}');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // 다른 화면을 터치했을 때 키보드 닫기
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: <Widget>[
            // 배경 이미지
            Image.asset(
              'asset/img/discord_mobile_background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(


                  margin: EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
                  padding: EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Palette.blackColor1, // 배경색
                    borderRadius: BorderRadius.circular(20.0), // 모서리 둥글게
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome!', // 환영 메시지
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email', // Email 텍스트
                          style: TextStyle(
                            color: Colors.white, // 텍스트 색상
                            fontSize: 16.0, // 텍스트 크기
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0), // 간격 조절
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white), // 입력된 글자 색상 설정
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0), // 텍스트 필드의 모서리 둥글기
                          ),
                          fillColor: Palette.blackColor4, // 텍스트 필드 배경색
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 16.0), // 간격 조절
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password', // Password 텍스트
                          style: TextStyle(
                            color: Colors.white, // 텍스트 색상
                            fontSize: 16.0, // 텍스트 크기
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0), // 간격 조절
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white), // 입력된 글자 색상 설정
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0), // 텍스트 필드의 모서리 둥글기
                          ),
                          fillColor: Palette.blackColor4, // 텍스트 필드 배경색
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 20.0), // 간격 조절
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _login,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white), // 텍스트 색상 설정
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.btnColor, // 버튼 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0), // 모서리 둥글기 설정
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: _signup,
                            child: Text(
                              'Signup',
                              style: TextStyle(color: Colors.white), // 텍스트 색상 설정
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.btnColor, // 버튼 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0), // 모서리 둥글기 설정
                              ),
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
