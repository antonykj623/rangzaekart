import 'package:flutter/material.dart';
import 'package:rangza_ekart/widgets/otp.dart';
import 'package:video_player/video_player.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({Key? key}) : super(key: key);

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  late VideoPlayerController _controller;
  final TextEditingController _mobileController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();

    // 🎬 Initialize Video Controller (local asset)
    _controller = VideoPlayerController.asset('assets/main.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0); // mute
        _controller.play();
        setState(() {}); // refresh UI once initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🎞️ Small Video View
                if (_controller.value.isInitialized)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                else
                  const CircularProgressIndicator(),

                const SizedBox(height: 40),

                // 📱 Mobile Number Input
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your mobile number",
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 🔘 Remember Me
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() => _rememberMe = value ?? false);
                      },
                    ),
                    const Text("Remember me"),
                  ],
                ),
                const SizedBox(height: 10),

                // 🚀 Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Submitted: ${_mobileController.text}, Remember me: $_rememberMe'),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  OtpPage(),
                        ),
                      );





                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shadowColor: Colors.grey.shade400,
                      elevation: 4,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

