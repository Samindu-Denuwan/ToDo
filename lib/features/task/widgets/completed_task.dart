import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';
import 'package:todo/generated/assets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData =  ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30days();
    var lastMonthList = listData
        .where((element) =>
    element.isCompleted == 1 ||
        lastMonth.contains(element.date!.substring(0,10))).toList();

    return lastMonthList.isNotEmpty? ListView.builder(
      itemCount: lastMonthList.length,
      itemBuilder: (context, index) {
        final data = lastMonthList[index];
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: (){
            ref.read(todoStateProvider.notifier).deleteTodo(data.id?? 0);
            showTopSnackBar(
              displayDuration: const Duration(seconds: 1),
              Overlay.of(context),
              CustomSnackBar.success(
                backgroundColor: Colors.green,
                textStyle: appStyle(16, Colors.white, FontWeight.w500),
                message:
                "Task Deleted Successfully..!",
              ),
            );
            },
          editWidget: const SizedBox.shrink(),
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: Padding(
            padding:  EdgeInsets.only(right: 10.w),
            child: const Icon(FontAwesome.check_circle, color: AppConst.kGreen,),
          ),

        );

      },): Container(
      child: Lottie.asset(Assets.animationsOnBoard, fit: BoxFit.cover),
    );
  }
}