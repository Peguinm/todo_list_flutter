import 'package:flutter/material.dart';
import 'package:to_do_list/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {

  const HomeTasks({ super.key });

   @override
   Widget build(BuildContext context) {
       return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text('TASK\'S', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),        
        Column(
          children: [
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
          ],
        )
      ],
    );
  }
}