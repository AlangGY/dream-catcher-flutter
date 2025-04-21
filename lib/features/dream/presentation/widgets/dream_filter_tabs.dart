import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamFilterTabs extends StatelessWidget {
  final int selectedFilterIndex;
  final List<String> filters;
  final ValueChanged<int> onFilterSelected;

  const DreamFilterTabs({
    super.key,
    required this.selectedFilterIndex,
    required this.filters,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      width: double.infinity,
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(filters.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChoiceChip(
                label: Text(filters[index]),
                selected: selectedFilterIndex == index,
                onSelected: (selected) {
                  if (selected) {
                    onFilterSelected(index);
                  }
                },
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: selectedFilterIndex == index
                      ? Colors.white
                      : const Color(0xFF8080B2),
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: selectedFilterIndex == index
                        ? Colors.transparent
                        : const Color(0xFFB2B2E5),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
