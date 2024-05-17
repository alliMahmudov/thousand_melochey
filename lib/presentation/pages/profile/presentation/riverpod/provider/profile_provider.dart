import 'package:thousand_melochey/core/imports/imports.dart';


final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
    (ref) => ProfileNotifier(profileRepository));
