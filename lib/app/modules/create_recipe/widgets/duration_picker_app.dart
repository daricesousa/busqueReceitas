import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Duration? _durationInitial;

class DurationPickerApp extends StatefulWidget {
  final BuildContext context;
  final String title;
  final Duration? durationInitial;
  final Function(Duration?) confirm;

  const DurationPickerApp({
    super.key,
    this.title = '',
    required this.context,
    required this.confirm,
    this.durationInitial,
  });

  @override
  State<DurationPickerApp> createState() => _DurationPickerAppState();
}

class _DurationPickerAppState extends State<DurationPickerApp> {
  @override
  void initState() {
    duration = widget.durationInitial ?? const Duration(hours: 0, minutes: 0);
    super.initState();
  }
  late Duration duration;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: DurationPicker(
        duration: duration,
        onChange: (val) {
          setState(() => duration = val);
        },
        snapToMins: 5.0,
      ),
      actions: [
        AppButton(
          onPressed: Get.back,
          color: AppColor.light,
          borderColor: AppColor.dark2,
          child: const Text("Cancelar"),
        ),
        AppButton(
          onPressed: () async {
            Get.back();
            widget.confirm(duration);
          },
          color: AppColor.dark1,
          child: const Text(
            "Confirmar",
            style: TextStyle(color: AppColor.light),
          ),
        ),
      ],
    );
  }
}
