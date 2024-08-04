// ignore_for_file: use_build_context_synchronously, library_prefixes, avoid_web_libraries_in_flutter, prefer_interpolation_to_compose_strings
import 'dart:async';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/dob/dob.dart';
import 'package:leafguard/models/experience/experience.dart';
import 'package:leafguard/models/location/location.dart';
import 'package:leafguard/models/permissions/permissions.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/profileDetails/profile.dart';
import 'package:leafguard/models/question/question.dart';
import 'package:leafguard/models/service/service.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/signin/signin_response.dart';
import 'package:leafguard/models/skills/skills.dart';
import 'package:leafguard/models/tax/tax.dart';
import 'package:leafguard/models/workingDays/working_days.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/experience/experienceFactory.dart';
import 'package:leafguard/services/login/login_factory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/models/search/search.dart';
import 'package:leafguard/services/question/questionFactory.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/services/serviceFactory.dart';
import 'package:leafguard/services/toaster_service.dart';

import 'package:leafguard/themes/app_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:http/http.dart' as http;

class VariableService {
  final baseUrl = ApiEndPoint.endpoint;
  bool isInit = true;
  bool isActive = true;
  bool isTax = true;
  bool isObscure = true;
  bool isVisible = true;
  bool isLoading = false;
  bool activeColor = false;
  bool isInvisible = false;
  bool uploadVisible = false;
  bool passwordVisible = false;
  bool newpasswordVisible = false;
  bool confirmpasswordVisible = false;

  bool invalidCredential = false;
  bool thumbnailTrueFalse = true;

  double? width;
  String? file;
  String? login;
  String? logout;
  String? created;

  int userStatus = 0;
  int providerStatus = 0;
  int availabilityStatus = 0;
  int currentStep = 0;
  num hourRate = 0;
  int radiusValue = 100;
  int page = 1, pages = 1;

  dynamic latitude = 9.005401;
  dynamic longitude = 38.763611;

  bool morning = false, afternoon = false, evening = false;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  Phone phone = Phone();
  Location location = Location();
  BirthDate birthDate = BirthDate();
  WorkingDay workTime = WorkingDay();

  PlatformFile? objFile;
  String profilePic = '';
  String? selectedCategoryValue;
  String? selectedExperienceValue;
  String delimiter = "(";

  String? selectedProviderValue;
  String? selectedServiceValue;
  String dropdownGender = 'Choose Gender*';
  String dropdownExperience = 'Skill Level';
  String dropdownRate = 'Rate Type*';
  dynamic imagePath, imageName, imageSize, imageStream;

  SignInResponse? result;
  Constants search = Constants();
  ProfileDetails profile = ProfileDetails();
  QuestionFactory? fnq;
  CategoryFactory? fnc;
  ServiceFactory? fnsc;
  ServiceProviderFactory? fnp;
  ExperienceFactory? fne;

  DateTime currentDatee = DateTime.now();

  late List<bool> checkedList;
  //
  List<Question> questions = [];
  List<Tax> taxess = [];
  List<Question> filteredQuestions = [];
  //
  List<Category> categories = [];
  // List<Category> subcategories = [];
  List<Category> filteredCategories = [];

  List<Experience> experiences = [];

  List<Experience> filteredexperiences = [];
  //
  List<Service> services = [];
  List<Service> filteredServices = [];
  //
  List<ServiceProvider> taskers = [];
  List<ServiceProvider> filteredTaskers = [];

  List<WorkingDay> workingDays = [];
  List<ProfileDetails> profileDetails = [];
  List<bool> genderSelection = [false, false];
  List<ServiceProviderSkills> taskerskills = [];
  List<TextEditingController> answersController = [];
  //
  List<Billing> billings = [];
  List<Billing> filteredBillings = [];

  List<Permissions>? permissions;

  DropdownStyleData dropDownStyleDataMethod() {
    return DropdownStyleData(
      maxHeight: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(40),
        thickness: WidgetStateProperty.all<double>(6),
        thumbVisibility: WidgetStateProperty.all<bool>(true),
      ),
    );
  }

  IconStyleData iconStyleMethod() {
    return IconStyleData(
      icon: const Icon(
        Icons.arrow_forward_ios_outlined,
      ),
      iconEnabledColor: AppTheme.main,
      iconDisabledColor: AppTheme.grey,
    );
  }

  ButtonStyleData buttonStyleMethod() {
    return ButtonStyleData(
      padding: const EdgeInsets.only(left: 14, right: 14),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.grey,
        ),
        color: AppTheme.white,
      ),
      elevation: 2,
    );
  }

  getPermissions(context) {
    permissions = Provider.of<LoginFactory>(context, listen: false).permission;
  }

  void generateTextControllers(qns) {
    for (int i = 0; i < qns.length; i++) {
      answersController.add(TextEditingController());
    }
  }

  void setQuestionVariables(QuestionFactory fnq) {
    pages = fnq.totalPages;
    page = fnq.currentPage;
    questions = fnq.questions;
    filteredQuestions = questions;
    generateTextControllers(questions);
  }

  void setCategoryVariables(CategoryFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    categories = fnc.categories;
    filteredCategories = categories;
  }

  void setExperienceVariables(ExperienceFactory fne) {
    pages = fne.totalPages;
    page = fne.currentPage;
    experiences = fne.experiences;
    filteredexperiences = experiences;
  }

  void setServiceVariables(ServiceFactory fnsc) {
    pages = fnsc.totalPages;
    page = fnsc.currentPage;
    services = fnsc.services;
    filteredServices = services;
  }

  void setProviderVariables(ServiceProviderFactory fnp) {
    pages = fnp.totalPages;
    page = fnp.currentPage;
    taskers = fnp.serviceproviders;
    filteredTaskers = taskers;
  }

  loadData(context) async {
    fnq = Provider.of<QuestionFactory>(context, listen: false);
    fnc = Provider.of<CategoryFactory>(context, listen: false);
    fnsc = Provider.of<ServiceFactory>(context, listen: false);
    fnp = Provider.of<ServiceProviderFactory>(context, listen: false);
    fne = Provider.of<ExperienceFactory>(context, listen: false);

    await fne!
        .getAllExperiences(search.page)
        .then((r) => {setExperienceVariables(fne!)});

    await fnq!
        .getAllQuestions(search.page)
        .then((r) => {setQuestionVariables(fnq!)});

    await fnc!
        .getAllCategoriesWithMorePageSize(search.page)
        .then((r) => {setCategoryVariables(fnc!)});

    await fnsc!
        .getAllServices(search.page)
        .then((r) => {setServiceVariables(fnsc!)});

    await fnp!
        .getAllServiceProviders(search.page)
        .then((r) => {setProviderVariables(fnp!)});
  }

  searchText(String val) {
    search.searchText = val.toLowerCase();
    filteredQuestions = questions
        .where((question) =>
            question.question!.toLowerCase().contains(search.searchText))
        .toList();

    if (filteredQuestions.isEmpty) {
      isInvisible = true;
      isVisible = false;
    }
  }

  Widget controlBuilders(context, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        details.currentStep != 4
            ? Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text(
                    'Next >>',
                  ),
                ),
              )
            : const Text(''),
        details.currentStep == 4
            ? Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text(
                    'Save',
                  ),
                ),
              )
            : const Text('')
      ],
    );
  }

  formatDateTime(logn, logt, crt) {
    login = DateFormat('dd-MM-yyyy').format(logn);
    logout = DateFormat('dd-MM-yyyy').format(logt);
    created = DateFormat('dd-MM-yyyy').format(crt);
  }

  static Future<void> selectDate(
    TextEditingController controller,
    TextEditingController fromController,
    TextEditingController toController,
    BuildContext ctx,
  ) async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      DateTime fromDateTime;
      if (fromController.text.isNotEmpty) {
        fromDateTime = DateTime.parse(fromController.text);
      } else {
        fromDateTime = currentDate;
      }

      if (controller == toController && picked.isBefore(fromDateTime)) {
        // Display an error message if Valid To is before Valid From
        snackBarNotification(ctx, ToasterService.dateError);
      } else {
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        controller.text = formattedDate;
        if (controller == fromController && toController.text.isNotEmpty) {
          // Clear Valid To if Valid From is changed and Valid To was set
          toController.clear();
        }
      }
    }
  }

  generateRandomValue() {
    const String characters = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    String randomValue = '';

    for (int i = 0; i < 2; i++) {
      int randomIndex = random.nextInt(characters.length);
      randomValue += characters[randomIndex];
    }

    return randomValue;
  }

  String? adminCommission, providerCommission, agentsCommission, govtCommission;

  removeDelimiter(transaction, commission) {
    int delimiterIndex = transaction!.commission!.indexOf(delimiter);
    if (delimiterIndex != -1) {
      String substringBeforeDelimiter =
          transaction!.commission!.substring(0, delimiterIndex);
      adminCommission = substringBeforeDelimiter;
      // providerCommission = substringBeforeDelimiter;
      // agentsCommission = substringBeforeDelimiter;
      // govtCommission = substringBeforeDelimiter;
    }
  }

  final imageUrl = 'http://etonestop.com/admin/logo.png';

  Future<List<int>> getImageBytes(imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  void printTransactionPDF(transaction, receiptName) async {
    var uniqueId = generateRandomValue();

    final pdf = pw.Document();

    // load the logo image
    // final imageUrl = 'https://example.com/path/to/your/image.png';
    final logoData = await getImageBytes(imageUrl);
    final logoBytes = Uint8List.fromList(logoData);
    final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // final logoData = await html.HttpRequest.request('./assets/logo.PNG',
    //     responseType: 'arraybuffer');
    // final logoBytes = Uint8List.view(logoData.response);
    // final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // Form header
    final formHeader = pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Column(
        children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(
                ' Date: ${currentDatee.year}-${currentDatee.month}-${currentDatee.day}'),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'ReceiptNo:'.toUpperCase(),
                style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
              ),
              pw.Text(
                ' $receiptName$uniqueId'.toUpperCase(),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );

    // Create the table rows for a single transaction
    final tableRow = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 5),
          child: pw.Text(
            'Booking Details'.toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Booking Ref:'),
                    pw.Text(
                      transaction.bookingRef != null
                          ? transaction.bookingRef!.toString().toUpperCase()
                          : 'No BookingRef',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Transaction Ref:'),
                    pw.Text(
                      transaction.transactionRef != null
                          ? transaction.transactionRef!.toString().toUpperCase()
                          : 'No TransactionRef',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Date Created:'),
                    pw.Text(
                      DateFormat('yyyy-MM-dd').format(
                        transaction.transactionDate!,
                      ),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Service Type: '),
                    pw.Text(
                      transaction.tasker != null
                          ? transaction.service!.name!.toString()
                          : 'Service Type',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 5),
          child: pw.Text(
            'Provider Details'.toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('ID#: '),
                    pw.Text(
                      transaction.tasker != null
                          ? transaction.tasker!.taskerNumber
                              .toString()
                              .toUpperCase()
                          : 'No Provider Number',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Name: '),
                    pw.Text(
                      transaction.tasker != null
                          ? transaction.tasker!.name.toString().toUpperCase()
                          : 'No Provider Name',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Telephone: '),
                    pw.Text(
                      transaction.tasker != null
                          ? '${transaction.tasker!.phone!.code!} ${transaction.tasker!.phone!.number!}'
                          : 'No Provider phone',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 5),
          child: pw.Text(
            'Customer Details'.toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('ID#: '),
                    pw.Text(
                      transaction.customer != null
                          ? transaction.customer!.customerNumber.toString()
                          : 'No Customer Number',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Name: '),
                    pw.Text(
                      transaction.customer != null
                          ? transaction.customer!.name!.toString().toUpperCase()
                          : 'No Customer Name',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Telephone: '),
                    pw.Text(
                      transaction.customer != null
                          ? '${transaction.customer!.phone!.code!} ${transaction.customer!.phone!.number!}'
                          : 'No Customer Phone',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 5),
          child: pw.Text(
            'Invoice'.toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Hourly Price: '),
                pw.Text(
                  transaction.tasker != null
                      ? 'ETB.${transaction.price.toString()}'
                      : 'Hourly Price',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
          ],
        ),
        pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Hours Worked: '),
                pw.Text(
                  transaction.tasker != null
                      ? transaction.totalHoursWorked.toString()
                      : 'Hours Worked',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
          ],
        ),
        pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Base price: '),
                pw.Text(
                  transaction.tasker != null
                      ? 'ETB.${transaction.basePrice.toString()}'
                      : 'Base price',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Tax:',
                ),
                pw.Text(
                  'ETB.${transaction.tax.amount}'.toUpperCase(),
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
          ],
        ),
        pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Discount:',
                ),
                pw.Text(
                  'ETB.${transaction.discount.amount}'.toUpperCase(),
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 25),
          ],
        ),
        pw.Container(
          padding: const pw.EdgeInsets.only(left: 375),
          decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.black, //color of border
                width: 1, //width of border
              ),
              borderRadius: pw.BorderRadius.circular(5)),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 15, right: 3),
                child: pw.Text(
                  'AD Fee: ETB.${transaction.adminCommission!.amount}'
                      .toUpperCase(),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 15, right: 3),
                child: pw.Text(
                  'SP Fee: ETB.${transaction.taskerCommission.amount}'
                      .toUpperCase(),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 15, bottom: 3, right: 3),
                child: pw.Text(
                  'Amount: ETB.${transaction.total}'.toUpperCase(),
                  style: pw.TextStyle(
                    color: PdfColors.red,
                    fontWeight: pdfWidgets.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // Add the logo, form header, and the table row to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Image(
              logoImage,
              width: 200,
            ),
            pw.SizedBox(height: 20),
            formHeader,
            pw.SizedBox(height: 20),
            tableRow,
          ],
        ),
      ),
    );

    // Save the PDF file
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${receiptName}_receipt.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  void generateAgentTransactionPDF(transactions, reportName) async {
    final pdf = pw.Document();

    // load the logo image
    final logoData = await getImageBytes(imageUrl);
    final logoBytes = Uint8List.fromList(logoData);
    final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // final logoData = await html.HttpRequest.request('./assets/logo.PNG',
    //     responseType: 'arraybuffer');
    // final logoBytes = Uint8List.view(logoData.response);
    // final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // Create the table headers
    final headers = [
      'BK#',
      'TR#',
      // 'Agent',
      'Tax',
      'Disc',
      'Ad Comm',
      'Ag Comm',
      'Amount'
    ];
    final tableHeaders = headers
        .map((header) => pw.Text(
              header,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ))
        .toList();

    // Create the table rows
    final tableRows = transactions.map((transaction) {
      final bookingRef = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(transaction.bookingRef != null
            ? transaction.bookingRef!.toString().toUpperCase()
            : 'No BookingRef'.toUpperCase()),
      );
      final transactionRef = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(transaction.transactionRef != null
            ? transaction.transactionRef!.toString().toUpperCase()
            : 'No TransactionRef'.toUpperCase()),
      );

      final tax = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.tax.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            color: PdfColors.green,
          ),
        ),
      );
      final discount = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.discount.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            color: PdfColors.green,
          ),
        ),
      );
      final admincommission = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.adminCommission.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            color: PdfColors.green,
          ),
        ),
      );
      final agentcommission = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.agentCommission.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            color: PdfColors.green,
          ),
        ),
      );
      final total = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.total}'.toUpperCase(),
          style: const pw.TextStyle(
            color: PdfColors.green,
          ),
        ),
      );
      //
      return pw.TableRow(
        children: [
          bookingRef,
          transactionRef,
          // agent,
          tax,
          discount,
          admincommission,
          agentcommission,
          total,
        ],
      );
    }).toList();

    // Add the logo and the table to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            // pw.Image(logoImage),
            pw.Image(
              logoImage,
              width: 200,
              // height: 100,
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: tableHeaders
                      .map(
                        (header) => pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: header,
                        ),
                      )
                      .toList(),
                ),
                ...tableRows,
              ],
            ),
          ],
        ),
      ),
    );

    // Save the PDF file
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${reportName}_transactionreport.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  void generateTaskerTransactionPDF(transactions, reportName) async {
    final pdf = pw.Document();

    // load the logo image
    final logoData = await getImageBytes(imageUrl);
    final logoBytes = Uint8List.fromList(logoData);
    final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // final logoData = await html.HttpRequest.request('./assets/logo.PNG',
    //     responseType: 'arraybuffer');
    // final logoBytes = Uint8List.view(logoData.response);
    // final logoImage = pdfWidgets.MemoryImage(logoBytes);

    // Create the table headers
    final headers = [
      'BK#',
      'TR#',
      'Provider',
      'Tax',
      'Disc',
      'Ad Comm',
      'Ag Comm',
      'Amount'
    ];
    final tableHeaders = headers
        .map((header) => pw.Text(
              header,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ))
        .toList();

    // Create the table rows
    final tableRows = transactions.map((transaction) {
      final bookingRef = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(transaction.bookingRef != null
            ? transaction.bookingRef!.toString().toUpperCase()
            : 'No BookingRef'.toUpperCase()),
      );
      final transactionRef = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(transaction.transactionRef != null
            ? transaction.transactionRef!.toString().toUpperCase()
            : 'No TransactionRef'.toUpperCase()),
      );
      final agent = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(transaction.tasker != null
            ? transaction.tasker!.taskerNumber.toString().toUpperCase()
            : 'No Provider'.toUpperCase()),
      );
      final tax = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.tax.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            // color: transaction.paymentStatus ? PdfColors.red : PdfColors.green,
            color: PdfColors.green,
          ),
        ),
      );
      final discount = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.discount.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            // color: transaction.paymentStatus ? PdfColors.red : PdfColors.green,
            color: PdfColors.green,
          ),
        ),
      );
      final admincommission = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.adminCommission.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            // color: transaction.paymentStatus ? PdfColors.red : PdfColors.green,
            color: PdfColors.green,
          ),
        ),
      );
      final agentcommission = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.agentCommission.amount}'.toUpperCase(),
          style: const pw.TextStyle(
            // color: transaction.paymentStatus ? PdfColors.red : PdfColors.green,
            color: PdfColors.green,
          ),
        ),
      );
      final total = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          '${transaction.total}'.toUpperCase(),
          style: const pw.TextStyle(
            // color: transaction.paymentStatus ? PdfColors.red : PdfColors.green,
            color: PdfColors.green,
          ),
        ),
      );
      //
      return pw.TableRow(
        children: [
          bookingRef,
          transactionRef,
          agent,
          tax,
          discount,
          admincommission,
          agentcommission,
          total,
        ],
      );
    }).toList();

    // Add the logo and the table to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          // mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            // pw.Image(logoImage),
            pw.Image(
              logoImage,
              width: 200,
              // height: 100,
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: tableHeaders
                      .map(
                        (header) => pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: header,
                        ),
                      )
                      .toList(),
                ),
                ...tableRows,
              ],
            ),
          ],
        ),
      ),
    );

    // Save the PDF file
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${reportName}_transactionreport.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
