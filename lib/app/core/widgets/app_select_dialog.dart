
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';

class AppSelectDialog<T> {
  
  void showModal<T>(
    {
      required BuildContext context,
      required List<T> items,
      required String Function(T)? titleItem,
      void Function(T)? onChange,
      Widget Function(String)? notFind,
      String title = '',
    }
  ){
      final textFind = TextEditingController();
      SelectDialog.showModal<T>(
                context,
                emptyBuilder: (_) {
                  return notFind?.call(textFind.text) ?? Container();
                },
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(titleItem?.call(item) ?? ""),
                  );
                },
                findController: textFind,
                searchBoxDecoration: InputDecoration(
                  hintText: "Pesquisar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                label: title,
                items: items,
                onChange: onChange,
              );
  }

}