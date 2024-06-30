import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffic/utils/models/usermodel.dart';
import 'package:traffic/utils/providers/userprovider.dart';

final authProvider = FutureProvider<UserModel?>((ref) async {
  final auth = ref.read(userProvider.notifier);
  return await auth.loadUser();
});
