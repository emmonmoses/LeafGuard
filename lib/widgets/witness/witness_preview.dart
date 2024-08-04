// ignore_for_file: must_be_immutable
// Project imports:
import 'package:leafguard/models/witness/witnesses.dart';
import 'package:leafguard/services/variables_service.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';

// Package Imports

class PreviewWitness extends StatelessWidget {
  final Witnesses witness;

  PreviewWitness({
    super.key,
    required this.witness,
  });

  VariableService getProperty = VariableService();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: scrollController,
      itemCount: witness.witnesses!.length,
      itemBuilder: (context, index) {
        // Witnesses witness = widget.witness.witnesses![index];
        return Visibility(
          visible: getProperty.isVisible,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.kDefaultPadding * 0.75,
              ),
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(witness.witnesses![index].name!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(witness.witnesses![index].phone!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(witness.witnesses![index].document!),
                    ),
                  ],
                ),
                trailing: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppTheme.main,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      witness.witnesses![index].nationalId!,
                      // 'NATIONAL ID: ${widget.witness.witnesses![index].nationalId!}',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
