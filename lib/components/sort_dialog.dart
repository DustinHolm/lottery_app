import 'package:flutter/material.dart';
import 'package:lottery_app/filter/ending_soonest_sort.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/filter/least_bids_sort.dart';

class SortDialog extends StatelessWidget {
  const SortDialog(
      {required this.transformations,
      required this.handleTransformationsUpdate,
      Key? key})
      : super(key: key);

  final List<ITransform> transformations;
  final Function(List<ITransform>) handleTransformationsUpdate;

  List<ITransform> prune(List<ITransform> original) {
    return original.where((transform) {
      if (transform.runtimeType == EndingSoonestSort) return false;
      if (transform.runtimeType == LeastBidsSort) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Sortieren nach"),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: const Text("Bald zuende"),
          onPressed: () {
            handleTransformationsUpdate([...prune(transformations), EndingSoonestSort()]);
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: const Text("Wenigste Gebote"),
          onPressed: () {
            handleTransformationsUpdate([...prune(transformations), LeastBidsSort(asc: true)]);
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: const Text("Meiste Gebote"),
          onPressed: () {
            handleTransformationsUpdate([...prune(transformations), LeastBidsSort(asc: false)]);
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: const Text("Nichts"),
          onPressed: () {
            handleTransformationsUpdate(prune(transformations));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
