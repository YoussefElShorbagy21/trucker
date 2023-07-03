abstract class OrderStates {}

class  OrderInitialState extends OrderStates {}

class LoadingGetUserDataCurrentTransactions extends OrderStates {}
class SuccessGetUserDataCurrentTransactions extends  OrderStates {}

class LoadingGetCurrentTransactionsData extends OrderStates {}
class SuccessGetCurrentTransactionsData extends  OrderStates {}
class ErrorGetCurrentTransactionsData extends  OrderStates {}

class LoadingGetUserCompanyIdCurrentTransactions extends OrderStates {}
class SuccessGetUserCompanyIdCurrentTransactions extends  OrderStates {}

class LoadingCurrentTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class SuccessCurrentTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class ErrorCurrentTransactionsDetailsCategoryDataOrderState extends OrderStates {}


class LoadingConfirmTicketOrderState extends OrderStates {}
class SuccessConfirmTicketOrderState extends OrderStates {}
class ErrorConfirmTicketOrderState extends OrderStates {
  final String error ;
  ErrorConfirmTicketOrderState(this.error);
}



class LoadingGetUserDataAcceptedTransactions extends OrderStates {}
class SuccessGetUserDataAcceptedTransactions extends  OrderStates {}

class LoadingGetAcceptedTransactionsData extends OrderStates {}
class SuccessGetAcceptedTransactionsData extends  OrderStates {}
class ErrorGetAcceptedTransactionsData extends  OrderStates {}

class LoadingGetUserCompanyIdAcceptedTransactions extends OrderStates {}
class SuccessGetUserCompanyIdAcceptedTransactions extends  OrderStates {}

class LoadingAcceptedTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class SuccessAcceptedTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class ErrorAcceptedTransactionsDetailsCategoryDataOrderState extends OrderStates {}

class LoadingConfirmProcess extends OrderStates {}
class SuccessConfirmProcess extends OrderStates {}
class ErrorConfirmProcess extends OrderStates {
  final String error ;
  ErrorConfirmProcess(this.error);
}


class LoadingGetUserDataDoneTransactions extends OrderStates {}
class SuccessGetUserDataDoneTransactions extends  OrderStates {}

class LoadingGetDoneTransactionsData extends OrderStates {}
class SuccessGetDoneTransactionsData extends  OrderStates {}
class ErrorGetDoneTransactionsData extends  OrderStates {}

class LoadingGetUserCompanyIdDoneTransactions extends OrderStates {}
class SuccessGetUserCompanyIdDoneTransactions extends  OrderStates {}

class LoadingDoneTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class SuccessDoneTransactionsDetailsCategoryDataOrderState extends OrderStates {}
class ErrorDoneTransactionsDetailsCategoryDataOrderState extends OrderStates {}

class LoadingCreateReview extends OrderStates {}
class SuccessCreateReview extends OrderStates {}
class ErrorCreateReview extends OrderStates {
  final String error ;
  ErrorCreateReview(this.error);
}