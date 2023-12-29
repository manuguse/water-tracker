import 'package:flutter/material.dart';

class ValueSelector<T> extends StatefulWidget {
  final T value;
  final Map<T, String> valueMap;
  final Null Function(T value) onSelect;
  final double paddingHorizontal;

  const ValueSelector(
      {super.key,
      required this.value,
      required this.valueMap,
      required this.onSelect,
      this.paddingHorizontal = 0})
      : assert(
            valueMap.length >= 2, 'The valueMap\'s size must be at least 2.');

  @override
  State<ValueSelector<T>> createState() => _ValueSelectorState<T>();
}

class _ValueSelectorState<T> extends State<ValueSelector<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.valueMap.length == 2) {
      return Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.valueMap.keys.first),
              child: Container(
                decoration: BoxDecoration(
                    color: widget.value == widget.valueMap.keys.first
                        ? const Color(0xFF3688D3)
                        : const Color(0xFF97C5EF),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(30))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.valueMap.values.first,
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.value == widget.valueMap.keys.first
                              ? Colors.white
                              : null),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.valueMap.keys.last),
              child: Container(
                decoration: BoxDecoration(
                    color: widget.value == widget.valueMap.keys.last
                        ? const Color(0xFF3688D3)
                        : const Color(0xFF97C5EF),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(30))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.valueMap.values.last,
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.value == widget.valueMap.keys.last
                              ? Colors.white
                              : null),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: widget.paddingHorizontal,
            ),
            Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.valueMap.entries.map((e) {
                  final key = GlobalKey();
                  return Padding(
                    key: key,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () {
                        if (key.currentContext != null) {
                          Scrollable.ensureVisible(key.currentContext!,
                              duration: const Duration(milliseconds: 750));
                        }

                        widget.onSelect(e.key);
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: widget.value == e.key
                                ? const Color(0xFF3688D3)
                                : const Color(0xFF97C5EF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              e.value,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: widget.value == e.key
                                      ? Colors.white
                                      : null),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()),
            SizedBox(
              width: widget.paddingHorizontal,
            ),
          ],
        ),
      );
    }
  }
}
