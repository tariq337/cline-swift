class unitUrl {
  static String Url = "http://swiftx.pythonanywhere.com/api/v1";
  static String clines = "/clines";

//images
  static String imageUrl(String image) {
    return "http://swiftx.pythonanywhere.com/api/v1/images/$image";
  }

//login
  static String register = "$Url$clines/auth/register";
  static String login = "$Url$clines/auth/login";

//profill
  static String profile = "$Url$clines/profile";

//bills
  static String bills = "$Url$clines/bills";
  static String demand = "$bills/demand";
  static String satisFied = "$bills/satisfied";

//statics
  static String statics = "$Url$clines/statics";

//order
  static String order = "$Url$clines/orders";
  static String firstStap = "$order/step/first";
  static String secondStep = "$order/step/second";
  static String deliveries(String id) => "$Url$clines/deliveries/$id";
  static String agents(String id) => "$Url$clines/agents/$id";
  static String refreshStep(String id) => "$order/step/third/$id";
  static String locationDelivery(String id) => "$order/delivery/location/$id";
  static String orderDelet(String id) => "$Url$clines/orders/$id";
}
