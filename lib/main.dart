import 'dart:io';

import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/controller/creditNoteController/credit_note_controller.dart';
import 'package:accountech/controller/debitNoteController/debit_note_controller.dart';
import 'package:accountech/controller/expenseController/expense_controller.dart';
import 'package:accountech/controller/goodsInTransitController/goods_in_transit_controller.dart';
import 'package:accountech/controller/itemController/item_controller.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/controller/purchaseOrderController/purchase_order_controller.dart';
import 'package:accountech/controller/purchaseReturnController/purchase_return_controller.dart';
import 'package:accountech/controller/salesController/sales_controller.dart';
import 'package:accountech/controller/salesInvoiceController/sales_invoice_controller.dart';
import 'package:accountech/controller/warehouseController/warehouse_controller.dart';
import 'package:accountech/view/screens/accountSettings/account_settings_screen.dart';
import 'package:accountech/view/screens/architectFolder/create_architect.dart';
import 'package:accountech/view/screens/authFolder/auth_selection_screen.dart';
import 'package:accountech/view/screens/authFolder/deactivated_screen.dart';
import 'package:accountech/view/screens/authFolder/otp_screen.dart';
import 'package:accountech/view/screens/authFolder/sign_in_screen.dart';
import 'package:accountech/view/screens/authFolder/sign_up_screen.dart';
import 'package:accountech/view/screens/cashAndBankFolder/cash_and_bank_screen.dart';
import 'package:accountech/view/screens/cashAndBankFolder/detail_item_cash_bank_screen.dart';
import 'package:accountech/view/screens/commonScreens/item_listing_screen.dart';
import 'package:accountech/view/screens/creditNoteFolder/credit_note_screen.dart';
import 'package:accountech/view/screens/debitNoteFolder/debit_note_screen.dart';
import 'package:accountech/view/screens/deliveryChallanFolder/delivery_challan_screen.dart';
import 'package:accountech/view/screens/expenseFolder/detail_item_expense_screen.dart';
import 'package:accountech/view/screens/expenseFolder/expense_screen.dart';
import 'package:accountech/view/screens/goodInTransitFolder/add_good_in_transit_screen.dart';
import 'package:accountech/view/screens/goodInTransitFolder/good_in_transit_screen.dart';
import 'package:accountech/view/screens/invoiceFolder/invoice_screen.dart';
import 'package:accountech/view/screens/invoiceThemeSettings/invoice_theme_settings_screen.dart';
import 'package:accountech/view/screens/itemsFolder/create_item_screen.dart';
import 'package:accountech/view/screens/itemsFolder/detail_item_screen.dart';
import 'package:accountech/view/screens/mainFolder/main_screen.dart';
import 'package:accountech/view/screens/manageBusinessSettings/manage_business_settings_screen.dart';
import 'package:accountech/view/screens/partiesFolder/create_party.dart';
import 'package:accountech/view/screens/partiesFolder/detail_party_screen.dart';
import 'package:accountech/view/screens/partiesFolder/edit_party.dart';
import 'package:accountech/view/screens/pricingFolder/pricing_screen.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/proforma_invoice_screen.dart';
import 'package:accountech/view/screens/purchaseFolder/purchase_screen.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/purchase_order_screen.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/purchase_return_screen.dart';
import 'package:accountech/view/screens/quotationFolder/quotation_screen.dart';
import 'package:accountech/view/screens/reminderFolder/reminder_screen.dart';
import 'package:accountech/view/screens/salesOrderFolder/sales_order_screen.dart';
import 'package:accountech/view/screens/salesReturnFolder/sales_return_screen.dart';
import 'package:accountech/view/screens/splashFolder/splash_screen.dart';
import 'package:accountech/view/screens/wareHouseFolder/detail_item_warehouse_screen.dart';
import 'package:accountech/view/screens/wareHouseFolder/warehouse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:shared_value/shared_value.dart';

import 'controller/cashAndBankController/cash_and_bank_controller.dart';
import 'controller/proformaInvoiceController/proforma_invoice_controller.dart';
import 'controller/salesReturnController/sales_return_controller.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  MySharedPreferences.languageCode.load();
  MySharedPreferences.accessToken.load();
  MySharedPreferences.userID.load();
  MySharedPreferences.userName.load();
  MySharedPreferences.businessSelectedID.load();
  MySharedPreferences.businessSelectedName.load();
  Get.put(SalesController());
  Get.put(PartyController());
  Get.put(ItemController());
  Get.put(CashAndBankController());
  Get.put(WarehouseController());
  Get.put(ExpenseController());
  Get.put(GoodsInTransitController());
  Get.put(DebitNoteController());
  Get.put(PurchaseReturnController());
  // Get.put(PurchaseController());
  Get.put(PurchaseOrderController());
  Get.put(SalesReturnController());
  Get.put(CreditNoteController());
  Get.put(ProformaInvoiceController());
  Get.put(SalesInvoiceController());

  runApp(
    SharedValue.wrapApp(
      Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accountech',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.splashScreenRoute,
      routes: {
        SplashScreen.splashScreenRoute: (context) => const SplashScreen(),
        MainScreen.mainScreenRoute: (context) => const MainScreen(),
        CreateParty.createPartyRoute: (context) => const CreateParty(),
        CreateItemScreen.createItemScreenRoute: (context) =>
            const CreateItemScreen(),
        EditParty.editPartyRoute: (context) => const EditParty(),
        DetailPartyScreen.detailPartyRoute: (context) =>
            const DetailPartyScreen(''),
        DetailItemScreen.detailItemRoute: (context) =>
            const DetailItemScreen(''),
        QuotationScreen.quotationScreenRoute: (context) =>
            const QuotationScreen(),
        ItemListingScreen.itemListingScreenRoute: (context) =>
            const ItemListingScreen(),
        DeliveryChallanScreen.deliveryChallanScreenRoute: (context) =>
            const DeliveryChallanScreen(),
        InvoiceScreen.invoiceScreenRoute: (context) => const InvoiceScreen(),
        PurchaseOrderScreen.purchaseOrderScreenRoute: (context) =>
            const PurchaseOrderScreen(),
        PurchaseScreen.purchaseScreenRoute: (context) => const PurchaseScreen(),
        PurchaseReturnScreen.purchaseReturnScreenRoute: (context) =>
            const PurchaseReturnScreen(),
        CashAndBankScreen.cashAndBankRoute: (context) =>
            const CashAndBankScreen(),
        DetailItemCashBankScreen.detailItemCashBankRoute: (context) =>
            const DetailItemCashBankScreen(),
        ExpenseScreen.expenseScreenRoute: (context) => const ExpenseScreen(),
        DetailItemExpenseScreen.detailItemExpenseRoute: (context) =>
            const DetailItemExpenseScreen(),
        WarehouseScreen.wareHouseRoute: (context) => const WarehouseScreen(),
        DetailItemWarehouseScreen.detailItemWarehouseRoute: (context) =>
            const DetailItemWarehouseScreen(),
        SalesOrderScreen.salesOrderScreenRoute: (context) =>
            const SalesOrderScreen(),
        ProformaInvoiceScreen.proformaInvoiceScreenRoute: (context) =>
            const ProformaInvoiceScreen(),
        CreditNoteScreen.creditNoteScreenRoute: (context) =>
            const CreditNoteScreen(),
        SalesReturnScreen.salesReturnScreenRoute: (context) =>
            const SalesReturnScreen(),
        DebitNoteScreen.debitNoteScreen: (context) => const DebitNoteScreen(),
        GoodInTransitScreen.goodInTransitRoute: (context) =>
            const GoodInTransitScreen(),
        AccountSettingsScreen.accountSettingsScreenRoute: (context) =>
            const AccountSettingsScreen(),
        ManageBusinessSettingsScreen.manageBusinessSettingsScreenRoute:
            (context) => const ManageBusinessSettingsScreen(),
        InvoiceThemeSettingsScreen.invoiceThemeSettingsScreenRoute: (context) =>
            const InvoiceThemeSettingsScreen(),
        ReminderScreen.reminderScreenRoute: (context) => const ReminderScreen(),
        PricingScreen.pricingScreenRoute: (context) => const PricingScreen(),
        AuthSelectionScreen.authSelectionScreenRoute: (context) =>
            const AuthSelectionScreen(),
        SignInScreen.signInScreenRoute: (context) => const SignInScreen(),
        SignUpScreen.signUpScreenRoute: (context) => const SignUpScreen(),
        OTPScreen.oTPScreenRoute: (context) => const OTPScreen(),
        CreateArchitect.createArchitectRoute: (context) =>
            const CreateArchitect(),
        DeactivatedScreen.deactivatedScreenRoute: (context) =>
            const DeactivatedScreen(),
      },
    );
  }
}
