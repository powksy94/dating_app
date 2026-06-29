import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/chip_selector.dart';

List<ChipOption> genderOptions(AppLocalizations l, {bool includeAll = false}) => [
  ChipOption('male', l.authGenderMale),
  ChipOption('female', l.authGenderFemale),
  ChipOption('non_binary', l.authGenderNonBinary),
  ChipOption('genderfluid', l.authGenderGenderfluid),
  ChipOption('agender', l.authGenderAgender),
  ChipOption('transmasculine', l.authGenderTransmasculine),
  ChipOption('transfeminine', l.authGenderTransfeminine),
  includeAll ? ChipOption('all', l.authGenderAll) : ChipOption('other', l.authOther),
];

List<ChipOption> pronounOptions(AppLocalizations l) => [
  ChipOption('he_him', l.authPronounHeHim),
  ChipOption('she_her', l.authPronounSheHer),
  ChipOption('they_them', l.authPronounTheyThem),
  ChipOption('plural_neutral', l.authPronounPluralNeutral),
  ChipOption('other', l.authOther),
];
