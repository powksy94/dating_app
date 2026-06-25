import 'package:flutter/widgets.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ReportCategory {
  final String       label;
  final List<String> subs;
  final bool         hasTextField;

  const ReportCategory(this.label, {
    this.subs         = const [],
    this.hasTextField = false,
  });

  bool get isLeaf   => subs.isEmpty && !hasTextField;
  bool get hasSubs  => subs.isNotEmpty;
}

List<ReportCategory> reportTree(BuildContext context) {
  final l = AppLocalizations.of(context)!;
  return [
    ReportCategory(l.reportCategoryHarassment, subs: [
      l.reportSubHarassmentTargeted,
      l.reportSubHarassmentThreatening,
      l.reportSubHarassmentRepeated,
    ]),
    ReportCategory(l.reportCategoryFakeProfile, subs: [
      l.reportSubFakeStolenPhotos,
      l.reportSubFakeImpersonation,
      l.reportSubFakeGhost,
    ]),
    ReportCategory(l.reportCategoryNonConsensualSexual),
    ReportCategory(l.reportCategorySpam),
    ReportCategory(l.reportCategoryMinor),
    ReportCategory(l.reportCategoryHateSpeech),
    ReportCategory(l.reportCategoryOther, hasTextField: true),
  ];
}
