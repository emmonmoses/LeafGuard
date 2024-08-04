// ignore_for_file: must_be_immutable
// Project imports:
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package Imports

class PreviewAgent extends StatelessWidget {
  final Agent user;
  VariableService getProperty = VariableService();

  PreviewAgent({super.key, required this.user});

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
    getProperty.file = '${ApiEndPoint.getCustomerImage}/$prop';
  }

  @override
  Widget build(BuildContext context) {
    setVariables(
      context,
      user.avatar,
    );

    // getProperty.formatDateTime(
    //   user.activity?.last_login,
    //   user.activity?.last_logout,
    //   user.createdAt,
    // );

    return SingleChildScrollView(
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
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "profile details".toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CircleAvatar(
              radius: AppTheme.avatarSize,
              backgroundImage: NetworkImage(
                '${ApiEndPoint.getAgentImage}/${user.avatar}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              user.agentNumber!.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.black,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Biodata'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: user.name != null
                                  ? Row(
                                      children: [
                                        const Text('Name:'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${user.name}'.toUpperCase(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        const Text('Name:'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${user.username}'.toUpperCase(),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('username:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${user.username}'.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Email Address:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${user.email}'.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  user.status != 1
                                      ? Row(
                                          children: [
                                            Tooltip(
                                              message: 'In Active',
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
                                                  'In Active'.toUpperCase()),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Tooltip(
                                              message: 'Active',
                                              child: Icon(
                                                Icons.verified_sharp,
                                                color: AppTheme.green,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child:
                                                  Text('Active'.toUpperCase()),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: AppTheme.dividerThickness,
                      color: AppTheme.main,
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Address'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  user.address != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Address 1:',
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                    user.address!.toUpperCase(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              children: [
                                                // Text(
                                                //   'Zipcode:',
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //     left: 8.0,
                                                //   ),
                                                //   child: Text(
                                                //     '${user.address!}'
                                                //         .toUpperCase(),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            // Row(
                                            //   children: [
                                            //     const Text(
                                            //       'City:',
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //         left: 8.0,
                                            //       ),
                                            //       child: Text(
                                            //         '${user.address!}'
                                            //             .toUpperCase(),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text('State:'),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //         left: 8.0,
                                            //       ),
                                            //       child: Text(
                                            //         '${user.address!.}'
                                            //             .toUpperCase(),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text(
                                            //       'Country:',
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //               left: 8.0),
                                            //       child: Text(
                                            //         '${user.address!.}'
                                            //             .toUpperCase(),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // )
                                          ],
                                        )
                                      : Text(
                                          'There is no address associated with  ${user.email}'
                                              .toUpperCase(),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: AppTheme.dividerThickness,
                      color: AppTheme.main,
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Telephone'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: user.phone != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Country Code:'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                user.phone!.code.toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Phone Number:'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                user.phone!.number.toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'There is no phonenumber associated with  ${user.email}'
                                          .toUpperCase(),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: AppTheme.dividerThickness,
                      color: AppTheme.main,
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 8.0),
                    //           child: Text(
                    //             'Log activity'.toUpperCase(),
                    //             style: const TextStyle(
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 8.0),
                    //           child: user.activity != null
                    //               ? Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Row(
                    //                       children: [
                    //                         const Text('Last Login:'),
                    //                         Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               left: 8.0),
                    //                           child: Text(
                    //                             getProperty.login!,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Row(
                    //                       children: [
                    //                         const Text('Last Logot:'),
                    //                         Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               left: 8.0),
                    //                           child: Text(
                    //                             getProperty.logout!,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 )
                    //               : Text(
                    //                   'There is no phonenumber associated with  ${user.email}'
                    //                       .toUpperCase(),
                    //                 ),
                    //         ),
                    //         Row(
                    //           children: [
                    //             const Text('CreatedOn:'),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 8.0),
                    //               child: Text(
                    //                 getProperty.created!,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
