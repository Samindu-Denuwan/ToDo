import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/auth/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
              children: [
                ReusableText(text: code,
                    style: appStyle(30, Colors.white, FontWeight.w500)),
                TextButton(
                    onPressed: (){
                      ref.read(codeStateProvider.notifier).setStart("Hii");
                    },
                    child: Text("Click me"),
                ),

              ],
        ),
      ),
    );
  }
}
