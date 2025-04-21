import 'package:desafio_capyba/shared/models/base_model.dart';
import 'package:desafio_capyba/shared/widgets/grid_item_widget.dart';
import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  final List<BaseModel> items;

  const GridWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GridItemWidget(
              item: items[index],
            );
          },
        ),
      ),
    );
  }
}
