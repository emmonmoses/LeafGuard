// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class DropDown<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final Widget hint;
  final ValueChanged<T?>? onChanged;
  final bool isCleared;
  final List<Widget> customWidgets;
  final bool isExpanded;

  DropDown({
    super.key,
    required this.items,
    this.initialValue,
    required this.hint,
    this.onChanged,
    this.isCleared = false,
    this.customWidgets = const [],
    this.isExpanded = false,
  });

  @override
  _DropDownState<T> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  void didUpdateWidget(DropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCleared) {
      _selectedItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: widget.isExpanded,
      value: _selectedItem,
      hint: _selectedItem == null ? widget.hint : buildSelectedItemWidget(),
      items: buildDropdownItems(),
      onChanged: (T? value) {
        setState(() {
          _selectedItem = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  Widget buildSelectedItemWidget() {
    for (final item in widget.items) {
      if (item == _selectedItem) {
        return buildDropDownRow(item);
      }
    }
    return widget.hint;
  }

  List<DropdownMenuItem<T>> buildDropdownItems() {
    final items = <DropdownMenuItem<T>>[];
    for (final item in widget.items) {
      items.add(DropdownMenuItem<T>(
        value: item,
        child: buildDropDownRow(item),
      ));
    }
    return items;
  }

  Widget buildDropDownRow(T item) {
    for (final customWidget in widget.customWidgets) {
      return customWidget;
    }
    return Text(item.toString());
  }
}
