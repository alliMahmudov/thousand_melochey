


import 'package:thousand_melochey/core/imports/imports.dart';


final resetPassProvider = StateNotifierProvider<ResetPassNotifier, ResetPasswordState>(
        (ref) => ResetPassNotifier(resetPassRepository));