import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/providers/user_provider.dart';
import 'package:game_workspace/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  // 아래 변수들도... 삭제 가능한 변수들 나중에 유저 정보를 provider 에서 상태 관리하게 된다면 굳이 사용하지 않아도 됨
  // 관리자 페이지라면 사용해야하는 변수들
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
    /*
    로그인한 유저 정보를 provider 에서 상태관리하며 불러와야할 경우 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser(widget.userId);
    });

     */
  }

  // 프로필 변경할 때는 하위 기능은 삭제하는 것이 좋음
  // 선택한 유저 정보 불러오기 / 관리자 스크린에서만 쓸 법한 기능
  // 관리자는 모든~ 유저들목록 보고 조회 가능!
  Future<void> loadUser() async {
    if (widget.userId == null)
      return; //만약 로그인한 유저정보가 위젯에 존재한다면 이 기능을 사용하지 않을 것입니다.

    setState(() => isLoading = true);

    try {
      // 유저 서비스에서 유저 정보가져오기 시도
      final userService = UserService();
      final result = await userService.getUserById(widget.userId!);
      // 제대로 유저 정보를 가져오면 가져온 결과를 user 객체에 맞춰 추가
      // 로딩 해지
      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      // 가져오던 중 문제가 발생하면
      // 우선 로딩 해제
      setState(() => isLoading = false);
      // 현재 screen 에서 유저 정보를 가져오는 데 오류가 발생했다 표기
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('오류 : $e')));
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

    if (image != null) {
      /*
      마찬가지로 로그인한 유저의 프로필상태를 가져올 때 사용
      final success = await context
          .read<UserProvider>()
          .updateProfileImage(widget.userId, File(image.path));

       */

      /*
      try catch 를 이용해서 프로필 이미지 변경 uploadProfileImage 로 교체
      .copyWith 사용
       */

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('업로드 실패')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('프로필'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user!.profileImageUrl!),
                        // null ok
                        // 이미지가 존재하지 않는다면 아이콘으로 대체
                        // 이미지가 존재하면 null 로 처리
                        child: user!.profileImageUrl == null
                            ? Icon(Icons.person)
                            : null,
                      ),
                      Positioned(
                          child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  user!.userName,
                  style: const TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        )

        /*Consumer<UserProvider>
        (
          builder: (context,provider,child){
          if(provider.isLoading && provider.currentUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = provider.currentUser;
          if(user == null ) {
            return Center(child: Text('사용자를 찾을 수 없습니다.'),);
          }

      }),

       */
        );
  }
}
