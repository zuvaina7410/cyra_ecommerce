

import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce_project/home.dart';
import 'package:cyra_ecommerce_project/provider/cart_provider.dart';
import 'package:cyra_ecommerce_project/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {

List<CartProduct> cart;
String amount;
String paymentmethod;
String date;
String name;
String address;
String phone;
PaymentScreen(
  {
    required this.address,
    required this.amount,
    required this.cart,
    required this.date,
    required this.name,
    required this.paymentmethod,
    required this.phone

});

@override
_paymentsection createState()=> _paymentsection();

}


//  const PaymentScreen({super.key});

  //@override
 // State<PaymentScreen> createState() => _PaymentScreenState();
//}


class _paymentsection extends State<PaymentScreen> {

Razorpay? razorpay;
TextEditingController textEditingController=new TextEditingController();

@override
void initState(){
  super.initState();
  _loadUsername();
  razorpay =Razorpay();
  razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  final vm = Provider.of<Cart>(context, listen: false);
 flutterpayment(widget.name,vm.totalPrice.toInt());
log("amount razorpay="+widget.amount);
 //flutterpayment(widget.name,int.parse(widget.amount));
 

}
@override
void dispose(){
  super.dispose();
  razorpay!.clear();
}

String? username;
var payment_amount;


void _loadUsername()async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    username = prefs.getString('username');

  });
  log("isLogged in =razorpay....."+username.toString());


}
orderPlace( 
  List<CartProduct> cart,
  String amount,
  String paymentmethod,
String date,
String name,
String address,
String phone,
) async{

try{

  String jsondata =jsonEncode(cart);
  
  log('jsondata in razorpay...............=${jsondata}');
  

  final vm =Provider.of<Cart>(context,listen:false);
    
     
     int pay = vm.totalPrice.toInt();
     payment_amount = pay;
     
     log("payment amount =");
  
  final response=await http.post(Uri.parse(Webservice.mainurl+"order.php"),
  body:{
    "username":username,
    "amount":amount,
    "paymentmethod":paymentmethod,
    "date":date,
    "quantity":vm.count.toString(),
    "cart":jsondata,
    "name":name,
    "address":address,
    "phone":phone,

  });

  if(response.statusCode==200){

log(response.body);
if(response.body.contains("Success")){
  vm.clearCart();
  
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
duration: Duration(seconds: 3),
behavior: SnackBarBehavior.floating,
padding: EdgeInsets.all(15.0),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
content: Text("YOUR ORDER SUCCESSFULLY COMPLETED",
textAlign: TextAlign.center,
style: TextStyle(fontSize: 18,color: Colors.white,),),
  ));
     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {return HomePage();},
              ),
            );
}
  }
  

}catch(e){
  log(e.toString());
}
}

void flutterpayment(String orderId, int t) {

var options={
  "key":"rzp_test_crtq3nAZ7irzCG",
  "amount":t*100,
  'name':'Zuvaina',
  'currency':'INR',
  'description':'maligai',
  'external':{'wallets':['paytm']},
  'retry':{'enabled':true,'max_count':1},
  'send_sms_hash':true,
  'prefill':{"contact":"9995600989","email":"znsky4@gmail.com"},
};
try{
razorpay!.open(options);
}catch(e){
debugPrint('Error:e');
}
}



void _handlePaymentSuccess(PaymentSuccessResponse response){
  response.orderId;
  sucessmethd(response.paymentId.toString());
}

void _handlePaymentError(PaymentFailureResponse response) {

log("error ="+response.message.toString());

// Fluttertoast.showToast(msg:"ERROR: "+response.code.toString()+"-"+response.message!,toastLength:Toast.LENGTH_SHORT);

}

void _handleExternalWallet(ExternalWalletResponse response) {

log("Walletttttttt == ");

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }

void sucessmethd(String paymentid){
  log("Success =="+paymentid);
  orderPlace(widget.cart,widget.amount.toString(),widget.paymentmethod,widget.date,widget.name,
  widget.address,widget.phone);
}

}