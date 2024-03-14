class ApiServices {
  final String _baseURL = "https://myaccountech.com/admin/public/api/";
  final String _assetURL = "http://myaccountech.com/admin/public/";

  String get assetURL => _assetURL;
  String _package = "";
  String _company = "";
  String _expense = "";
  String _party = "";
  String _salesOrder = "";
  String _salesReturn = "";
  String _salesInvoice = "";
  String _creditNote = "";
  String _proformaInvoice = "";
  String _purchase = "";
  String _item = "";
  String _category = "";
  String _series = "";
  String _brand = "";
  String _size = "";
  String _cashAndBank = "";
  String _warehouse = "";
  String _getBusinessTypeEndPoint = "";
  String _getIndustryTypeEndPoint = "";
  String _getPlaceOfSupplyEndPoint = "";
  String _getPackagesEndPoint = "";
  String _getRegisterEndPoint = "";
  String _getCompanyListEndPoint = "";
  String _loginEndPoint = "";
  String _checkUserEndPoint = "";
  String _verifyOTPEndPoint = "";
  String _resendOTPEndPoint = "";
  String _getProfileEndPoint = "";
  String _editProfileEndPoint = "";
  String _deactivateAccountEndPoint = "";
  String _verifyUserEndPoint = "";
  String _getCompanyDetailEndPoint = "";
  String _getExpenseCategoryEndPoint = "";
  String _addExpenseCategoryEndPoint = "";
  String _getExpenseListDataEndPoint = "";

  //party----
  String _getSearchPartyEndPoint = "";
  String _deletePartyEndPoint = "";
  String _getPartyDetailsEndPoint = "";
  String _getPartyEditDetailsEndPoint = "";
  String _getPartyClassEndPoint = "";
  String _createPartyEndPoint = "";
  String _editPartyEndPoint = "";
  String _getCityStateEndPoint = "";
  //------party

  //sales order----

  String _createSalesOrderEndPoint = "";

  //------sales order


  //sales return----

  String _getSalesReturn = "";

  //sales invoice----

  String _getSalesInvoice = "";

  String _deleteSalesInvoice = "";


  //credit note----

  String _getCreditNote = "";
  String _deleteCreditNote = "";

  //credit note----

  String _getProformaInvoice = "";
  String _deleteProformaInvoice = "";


  //---- goods in transit

  String _getGoodsInTransit ="";


  //------
  String _getDebitNote ="";

  //------
  String _getPurchaseReturn ="";

  //------
  String _getPurchase ="";

  //------
  String _getPurchaseOrder ="";


  //item---------
  String _getItemEndPoint = "";
  String _deleteItemEndPoint = "";

  String _createItem = "";

  String _addCategory= "";
  String _addSeries= "";
  String _addBrand= "";
  String _addSize= "";

  String _getCategory= "";
  String _getSeries= "";
  String _getBrand= "";
  String _getSize= "";

  //---------item

  //Cash and Bank
  String _getCashInHand = "";
  //Cash and Bank

  String _getWarehouse = "";
  String _deleteWarehouse = "";
  String _createWarehouse = "";
  String _editWarehouse = "";

  String _addExpenseEndPoint = "";
  String _editExpenseEndPoint = "";
  String _expenseDetailEndPoint = "";
  String _deleteExpenseEndPoint = "";

  String get getExpenseListDataEndPoint => _getExpenseListDataEndPoint;

  ApiServices() {
    _package = "${_baseURL}package/";
    _company = "${_baseURL}company/";
    _expense = "${_baseURL}expense/";
    _party = "${_baseURL}party/";
    _salesOrder = "${_baseURL}sales/";
    _salesReturn = "${_baseURL}sale_return/";
    _salesInvoice = "${_baseURL}sale_invoice/";
    _creditNote = "${_baseURL}credit_note/";
    _proformaInvoice = "${_baseURL}proforma_invoice/";
    _purchase = "${_baseURL}purchase/";
    _item = "${_baseURL}item/";
    _category = "${_baseURL}category/";
    _series = "${_baseURL}series/";
    _brand = "${_baseURL}brand/";
    _size = "${_baseURL}size/";
    _cashAndBank = "${_baseURL}cash_and_bank";
    _warehouse = "${_baseURL}warehouse/";
//Common APIS
    _getBusinessTypeEndPoint = "${_baseURL}get_business_type";
    _getIndustryTypeEndPoint = "${_baseURL}get_industry_type";
    _getPlaceOfSupplyEndPoint = "${_baseURL}get_place";
    _getRegisterEndPoint = "${_baseURL}register";
    _loginEndPoint = "${_baseURL}login";
    _checkUserEndPoint = "${_baseURL}check_user";
    _verifyOTPEndPoint = "${_baseURL}verify_otp";
    _resendOTPEndPoint = "${_baseURL}resend_otp";
    _getProfileEndPoint = "${_baseURL}get_profile/";
    _editProfileEndPoint = "${_baseURL}edit_profile";
    _deactivateAccountEndPoint = "${_baseURL}deactivate_account/";
    _verifyUserEndPoint = "${_baseURL}verify_user";
    _getPartyClassEndPoint = "${_baseURL}get_classes";


//Package Related APIS
    _getPackagesEndPoint = "${_package}get_packages";

//Company Related APIS
    _getCompanyListEndPoint = "${_company}get_company_list";
    _getCompanyDetailEndPoint = "${_company}get_company_detail/";

    // Expense Related APIs
    _getExpenseCategoryEndPoint = "${_expense}get_category/";
    _addExpenseCategoryEndPoint = "${_expense}add_category";
    _getExpenseListDataEndPoint = "${_expense}get_expense/";
    _addExpenseEndPoint = "${_expense}add_expense";
    _editExpenseEndPoint = "${_expense}edit_expense/";
    _expenseDetailEndPoint = "${_expense}expense_detail/";
    _deleteExpenseEndPoint = "${_expense}delete_expense/";


    // Parties Related APIs
    _getSearchPartyEndPoint = "${_party}get_party/";
    _deletePartyEndPoint = "${_party}delete_party/";
    _getPartyDetailsEndPoint = "${_party}party_detail/";
    _getPartyEditDetailsEndPoint = "${_party}get_edit_data/";
    _createPartyEndPoint = "${_party}add_party";
    _editPartyEndPoint = "${_party}edit_party";
    _getCityStateEndPoint = "${_baseURL}get_pincode_data";


    //sales order related apis

    _createSalesOrderEndPoint = "${_salesOrder}add_sales";

    //sales return

    _getSalesReturn = "${_salesReturn}get_sale_return/";

    //sales invoice

    _getSalesInvoice = "${_salesInvoice}get_sale_invoice/";
    _deleteSalesInvoice = "${_salesInvoice}delete_proforma_invoice/";

    //credit note

    _getCreditNote = "${_creditNote}get_credit_note/";
    _deleteCreditNote = "${_creditNote}delete_credit_note/";


    //proforma Invoice

    _getProformaInvoice = "${_proformaInvoice}get_proforma_invoice/";
    _deleteProformaInvoice = "${_proformaInvoice}delete_proforma_invoice/";

    // goods in transit

    _getGoodsInTransit = "${_purchase}goods_in_transit/";

    // debit note

    _getDebitNote = "${_purchase}debit_note/";

    // purchase return

    _getPurchaseReturn = "${_purchase}purchase_return/";

    // purchase

    // _getPurchase = "${_purchase}purchase/";

    // purchase order

    _getPurchaseOrder = "${_purchase}purchase_order/";


    //item

    _getItemEndPoint = "${_item}get_items";
    _deleteItemEndPoint = "${_item}delete_item";

    _createItem = "${_item}add_item";

    _addCategory = "${_category}add_category";
    _addSeries = "${_series}add_series";
    _addBrand = "${_brand}add_brand";
    _addSize = "${_size}add_size";

    _getCategory = "${_category}get_category";
    _getSeries = "${_series}get_series";
    _getBrand = "${_brand}get_brand/";
    _getSize = "${_size}get_size/";

    //cash and bank

    _getCashInHand= _cashAndBank;

    _getWarehouse = "${_warehouse}get_warehouse/";
    _deleteWarehouse = "${_warehouse}delete_warehouse/";
    _createWarehouse = "${_warehouse}add_warehouse";
    _editWarehouse = "${_warehouse}edit_warehouse/";

  }

  //party----
  String get getPartyClassEndPoint => _getPartyClassEndPoint;

  String get getSearchPartyEndPoint => _getSearchPartyEndPoint;
  String get deletePartyEndPoint => _deletePartyEndPoint;

  String get getPartyDetailsEndPoint => _getPartyDetailsEndPoint;
  String get getPartyEditDetailsEndPoint => _getPartyEditDetailsEndPoint;

  String get createPartyEndPoint => _createPartyEndPoint;
  String get editPartyEndPoint => _editPartyEndPoint;
  String get getCityStateEndPoint => _getCityStateEndPoint;

  //----party


  //sales order-------

  String get createSalesOrderEndPoint => _createSalesOrderEndPoint;



  //-------sales order

  //---sales return

  String get getSalesReturn => _getSalesReturn;

  //---sales invoice

  String get getSalesInvoice => _getSalesInvoice;

  //---sales invoice

  String get deleteSalesInvoice => _deleteSalesInvoice;

  //---credit note

  String get getCreditNote => _getCreditNote;

  String get deleteCreditNote => _deleteCreditNote;


  //---proforma invoice

  String get getProformaInvoice => _getProformaInvoice;
  String get deleteProformaInvoice => _deleteProformaInvoice;


  //----goods in  transit

  String get getGoodsInTransit => _getGoodsInTransit;

  //---debit note

  String get getDebitNote => _getDebitNote;
  //---purchase return

  String get getPurchaseReturn => _getPurchaseReturn;

  //---purchase

  String get getPurchase => _getPurchase;

  //---purchase order

  String get getPurchaseOrder => _getPurchaseOrder;



  //item---------
  String get getItemEndPoint => _getItemEndPoint;
  String get deleteItemEndPoint => _deleteItemEndPoint;

  String get createItem => _createItem;

  String get addCategory => _addCategory;
  String get addSeries => _addSeries;
  String get addBrand => _addBrand;
  String get addSize => _addSize;

  String get getCategory => _getCategory;
  String get getSeries => _getSeries;
  String get getBrand => _getBrand;
  String get getSize => _getSize;

  //---------item

  //cash and bank---------

  String get getCashInHand => _getCashInHand;
  String get getBank => _getCashInHand;
  String get getTotal => _getCashInHand;
  String get addMoney => _getCashInHand;

  //------------cash and bank

  //warehouse----------

  String get getWarehouse => _getWarehouse;
  String get deleteWarehouse => _deleteWarehouse;
  String get createWarehouse => _createWarehouse;
  String get editWarehouse => _editWarehouse;

  //----------warehouse

  String get editExpenseEndPoint => _editExpenseEndPoint;

  String get deleteExpenseEndPoint => _deleteExpenseEndPoint;

  String get expenseDetailEndPoint => _expenseDetailEndPoint;

  String get addExpenseEndPoint => _addExpenseEndPoint;

  String get getExpenseCategoryEndPoint => _getExpenseCategoryEndPoint;
  String get addExpenseCategoryEndPoint => _addExpenseCategoryEndPoint;

  String get getCompanyDetailEndPoint =>
      _getCompanyDetailEndPoint; // Account Settings Related APIS
  String get getProfileEndPoint => _getProfileEndPoint;
  String get editProfileEndPoint => _editProfileEndPoint;
  String get deactivateAccountEndPoint => _deactivateAccountEndPoint;


  //===============
  String get verifyUserEndPoint =>
      _verifyUserEndPoint;

  String get resendOTPEndPoint => _resendOTPEndPoint;

  String get checkUserEndPoint => _checkUserEndPoint;

  String get verifyOTPEndPoint => _verifyOTPEndPoint;

  String get loginEndPoint => _loginEndPoint;

  String get getCompanyListEndPoint => _getCompanyListEndPoint;

  String get getRegisterEndPoint => _getRegisterEndPoint;

  String get getPackagesEndPoint => _getPackagesEndPoint;

  String get getIndustryTypeEndPoint => _getIndustryTypeEndPoint;

  String get getPlaceOfSupplyEndPoint => _getPlaceOfSupplyEndPoint;

  String get getBusinessTypeEndPoint => _getBusinessTypeEndPoint;
}
