import 'dart:convert';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:http/http.dart' as http;
import 'supabase_config.dart';

class CashfreeService {
  static bool get isConfigured =>
      SupabaseConfig.cashfreeAppId.isNotEmpty &&
      SupabaseConfig.cashfreeAppId != 'YOUR_CASHFREE_APP_ID';

  static String get _baseUrl =>
      SupabaseConfig.apiBaseUrl.isNotEmpty
          ? SupabaseConfig.apiBaseUrl
          : 'http://localhost:3000';

  static Future<String?> createOrder({
    required double amount,
    required String customerPhone,
    String customerName = 'Guest',
    String customerEmail = 'guest@example.com',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/create-order'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'order_amount': amount,
          'customer_phone': customerPhone,
          'customer_name': customerName,
          'customer_email': customerEmail,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          return data['data']['payment_session_id'] as String?;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> startPayment({
    required String orderId,
    required String paymentSessionId,
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    final environment = SupabaseConfig.cashfreeEnv == 'production'
        ? CFEnvironment.PRODUCTION
        : CFEnvironment.SANDBOX;

    try {
      final session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();

      final webCheckout = CFWebCheckoutPaymentBuilder()
          .setSession(session)
          .build();

      final service = CFPaymentGatewayService();
      service.setCallback(
        (orderId) {
          onSuccess();
        },
        (CFErrorResponse errorResponse, String orderId) {
          onError();
        },
      );

      await service.doPayment(webCheckout);
    } on CFException {
      onError();
    }
  }
}
