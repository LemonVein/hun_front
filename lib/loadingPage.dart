import 'dart:async';
import 'package:flutter/material.dart';
import 'loginPage.dart'; // 로그인 페이지를 import
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // 로딩 페이지 표시
    Timer(Duration(seconds: 2), () {
      _navigateToLoginPage();
    });
  }

  // 권한 요청
  void _navigateToLoginPage() async {
    // 알림 권한 확인
    PermissionStatus notificationStatus = await Permission.notification.status;
    // 위치 권한 확인
    PermissionStatus locationStatus = await Permission.location.status;

    // 알림 권한 또는 위치 권한이 설정되어 있지 않은 경우 권한 요청
    if (notificationStatus.isDenied || notificationStatus.isPermanentlyDenied ||
        locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      // 알림 권한 요청
      await Permission.notification.request();
      // 위치 권한 요청
      await Permission.location.request();
    }

    // 로그인 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Stack이 화면 전체를 차지하도록 설정
        children: [
          // 배경 이미지
          Image.asset(
            'assets/images/login_image.jpg', // 배경 이미지 파일 경로
            fit: BoxFit.cover, // 이미지가 화면에 가득 차도록 함
          ),
          // 정중앙에 이미지 표시
          Center(
            child: Image.asset(
              'assets/images/hnu.png', // 중앙에 표시할 이미지 경로
              width: 200, // 이미지의 너비
              height: 200, // 이미지의 높이
              fit: BoxFit.contain, // 이미지를 유지하면서 정중앙에 표시
            ),
          ),
          // 로딩 인디케이터
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // 인디케이터 색상 설정
            ),
          ),
        ],
      ),
    );
  }
}
