import '../core/app_entry.dart';
import '../core/configs/app_flavor.dart';

void main() => AppEntry().runWithFlavor(flavor: AppFlavor.production);
