import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/pending/count_provider.dart';
import 'package:todo/features/task/pages/update_task.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';
import 'package:todo/generated/assets.dart';

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<Task> listData =  ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where((element) =>
    element.isCompleted == 0 &&
        element.date!.contains(today) ).toList();
    Future((){
      ref.read(countStateProvider.notifier).setCount(todayList.length.toString());
    });
    return todayList.isNotEmpty? ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, index) {
        final data = todayList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: (){
            ref.read(todoStateProvider.notifier).deleteTodo(data.id?? 0);
            List<Task> listData =  ref.watch(todoStateProvider);
            String today = ref.read(todoStateProvider.notifier).getToday();
            var todayList = listData
                .where((element) =>
            element.isCompleted == 0 &&
                element.date!.contains(today) ).toList();
            ref.read(countStateProvider.notifier).setCount(todayList.length.toString());
          },
          editWidget: GestureDetector(
            onTap: (){
              title = data.title.toString();
              desc = data.description.toString();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateTask(id: data.id??0),));
            },
            child: const Icon(MaterialCommunityIcons.circle_edit_outline, color: Colors.white,),
          ),
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.orange,
              value: isCompleted,
              onChanged: (value){
                ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id??0,
                    data.title.toString(),
                    data.description.toString(),
                    1,
                    data.date.toString(),
                    data.startTime.toString(),
                    data.endTime.toString());

                List<Task> listData =  ref.watch(todoStateProvider);
                String today = ref.read(todoStateProvider.notifier).getToday();
                var todayList = listData
                    .where((element) =>
                element.isCompleted == 0 &&
                    element.date!.contains(today) ).toList();
                ref.read(countStateProvider.notifier).setCount(todayList.length.toString());


              }),

        );

      },): Container(
      child: Lottie.asset(Assets.animationsOnBoard, fit: BoxFit.cover),
    );
  }

}