// ignore_for_file: must_be_immutable
// Project imports:
import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package Imports

class PreviewCompany extends StatelessWidget {
  final Company company;
  VariableService getProperty = VariableService();

  PreviewCompany({super.key, required this.company});

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
  }

  @override
  Widget build(BuildContext context) {
    // getProperty.formatDateTime(
    //   company.activity?.last_login,
    //   company.activity?.last_logout,
    //   company.createdAt,
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
                  width: getProperty.width ?? MediaQuery.of(context).size.width,
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
                  width: getProperty.width ?? MediaQuery.of(context).size.width,
                  child: FadeAnimation(
                    1.3,
                    Container(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Company details".toUpperCase(),
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
                '${ApiEndPoint.getCompanyImage}/${company.avatar}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: company.code != null
                ? Text(
                    company.code!.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.black,
                        ),
                  )
                : null,
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
                              child: Row(
                                children: [
                                  const Text('Company Name:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${company.name}'.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Tin Number:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${company.tinnumber}'.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 8.0),
                            //   child: Row(
                            //     children: [
                            //       const Text('Description:'),
                            //       Padding(
                            //         padding: const EdgeInsets.only(left: 8.0),
                            //         child: Text(
                            //             company.description.toString()),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Email Address:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${company.email}'.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  company.status != true
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
                                  company.address != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'City:',
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                    '${company.address!.city}'
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Country:',
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    '${company.address!.country}'
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : Text(
                                          'There is no address associated with  ${company.email}'
                                              .toUpperCase(),
                                        ),
                                ],
                              ),
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
                                      child: company.phone != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text('Country Code:'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        company.phone!.code
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('Phone Number:'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        company.phone!.number
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Text(
                                              'There is no phonenumber associated with  ${company.email}'
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
                          ],
                        ),
                      ],
                    ),
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
