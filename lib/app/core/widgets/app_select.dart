import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_dialog/select_dialog.dart';

class AppSelect<T> extends StatefulWidget {
  final String label;
  final void Function(T)? onChange;
  final String Function(T)? titleItem;
  final bool Function()? onTap;
  final List<T> items;

  const AppSelect({
    super.key,
    required this.items,
    this.label = "",
    this.titleItem,
    this.onChange,
    this.onTap,
  });

  @override
  State<AppSelect<T>> createState() => _AppSelectState<T>();
}

class _AppSelectState<T> extends State<AppSelect<T>> {
  final selected = ValueNotifier("");

  @override
  void dispose() {
    selected.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppSelect<T> oldWidget) {
    selected.value = widget.label;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: selected,
        builder: (context, snapshot) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                   height: 47,
                  margin: const EdgeInsets.only(top: 2),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(widget.label, style: const TextStyle(fontSize: 14),),
                ),
              ],
            ),
            onTap: () {
              Get.focusScope?.unfocus();
              var res = widget.onTap?.call();
              if (res == false) return;
              SelectDialog.showModal<T>(
                context,
                emptyBuilder: (_) {
                  return const Text("Nenhum item encontrado");
                },
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(widget.titleItem?.call(item) ?? ""),
                  );
                },
                searchBoxDecoration: InputDecoration(
                  hintText: "Pesquisar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                label: "Ingrediente",
                items: widget.items,
                onChange: (v) {
                  selected.value = v.toString();
                  widget.onChange?.call(v);
                },
              );
            },
          );
        });
  }
}
