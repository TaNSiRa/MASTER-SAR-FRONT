import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget columnText(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

Widget dataText(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}

/// ใช้แทน dataText ได้เลย
Widget dataInputCell({
  required String value,
  List<String>? dropdownItems, // ถ้าไม่ null จะเป็น dropdown
  required Function(String) onChanged,
}) {
  if (dropdownItems != null && dropdownItems.isNotEmpty) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: DropdownSearch<String>(
        selectedItem: dropdownItems.contains(value) ? value : null,
        items: dropdownItems,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            hintText: '',
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          menuProps: const MenuProps(
            backgroundColor: Colors.white,
          ),
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            ),
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
        dropdownBuilder: (context, selectedItem) {
          return Text(
            // selectedItem ?? '',
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        onChanged: (newValue) {
          if (newValue != null) onChanged(newValue);
        },
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: TextFormField(
        initialValue: value,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
