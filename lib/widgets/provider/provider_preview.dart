// ignore_for_file: must_be_immutable, avoid_returning_null_for_void, unnecessary_null_comparison, use_key_in_widget_constructors
// Project imports:

import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/witness/witnessresponse.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewProvider extends StatefulWidget {
  final ServiceProvider provider;

  const PreviewProvider({
    // super.key,
    required this.provider,
  });

  @override
  State<PreviewProvider> createState() => _PreviewProviderState();
}

class _PreviewProviderState extends State<PreviewProvider> {
  VariableService getProperty = VariableService();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getProperty.getPermissions(context);
    super.initState();
  }

  List<WitnessResponse>? witnesses;
  WitnessFactory? fnc;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      getProperty.isLoading = true;
    });

    getWitnesses();

    setState(() {
      getProperty.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setVariables(
      context,
      widget.provider.avatar,
    );

    return getProperty.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: -40,
                        width: getProperty.width,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-6.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-5.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              "profile details".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: AppTheme.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.provider.avatar != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: CircleAvatar(
                          radius: AppTheme.avatarSize,
                          backgroundImage: NetworkImage(
                            '${ApiEndPoint.getProviderImage}/${widget.provider.avatar}',
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Image.asset(
                          ApiEndPoint.appLogo,
                          width: 190.0,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.provider.taskerNumber!.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.black,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'name'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  widget.provider.name != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${widget.provider.name}'
                                                    .toUpperCase(),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${widget.provider.username}'
                                                    .toUpperCase(),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'username'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.provider.username}'
                                              .toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'email'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.provider.email}'
                                              .toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  widget.provider.status != 1
                                      ? Row(
                                          children: [
                                            Tooltip(
                                              message: 'Not Verified',
                                              child: Icon(
                                                Icons.verified_sharp,
                                                color: AppTheme.red,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                  'Not Verified'.toUpperCase()),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Tooltip(
                                              message: 'Verified',
                                              child: Icon(
                                                Icons.verified_sharp,
                                                color: AppTheme.green,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                  'Verified'.toUpperCase()),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          widget.provider.availability_address != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'id'.toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '${widget.provider.taskerNumber}',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'address'.toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '${widget.provider.availability_address}'
                                                  .toUpperCase(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'experience'.toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '${widget.provider.experience!.name}'
                                                  .toUpperCase(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        widget.provider.taskerStatus != 0
                                            ? Row(
                                                children: [
                                                  Tooltip(
                                                    message: 'Active',
                                                    child: Icon(
                                                      Icons.verified_sharp,
                                                      color: AppTheme.green,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                        'Active'.toUpperCase()),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Tooltip(
                                                    message: 'In Active',
                                                    child: Icon(
                                                      Icons.verified_sharp,
                                                      color: AppTheme.red,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text('In Active'
                                                        .toUpperCase()),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    const Text("")
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                widget.provider.phone != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'code'.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    '${widget.provider.phone!.code}',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'phone'.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    '${widget.provider.phone!.number}',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Text('')
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      const Text(
                        'Witness Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      // Check if witnesses is null or empty, and display accordingly
                      if (witnesses == null || witnesses!.isEmpty)
                        const Center(
                          child: Text('No witnesses available'),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            witnesses![0].witnesses!.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(witnesses![0]
                                            .witnesses![index]
                                            .name!),
                                        Text(witnesses![0]
                                            .witnesses![index]
                                            .phone!),
                                        witnesses![0]
                                                    .witnesses![index]
                                                    .document! !=
                                                null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    '${ApiEndPoint.getWitnessImage}/${witnesses![0].witnesses![index].document!}',
                                                  ),
                                                ),
                                              )
                                            : const Text(
                                                'No Witness Document Found'),
                                        if (getProperty.permissions!.any(
                                            (permission) => permission.actions!
                                                .any((action) =>
                                                    action.name ==
                                                    'create_witnesses')))
                                          Row(
                                            children: [
                                              IconButton(
                                                tooltip: 'Update',
                                                onPressed: () {
                                                  RouteService.updateWitness(
                                                    context,
                                                    witnesses![0],
                                                    widget.provider,
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    trailing: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
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
                                          witnesses![0]
                                              .witnesses![index]
                                              .nationalId!,
                                          style: TextStyle(
                                            color: AppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
    getProperty.file = '${ApiEndPoint.getWitnessImage}/$prop';
  }

  Future getWitnesses() async {
    fnc = Provider.of<WitnessFactory>(context, listen: false);
    // Use try-catch to handle potential errors
    try {
      var result = await fnc!.getWitnessByTaskerId(widget.provider.id);
      // Check if result is not null before assigning it to witnesses
      if (result != null) {
        setState(() {
          witnesses = result;
        });
      } else {
        // Handle the case when result is null (no witnesses)
        setState(() {
          witnesses = [];
        });
      }
    } catch (error) {
      // Handle other types of errors if needed
    }
  }
}
