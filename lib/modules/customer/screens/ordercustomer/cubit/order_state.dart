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
class ErrorConfirmTicketOrderState extends OrderStates {}



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
class ErrorConfirmProcess extends OrderStates {}
