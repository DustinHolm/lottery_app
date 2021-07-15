import 'package:lottery_app/stores/user_store.dart';
import 'package:mockito/mockito.dart';

import 'defaults.dart';

class MockUserStore extends Mock implements UserStore {
  @override
  get user => Defaults.getSeller();

  @override
  get status => Status.AUTHENTICATED;

  @override
  get id => "ID";
}