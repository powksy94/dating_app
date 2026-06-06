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

const kReportTree = [
  ReportCategory('Harcèlement', subs: [
    'Ça me cible personnellement',
    'Comportement menaçant',
    'Messages non désirés répétés',
  ]),
  ReportCategory('Faux profil', subs: [
    'Photos volées',
    'Usurpation d\'identité',
    'Compte fantôme',
  ]),
  ReportCategory('Contenu sexuel non consenti'),
  ReportCategory('Spam ou arnaque'),
  ReportCategory('Mineur'),
  ReportCategory('Discours haineux ou discriminatoire'),
  ReportCategory('Autre', hasTextField: true),
];
