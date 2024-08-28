import 'package:to_do_list/app/core/notifier/default_change_notifier.dart';
import 'package:to_do_list/app/models/filter_enum.dart';

class HomeController extends DefaultChangeNotifier {

  FILTER_ENUM filterSelected = FILTER_ENUM.TODAY;

  set filter(FILTER_ENUM filter) => filterSelected = filter;

}