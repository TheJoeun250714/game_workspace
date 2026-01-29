import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser(widget.userId);
    });

    Future<void> _pickImage() async {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

      if (image != null) {
        final success = await context
            .read<UserProvider>()
            .updateProfileImage(widget.userId, File(image.path));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(success ? '업데이트 완료' : '업로드 실패')));
        }
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
                  
                  onTap:  _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.userProfileIamgeUrl),
                      )
                    ],
                  ),
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
