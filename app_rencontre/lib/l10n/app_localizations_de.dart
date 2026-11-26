// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Nocturne';

  @override
  String get commonGenericError =>
      'Ein Fehler ist aufgetreten, versuch\'s noch einmal.';

  @override
  String get commonLoadErrorSubtitle =>
      'Überprüfe deine Verbindung und versuch\'s noch einmal.';

  @override
  String get commonBtnRetry => 'Erneut versuchen';

  @override
  String get commonOfflineBanner => 'Keine Verbindung';

  @override
  String commonStepProgress(int current, int total) {
    return 'Schritt $current von $total';
  }

  @override
  String get commonAddressLabel => 'Adresse *';

  @override
  String get commonTotal => 'Gesamt';

  @override
  String commonPageNotFound(String name) {
    return 'Seite nicht gefunden: $name';
  }

  @override
  String commonAgoMinutes(int count) {
    return 'vor ${count}Min.';
  }

  @override
  String commonAgoHours(int count) {
    return 'vor ${count}Std.';
  }

  @override
  String commonAgoDays(int count) {
    return 'vor ${count}T.';
  }

  @override
  String get commonUnknownError => 'Unbekannter Fehler';

  @override
  String get commonConnectionRequiredTitle => 'Verbindung erforderlich';

  @override
  String get commonConnectionRequiredBody =>
      'Verbinde dich wieder mit dem Internet, um fortzufahren.';

  @override
  String get subscriptionOfflineBody =>
      'Verbinde dich wieder mit dem Internet, um die Abos zu sehen und zu verwalten.';

  @override
  String get eventLoadErrorTitle =>
      'Veranstaltungen konnten nicht geladen werden';

  @override
  String get profileLoadErrorTitle => 'Dein Profil konnte nicht geladen werden';

  @override
  String get discoveryFiltersTitle => 'SUCHFILTER';

  @override
  String get discoveryFiltersApply => 'Anwenden';

  @override
  String get discoveryFiltersConfirmTitle => 'Diese Filter anwenden?';

  @override
  String get discoveryFiltersConfirmMessage =>
      'Dein Entdecken-Feed wird mit der neuen Distanz und Altersgruppe neu geladen.';

  @override
  String get discoveryFiltersConfirmCancel => 'Abbrechen';

  @override
  String get commonComingSoon => 'Demnächst verfügbar';

  @override
  String get commonBtnOk => 'OK';

  @override
  String get commonBtnRemove => 'Entfernen';

  @override
  String get updateRequiredTitle => 'Update erforderlich';

  @override
  String get updateRequiredBody =>
      'Eine neue Version von Nocturne ist verfügbar. Aktualisiere die App, um fortzufahren.';

  @override
  String get updateRequiredBtn => 'Aktualisieren';

  @override
  String get eventPaidComingSoonBody =>
      'Kostenpflichtige Veranstaltungen kommen demnächst. Bis dahin kannst du kostenlose Veranstaltungen erstellen und ihnen beitreten.';

  @override
  String get visitorsTitle => 'BESUCHER';

  @override
  String get visitorsEmptyState => 'Noch niemand hat dein Profil besucht';

  @override
  String get visitorsPaywallTitle => 'Nocturne-Funktion';

  @override
  String get visitorsPaywallDescription =>
      'Sieh, wer dein Profil in den letzten 30 Tagen besucht hat, indem du zu Nocturne oder Abyssal wechselst.';

  @override
  String get visitorsPaywallSheetTitle => 'Profilbesucher';

  @override
  String get visitorsPaywallSheetDescription =>
      'Entdecke alle Profile, die deins angesehen haben.';

  @override
  String get visitorsBtnUpgrade => 'Zu Nocturne wechseln';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biometrie auf diesem Gerät nicht verfügbar';

  @override
  String get adminAuthLocalizedReason =>
      'Bestätige deine Identität, um die Admin-Anmeldung zu genehmigen';

  @override
  String get adminAuthErrorBiometricFailed =>
      'Biometrische Überprüfung fehlgeschlagen';

  @override
  String get adminAuthErrorBiometricGeneric => 'Biometrischer Fehler';

  @override
  String get adminAuthTitle => 'ADMIN-ANMELDUNG';

  @override
  String get adminAuthDescription =>
      'Eine Anmeldeanfrage an das Admin-Panel wurde von einem Browser aus gestellt.';

  @override
  String get adminAuthBiometricRequired =>
      'Biometrie zur Genehmigung erforderlich';

  @override
  String get adminAuthBtnApprove => 'Genehmigen';

  @override
  String get adminAuthBtnDeny => 'Ablehnen';

  @override
  String get adminLockTitle => 'ZUGANG GESPERRT';

  @override
  String get adminLockSubtitle =>
      'Authentifiziere dich, um auf die Verwaltungstools zuzugreifen.';

  @override
  String get adminLockLocalizedReason =>
      'Bestätige deine Identität, um auf die Verwaltungstools zuzugreifen';

  @override
  String get adminLockBtnRetry => 'Erneut versuchen';

  @override
  String get adminLockBtnCancel => 'Abbrechen';

  @override
  String get eventReviewTitle => 'ZU PRÜFENDE VERANSTALTUNGEN';

  @override
  String get eventReviewEmpty => 'Keine ausstehenden Veranstaltungen';

  @override
  String get eventReviewFree => 'Kostenlos';

  @override
  String get eventReviewBtnApprove => 'Genehmigen';

  @override
  String get eventReviewBtnReject => 'Ablehnen';

  @override
  String get eventReviewApproved => 'Veranstaltung genehmigt';

  @override
  String get eventReviewRejected => 'Veranstaltung abgelehnt';

  @override
  String get photoReviewTitle => 'ZU PRÜFENDE FOTOS';

  @override
  String get photoReviewEmpty => 'Keine ausstehenden Fotos';

  @override
  String get photoReviewBtnApprove => 'Genehmigen';

  @override
  String get photoReviewBtnReject => 'Ablehnen';

  @override
  String get photoReviewApproved => 'Foto genehmigt';

  @override
  String get photoReviewRejected => 'Foto abgelehnt';

  @override
  String get photoReviewDetailTitle => 'Fotodetails';

  @override
  String get photoReviewLabelsLabel => 'Erkannte Elemente';

  @override
  String get photoReviewDateLabel => 'Hinzugefügt am';

  @override
  String profileSnackPhotosPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fotos werden überprüft',
      one: '1 Foto wird überprüft',
    );
    return '$_temp0';
  }

  @override
  String profileSnackPhotosAutoRejected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fotos wurden abgelehnt',
      one: '1 Foto wurde abgelehnt',
    );
    return '$_temp0';
  }

  @override
  String get reportReviewTitle => 'ZU BEARBEITENDE MELDUNGEN';

  @override
  String get reportReviewEmpty => 'Keine ausstehenden Meldungen';

  @override
  String get reportReviewReporterLabel => 'Gemeldet von';

  @override
  String get reportReviewReasonLabel => 'Grund';

  @override
  String get reportReviewMessageLabel => 'Gemeldete Nachricht';

  @override
  String get reportReviewBannedBadge => 'Gesperrt';

  @override
  String get reportReviewTestAccountBadge => 'Testkonto';

  @override
  String get reportReviewBtnDismiss => 'Verwerfen';

  @override
  String get reportReviewBtnBan => 'Sperren';

  @override
  String get reportReviewBtnUnban => 'Entsperren';

  @override
  String get reportReviewDismissed => 'Meldung verworfen';

  @override
  String get reportReviewBanned => 'Nutzer gesperrt';

  @override
  String get reportReviewUnbanned => 'Nutzer entsperrt';

  @override
  String get reportDetailTitle => 'Meldungsdetails';

  @override
  String get reportDetailDateLabel => 'Gemeldet am';

  @override
  String get homeNavDiscover => 'Entdecken';

  @override
  String get homeNavEvents => 'Veranstaltungen';

  @override
  String get homeNavMessages => 'Nachrichten';

  @override
  String get homeNavProfile => 'Profil';

  @override
  String get homeMyProfileTitle => 'MEIN PROFIL';

  @override
  String get onboardingTourSkip => 'Überspringen';

  @override
  String get onboardingTourNext => 'Weiter';

  @override
  String get onboardingTourGetStarted => 'Nocturne betreten';

  @override
  String get onboardingTourTitle1 => 'GLEITE IN DIE DUNKELHEIT';

  @override
  String get onboardingTourSubtitle1 =>
      'Wische durch Profile, die deine Ästhetik und deinen Musikgeschmack teilen.';

  @override
  String get onboardingTourTitle2 => 'VERSAMMELT EUCH IN DER NACHT';

  @override
  String get onboardingTourSubtitle2 =>
      'Finde Konzerte und Treffen in deiner Nähe und triff andere Nachtvögel.';

  @override
  String get onboardingTourTitle3 => 'SENDE EINE ELEGIE';

  @override
  String get onboardingTourSubtitle3 =>
      'Brich das Eis mit einer ehrlichen Elegie statt einem einfachen Hallo.';

  @override
  String get onboardingTourTitle4 => 'FORME DEINEN SCHATTEN';

  @override
  String get onboardingTourSubtitle4 =>
      'Personalisiere deine Fotos, Lieblingsbands und Social-Links.';

  @override
  String get homeExitConfirmTitle => 'Nocturne verlassen?';

  @override
  String get homeExitConfirmMessage =>
      'Du kannst jederzeit zurückkommen, deine Gespräche bleiben erhalten.';

  @override
  String get homeExitConfirmCancel => 'Abbrechen';

  @override
  String get homeExitConfirmQuit => 'Verlassen';

  @override
  String get homeNoProfileTitle => 'Profil nicht eingerichtet';

  @override
  String get homeNoProfileDescription =>
      'Erstelle dein Profil, um im Swipe zu erscheinen';

  @override
  String get homeBtnCreateProfile => 'Mein Profil erstellen';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Elegie an $username gesendet';
  }

  @override
  String get elegieLimitReachedTitle => 'Elegie-Limit erreicht';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Du hast deine $count Elegien des Tages benutzt. Wechsle zu Nocturne, um mehr zu senden.',
      one:
          'Du hast deine Elegie des Tages benutzt. Wechsle zu Nocturne, um mehr zu senden.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Elegie für $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'Eine kurze Nachricht, bevor die Dunkelheit entscheidet';

  @override
  String get elegieHintMessage => 'Schreib deine Nachricht...';

  @override
  String get elegieBtnSend => 'Elegie senden';

  @override
  String get elegieBannerDescription =>
      'Wechsle zu Nocturne, um mehr Elegien zu senden.';

  @override
  String get elegieBtnUpgrade => 'Zu Nocturne wechseln';

  @override
  String get periodWeek => 'Woche';

  @override
  String get periodMonth => 'Monat';

  @override
  String get periodYear => 'Jahr';

  @override
  String get subscriptionRestoreCta => 'Meine Käufe wiederherstellen';

  @override
  String get subscriptionRestoreSuccess => 'Käufe wiederhergestellt!';

  @override
  String get subscriptionRestoreEmpty => 'Keine Käufe zum Wiederherstellen.';

  @override
  String get subscriptionBtnSwitchToFree => 'Zum kostenlosen Plan wechseln';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Aktueller Plan';

  @override
  String get subscriptionBtnChangePeriod => 'Zeitraum ändern';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return '$planName wählen';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ Abo $planName aktiviert!';
  }

  @override
  String get subscriptionSnackError => 'Fehler, versuch\'s noch einmal.';

  @override
  String get subscriptionSnackCancelled => 'Abo gekündigt.';

  @override
  String get subscriptionCancelSubscription => 'Abo kündigen';

  @override
  String get subscriptionCancelAnytimeNote => 'Jederzeit kündbar';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return '$planName abonnieren';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Abbrechen';

  @override
  String get subscriptionBtnDialogConfirm => 'Bestätigen';

  @override
  String get subscriptionDialogCancelBody =>
      'Du verlierst den Zugang zu den Premium-Funktionen.';

  @override
  String get subscriptionBtnKeep => 'Behalten';

  @override
  String get subscriptionBtnConfirmCancel => 'Kündigen';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle =>
      'Tauche grenzenlos in die Dunkelheit ein';

  @override
  String get subscriptionPaywallBtnViewPlans => 'Abos ansehen';

  @override
  String get subscriptionPaywallBtnNotNow => 'Nicht jetzt';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Verfügbar ab $planName';
  }

  @override
  String get subscriptionPlanOmbre => 'Schatten';

  @override
  String get subscriptionPlanNocturne => 'Nocturne';

  @override
  String get subscriptionPlanAbyssal => 'Abyssal';

  @override
  String get subscriptionBadgePopular => 'BELIEBT';

  @override
  String get subscriptionPriceFree => 'Kostenlos';

  @override
  String get subscriptionPriceUnavailable => 'Preis nicht verfügbar';

  @override
  String get subscriptionBtnRetry => 'Erneut versuchen';

  @override
  String get featureOmbreSwipes => '30 Swipes pro Tag';

  @override
  String get featureOmbreElegies => '3 Elegien pro Monat';

  @override
  String get featureOmbreEvents => '2 Veranstaltungen pro Monat';

  @override
  String get featureOmbrePhotos => '2 Fotos pro Profil';

  @override
  String get featureWhoLikedMe => 'Sehen, wer dich gelikt hat';

  @override
  String get featureWhoVisited => 'Wer dein Profil besucht hat';

  @override
  String get featureRewind => 'Rewind (einen Swipe zurücknehmen)';

  @override
  String get featureBoostGeneric => 'Profil-Boost';

  @override
  String get featureUnlimitedSwipe => 'Unbegrenztes Swipen';

  @override
  String get featureNocturneElegies => '15 Elegien pro Monat';

  @override
  String get featureNocturneEvents => '4 Veranstaltungen pro Monat';

  @override
  String get featurePhotos6 => '6 Fotos pro Profil';

  @override
  String get featureBoostMonthly => '1 Boost pro Monat';

  @override
  String get featureUnlimitedElegies => 'Unbegrenzte Elegien';

  @override
  String get featureUnlimitedEvents => 'Unbegrenzte Veranstaltungen';

  @override
  String get featureBoostWeekly => '1 Boost pro Woche';

  @override
  String get socialBtnReport => 'Melden';

  @override
  String get socialBtnBlock => 'Blockieren';

  @override
  String socialDialogBlockBody(String username) {
    return '$username blockieren? Euer Match wird gelöscht.';
  }

  @override
  String get socialBtnCancel => 'Abbrechen';

  @override
  String get reportCategoryHarassment => 'Belästigung';

  @override
  String get reportSubHarassmentTargeted =>
      'Es richtet sich persönlich gegen mich';

  @override
  String get reportSubHarassmentThreatening => 'Bedrohliches Verhalten';

  @override
  String get reportSubHarassmentRepeated =>
      'Wiederholte unerwünschte Nachrichten';

  @override
  String get reportCategoryFakeProfile => 'Falsches Profil';

  @override
  String get reportSubFakeStolenPhotos => 'Gestohlene Fotos';

  @override
  String get reportSubFakeImpersonation => 'Identitätsdiebstahl';

  @override
  String get reportSubFakeGhost => 'Geisterkonto';

  @override
  String get reportCategoryNonConsensualSexual =>
      'Nicht einvernehmlicher sexueller Inhalt';

  @override
  String get reportCategorySpam => 'Spam oder Betrug';

  @override
  String get reportCategoryMinor => 'Minderjährig';

  @override
  String get reportCategoryHateSpeech => 'Hassrede oder Diskriminierung';

  @override
  String get reportCategoryOther => 'Sonstiges';

  @override
  String socialReportHeaderTitle(String username) {
    return '$username melden';
  }

  @override
  String get socialReportRootQuestion => 'Warum meldest du dieses Profil?';

  @override
  String get socialReportRootQuestionMessage =>
      'Warum meldest du diese Nachricht?';

  @override
  String get socialReportHint => 'Beschreibe das Problem...';

  @override
  String get socialBtnSendReport => 'Meldung senden';

  @override
  String get socialReportSentTitle => 'Meldung gesendet';

  @override
  String get socialReportSentBody =>
      'Danke. Unser Team wird diese Meldung prüfen.';

  @override
  String get socialBtnClose => 'Schließen';

  @override
  String get chatReplyPhoto => 'Foto';

  @override
  String get chatMessageDeleted => 'Nachricht gelöscht';

  @override
  String get chatMessageUnderReview => 'Meldung wird überprüft';

  @override
  String get chatStatusRead => 'Gelesen';

  @override
  String get chatStatusSent => 'Gesendet';

  @override
  String get chatListTitle => 'NACHRICHTEN';

  @override
  String get chatTabChats => 'CHATS';

  @override
  String get chatTabElegiesReceived => 'ERHALTENE ELEGIEN';

  @override
  String get chatTabElegiesSent => 'GESENDETE ELEGIEN';

  @override
  String get chatEmptyMatchesTitle => 'Noch kein Match...';

  @override
  String get chatEmptyMatchesSub => 'Erkunde weiter die Dunkelheit';

  @override
  String get giftRevealHint => 'Tippe auf das Siegel, um es zu öffnen';

  @override
  String get giftRevealTitle => 'ZWEI MONATE NOCTURNE';

  @override
  String get giftRevealSubtitle =>
      'Ein Geschenk für die ersten fünfzig Seelen, die es gewagt haben einzutreten 🌙';

  @override
  String get giftRevealClose => 'Weiter';

  @override
  String get giftRevealErrorTitle => 'Das Wachs wollte nicht nachgeben';

  @override
  String get giftRevealErrorSubtitle =>
      'Ein Fehler ist aufgetreten. Versuch\'s noch einmal.';

  @override
  String get giftRevealRetry => 'Erneut versuchen';

  @override
  String get matchTitleBond => 'EINE DUNKLE VERBINDUNG';

  @override
  String get matchTitleBorn => 'IST ENTSTANDEN';

  @override
  String get matchTitleElegie => 'DEINE ELEGIE WURDE ERHÖRT';

  @override
  String get matchSubtitleElegie => 'Die Dunkelheit hat dein Flehen erhört';

  @override
  String matchSubtitleBond(String username) {
    return 'Du & $username seid durch die Dunkelheit verbunden';
  }

  @override
  String get matchBtnMessage => 'NACHRICHT SENDEN';

  @override
  String get matchBtnKeepExploring => 'Weiter erkunden';

  @override
  String get matchAvatarYou => 'Du';

  @override
  String get matchesTileSubtitle => 'Durch die Dunkelheit verbunden';

  @override
  String get matchesBtnMessage => 'Nachricht';

  @override
  String get chatOpenErrorTitle => 'Gespräch konnte nicht geöffnet werden';

  @override
  String get commonBtnCancel => 'Abbrechen';

  @override
  String get commonBtnSend => 'Senden';

  @override
  String get starterCardTitle => 'Um das Eis zu brechen';

  @override
  String get starterConfirmTitle => 'Diese Nachricht senden?';

  @override
  String get starterNoCommonDialog =>
      'Eure Profile haben keinen gemeinsamen Tag, aber ihr habt euch trotzdem gemocht. Hier sind ein paar Ideen, um das Gespräch zu beginnen.';

  @override
  String get starterToggleClassic => 'Klassische Ideen';

  @override
  String get starterToggleShared => 'Basierend auf euren Gemeinsamkeiten';

  @override
  String starterHookShared(String tag) {
    return 'Ihr habt $tag gemeinsam.';
  }

  @override
  String starterHookRare(String tag) {
    return 'Nur wenige Profile haben $tag, und ihr beide gehört dazu.';
  }

  @override
  String starterHookCombo(String tag1, String tag2) {
    return 'Ihr habt $tag1 und $tag2 gemeinsam.';
  }

  @override
  String starterHookBand(String band) {
    return 'Ihr mögt beide $band.';
  }

  @override
  String starterHookEvent(String event) {
    return 'Ihr nehmt beide an der Veranstaltung $event teil.';
  }

  @override
  String get starterHookMood =>
      'Ihr findet euch im gleichen musikalischen Ambiente wieder.';

  @override
  String starterHookOtherBand(String band) {
    return 'Diese Person mag $band.';
  }

  @override
  String starterMsgGenre1(String tag) {
    return 'Ich bin gerade total in der $tag-Phase. Und du, welchen Song hast du in Dauerschleife?';
  }

  @override
  String starterMsgGenre2(String tag) {
    return 'Welche $tag-Band war die erste, die dich richtig gepackt hat?';
  }

  @override
  String starterMsgGenre3(String tag) {
    return 'Wenn ich diese Woche nur ein $tag-Album hören dürfte, welches würdest du empfehlen?';
  }

  @override
  String starterMsgVibe1(String tag) {
    return 'Wenn deine $tag-Playlist der Soundtrack eines Films wäre, welcher wäre es?';
  }

  @override
  String starterMsgVibe2(String tag) {
    return 'Welcher Song versetzt dich sofort in $tag-Stimmung?';
  }

  @override
  String get starterMsgVibeSensitive =>
      'Welcher Song begleitet dich in solchen Momenten?';

  @override
  String starterMsgAesthetic1(String tag) {
    return 'Wo beginnt dein $tag-Universum: bei der Kleidung, im Zimmer, bei den Plattencovern?';
  }

  @override
  String starterMsgIntensity1(String tag) {
    return 'Welcher Song passt am besten zu deiner $tag-Intensität?';
  }

  @override
  String starterMsgEra1(String tag) {
    return 'Welche Platte aus der $tag-Zeit würdest du auf eine einsame Insel mitnehmen?';
  }

  @override
  String get starterMsgFormatConcerts =>
      'Das letzte Konzert, das dich beeindruckt hat, und das schlimmste auch?';

  @override
  String get starterMsgFormatVinyl =>
      'Das Stück aus deiner Sammlung, das dir am meisten bedeutet?';

  @override
  String get starterMsgFormatBandcamp =>
      'Deine letzte Entdeckung auf Bandcamp? Ich suche etwas für meine nächste Hörsession.';

  @override
  String get starterMsgFormatPlaylist =>
      'Eine Playlist, die du in Dauerschleife hörst? Schick mir den Link.';

  @override
  String get starterMsgFormatUnderground =>
      'Ein kleiner Ort oder eine lokale Szene bei dir, die mehr Aufmerksamkeit verdient?';

  @override
  String starterMsgBand1(String band) {
    return 'Dein Lieblingsalbum von $band, und das, das du verteidigst, obwohl es die Meinungen spaltet?';
  }

  @override
  String get starterMsgEvent1 =>
      'Worauf freust du dich am meisten bei dieser Veranstaltung?';

  @override
  String starterMsgOtherBand1(String band) {
    return 'Ich hab gesehen, dass du $band magst. Was ist dein Lieblingsalbum?';
  }

  @override
  String starterMsgCombo1(String tag1, String tag2) {
    return '$tag1 und $tag2, das klingt nach dem perfekten Abend. Mit welchem Song würdest du ihn beginnen?';
  }

  @override
  String get starterFallback1 =>
      'Das letzte Album, das du von Anfang bis Ende gehört hast?';

  @override
  String get starterFallback2 =>
      'Wenn deine aktuelle Playlist ein Film wäre, wie würde er heißen?';

  @override
  String get starterFallback3 =>
      'Eine Band, die du verteidigst, obwohl sie niemand versteht?';

  @override
  String get starterFallback4 =>
      'Ein Song, der dich immer berührt, auch nach hundert Mal hören?';

  @override
  String get starterFallback5 =>
      'Ein Traumkonzert, und deine schlimmste Konzert-Erinnerung?';

  @override
  String get starterFallback6 =>
      'Challenge: Jeder schickt einen Song, den der andere sicher nicht kennt. Deal?';

  @override
  String get chatEmptyElegiesReceivedTitle => 'Keine Elegie erhalten';

  @override
  String get chatEmptyElegiesReceivedSub =>
      'Jemand wird bald an dich denken...';

  @override
  String get chatEmptyElegiesSentTitle => 'Keine Elegie gesendet';

  @override
  String get chatEmptyElegiesSentSub => 'Wage es, die Stille zu brechen...';

  @override
  String get chatMessageBlockedContactInfo =>
      'Zu deiner Sicherheit sind Links und Telefonnummern nicht erlaubt, solange die andere Person noch nicht geantwortet hat.';

  @override
  String get chatNewMatch => 'Neues Match';

  @override
  String get chatElegiePending => 'Ausstehend';

  @override
  String chatTimeMinutesShort(int count) {
    return '${count}m';
  }

  @override
  String chatTimeHoursShort(int count) {
    return '${count}h';
  }

  @override
  String chatTimeDaysShort(int count) {
    return '${count}T';
  }

  @override
  String get chatTyping => 'schreibt...';

  @override
  String get chatInputHint => 'Nachricht...';

  @override
  String get chatEmojiHint => 'Wähle ein Emoji...';

  @override
  String get chatBtnReportMessage => 'Diese Nachricht melden';

  @override
  String get chatBtnDeleteForMe => 'Für mich löschen';

  @override
  String get chatBtnDeleteForAll => 'Für alle löschen';

  @override
  String get chatLastSeenJustNow => 'gerade gesehen';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'vor $count Min. gesehen';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'vor $count Std. gesehen';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'vor $count T. gesehen';
  }

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'Kein Profil in der Nähe...';

  @override
  String get discoveryEmptySubtitle =>
      'Du hast alle verfügbaren Profile durchgesehen.';

  @override
  String get discoveryEmptyResetLikes => 'Deine Likes zurücksetzen';

  @override
  String get discoveryEmptyEditFilters => 'Deine Suchfilter ändern';

  @override
  String get discoveryEmptyWaitMoon => 'Auf einen Neumond warten';

  @override
  String get discoveryEmptyResetSuccess =>
      'Deine Likes wurden zurückgesetzt, die Profile kommen wieder in den Feed.';

  @override
  String get discoveryEmptyWaitMoonMessage =>
      'Neue Profile kommen mit dem Neumond. Komm bald wieder.';

  @override
  String get discoveryLoadErrorTitle => 'Profile konnten nicht geladen werden';

  @override
  String get discoveryLoadErrorSubtitle =>
      'Überprüfe deine Verbindung und versuch\'s noch einmal.';

  @override
  String get discoveryBtnRetry => 'Erneut versuchen';

  @override
  String get discoveryBoostActivated =>
      'Boost aktiviert! Dein Profil wird 30 Minuten lang hervorgehoben.';

  @override
  String get discoveryRewindTitle => 'Rewind nicht verfügbar';

  @override
  String get discoveryRewindBody =>
      'Der Rewind ist ab dem Plan Nocturne verfügbar.';

  @override
  String get discoveryBoostTitle => 'Boost nicht verfügbar';

  @override
  String get discoveryBoostBody =>
      'Der Boost ist ab dem Plan Nocturne (1/Monat) oder Abyssal (1/Woche) verfügbar.';

  @override
  String get discoverySwipeLimitTitle => 'Swipe-Limit erreicht';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'Du hast deine $count Swipes des Tages benutzt. Wechsle zu Nocturne, um ohne Limit zu swipen.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit Swipes heute';
  }

  @override
  String get discoveryBtnElegie => 'Elegie';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'Meine Likes';

  @override
  String get discoveryTabWhoLikedMe => 'Wer mich gelikt hat';

  @override
  String get discoveryEmptyMyLikes => 'Noch keine Likes';

  @override
  String get discoveryEmptyWhoLikedMe => 'Noch niemand hat dein Profil gelikt';

  @override
  String get discoveryPaywallTitle => 'Nocturne-Funktion';

  @override
  String get discoveryPaywallDescription =>
      'Entdecke, wer dein Profil gelikt hat, indem du zu Nocturne oder Abyssal wechselst.';

  @override
  String get discoveryPaywallSheetTitle => 'Wer mich gelikt hat';

  @override
  String get discoveryPaywallSheetDescription =>
      'Entdecke alle Profile, die deins gelikt haben.';

  @override
  String get discoveryBtnUpgrade => 'Zu Nocturne wechseln';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Falsche E-Mail oder falsches Passwort.';

  @override
  String get authLabelEmail => 'E-Mail';

  @override
  String get authLabelPassword => 'Passwort';

  @override
  String get authBtnLogin => 'Anmelden';

  @override
  String get authBtnGoToRegister => 'Noch kein Konto? Konto erstellen';

  @override
  String get authBtnForgotPassword => 'Passwort vergessen?';

  @override
  String get authForgotTitle => 'Passwort vergessen';

  @override
  String get authForgotSubtitle =>
      'Gib deine E-Mail ein, wir senden dir einen 6-stelligen Code.';

  @override
  String get authBtnSendCode => 'Code senden';

  @override
  String get authForgotSentMessage =>
      'Falls ein Konto mit dieser E-Mail existiert, wurde ein Code gesendet.';

  @override
  String get authVerifyCodeTitle => 'Code überprüfen';

  @override
  String get authVerifyCodeSubtitle =>
      'Gib den per E-Mail erhaltenen 6-stelligen Code ein.';

  @override
  String get authBtnVerifyCode => 'Überprüfen';

  @override
  String get authResetTitle => 'Passwort zurücksetzen';

  @override
  String get authResetSubtitle => 'Wähle dein neues Passwort.';

  @override
  String get authLabelResetCode => '6-stelliger Code';

  @override
  String get authLabelNewPassword => 'Neues Passwort';

  @override
  String get authBtnResetPassword => 'Zurücksetzen';

  @override
  String get authResetSuccessMessage =>
      'Passwort zurückgesetzt. Melde dich mit deinem neuen Passwort an.';

  @override
  String get authWelcomeTitle => 'WILLKOMMEN';

  @override
  String get authWelcomeSubtitle => 'in der Dunkelheit';

  @override
  String get authLabelUsername => 'Benutzername';

  @override
  String get authErrorFillAllFields => 'Fülle alle Felder aus.';

  @override
  String get authErrorInvalidEmail => 'Ungültige E-Mail.';

  @override
  String get authErrorPasswordTooShort => 'Passwort: mindestens 12 Zeichen.';

  @override
  String get authErrorPasswordMismatch =>
      'Die Passwörter stimmen nicht überein.';

  @override
  String get authStepCredentialsTitle => 'Willkommen in der \nDunkelheit 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Erstelle dein Konto, um Nocturne beizutreten.';

  @override
  String get authHelperPasswordMin => 'Mindestens 12 Zeichen';

  @override
  String get authLabelConfirmPassword => 'Passwort bestätigen';

  @override
  String get authBtnContinue => 'Weiter';

  @override
  String get authLabelBirthDate => 'Geburtsdatum';

  @override
  String get authErrorUsernameInvalid =>
      'Wähle einen gültigen und verfügbaren Benutzernamen.';

  @override
  String get authStepIdentityTitle => 'Wer bist du?';

  @override
  String get authStepIdentitySubtitle =>
      'Diese Angaben lassen sich später nicht leicht ändern.';

  @override
  String get authLabelGender => 'Geschlecht';

  @override
  String get authLabelPronouns => 'Pronomen';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Erzähl von dir, deiner Musik, deiner Welt...';

  @override
  String get authOther => 'Andere';

  @override
  String get authGenderMale => 'Mann';

  @override
  String get authGenderFemale => 'Frau';

  @override
  String get authGenderNonBinary => 'Nicht-binär';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agender';

  @override
  String get authGenderTransmasculine => 'Transmaskulin';

  @override
  String get authGenderTransfeminine => 'Transfeminin';

  @override
  String get authGenderAll => 'Alle';

  @override
  String get authPronounHeHim => 'Er/ihm';

  @override
  String get authPronounSheHer => 'Sie/ihr';

  @override
  String get authPronounTheyThem => 'Nin/nin';

  @override
  String get authPronounPluralNeutral => 'Sie/ihnen';

  @override
  String get authLabelSpecify => 'Genauer angeben...';

  @override
  String get authErrorSelectPreference => 'Wähle mindestens eine Präferenz.';

  @override
  String get authStepPreferencesTitle => 'Deine Präferenzen';

  @override
  String get authStepPreferencesSubtitle => 'Wen möchtest du kennenlernen?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Altersgruppe: $min - $max Jahre';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Maximale Distanz: $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Gesuchte(s) Geschlecht(er)';

  @override
  String get authBtnCreateAccount => 'Mein Konto erstellen';

  @override
  String get authStepVerifyEmailTitle => 'Bestätige deine E-Mail';

  @override
  String authStepVerifyEmailSubtitle(String email) {
    return 'Gib den an $email gesendeten 6-stelligen Code ein';
  }

  @override
  String get authLabelVerificationCode => '6-stelliger Code';

  @override
  String get authBtnVerifyEmail => 'Überprüfen';

  @override
  String get authBtnResendVerificationCode => 'Code erneut senden';

  @override
  String get authVerifyEmailResentMessage => 'Ein neuer Code wurde gesendet.';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Wähle mindestens ein Genre und eine Ästhetik.';

  @override
  String get authStepTagsTitle => 'Deine musikalische Welt';

  @override
  String get authStepTagsSubtitle =>
      'Diese Tags dienen dazu, dich mit passenden Profilen zu matchen.';

  @override
  String get authSectionMusicGenres => 'Musikgenres';

  @override
  String get authSectionMusicVibes => 'Musikalisches Ambiente';

  @override
  String get authSectionAesthetics => 'Ästhetik';

  @override
  String get authSectionSoundIntensity => 'Klangintensität';

  @override
  String get authSectionMusicEras => 'Epoche';

  @override
  String get authSectionDiscoveryFormats => 'Musikentdeckung';

  @override
  String get authSectionFavoriteBands => 'Lieblingsbands / Künstler (optional)';

  @override
  String get authHintBands => 'Eine Band nach der anderen, z. B.: The Cure';

  @override
  String get bandSearchAttribution => 'Ergebnisse via Spotify';

  @override
  String get authLocationPermissionDenied =>
      'Berechtigung verweigert. Du kannst diesen Schritt überspringen';

  @override
  String get authLocationError =>
      'Standort konnte nicht ermittelt werden. Du kannst diesen Schritt überspringen.';

  @override
  String get authStepLocationTitle => 'Dein Standort';

  @override
  String get authStepLocationSubtitle =>
      'Um dir Profile in deiner Nähe zu zeigen. Du kannst diesen Schritt überspringen.';

  @override
  String get authLocationSaved => 'Standort gespeichert ✓';

  @override
  String get authBtnAllowLocation => 'Standort erlauben';

  @override
  String get authBtnSkipStep => 'Diesen Schritt überspringen';

  @override
  String get authErrorAddPhoto => 'Füge mindestens ein Foto hinzu.';

  @override
  String get authStepPhotosTitle => 'Deine Fotos';

  @override
  String get authStepPhotosSubtitle =>
      'Füge bis zu 6 Fotos hinzu. Das erste wird dein Hauptfoto.';

  @override
  String get authBadgeMain => 'Hauptfoto';

  @override
  String get settingsTitle => 'EINSTELLUNGEN';

  @override
  String get settingsSectionAccount => 'Konto';

  @override
  String get settingsBtnEditProfile => 'Mein Profil bearbeiten';

  @override
  String get settingsBtnChangePassword => 'Passwort ändern';

  @override
  String get settingsBtnLogout => 'Abmelden';

  @override
  String get settingsBtnDeleteAccount => 'Konto löschen';

  @override
  String get settingsLabelMaxDistance => 'Maximale Distanz';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Altersgruppe';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max Jahre';
  }

  @override
  String get settingsSectionNotifications => 'Benachrichtigungen';

  @override
  String get settingsNotifMatches => 'Neue Matches';

  @override
  String get settingsNotifMessages => 'Neue Nachrichten';

  @override
  String get settingsNotifElegies => 'Erhaltene Elegien';

  @override
  String get settingsSectionPrivacy => 'Privatsphäre';

  @override
  String get settingsPrivacyVisible => 'Profil im Swipe sichtbar';

  @override
  String get settingsSectionLanguage => 'Sprache';

  @override
  String get settingsLanguage => 'App-Sprache';

  @override
  String get settingsLanguageDevice => 'Gerätesprache';

  @override
  String get settingsSectionAbout => 'Über';

  @override
  String get settingsVersionLabel => 'Version';

  @override
  String get settingsTermsOfService => 'Nutzungsbedingungen';

  @override
  String get settingsPrivacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get settingsRateApp => 'App bewerten';

  @override
  String get settingsSectionAdmin => 'Verwaltung';

  @override
  String get settingsAdminReports => 'Meldungen';

  @override
  String get settingsAdminPhotos => 'Fotos';

  @override
  String get settingsDeleteAccountWarning =>
      'Diese Aktion ist unwiderruflich.\nGib deinen Benutzernamen ein, um zu bestätigen.';

  @override
  String get settingsBtnCancel => 'Abbrechen';

  @override
  String get settingsBtnDeleteForever => 'Endgültig löschen';

  @override
  String get settingsErrorAllFieldsRequired => 'Alle Felder sind erforderlich';

  @override
  String get settingsErrorPasswordMismatch =>
      'Die Passwörter stimmen nicht überein';

  @override
  String get settingsErrorPasswordMin => 'Mindestens 12 Zeichen';

  @override
  String get settingsLabelCurrentPassword => 'Aktuelles Passwort';

  @override
  String get settingsLabelNewPassword => 'Neues Passwort';

  @override
  String get settingsLabelConfirmNewPassword => 'Neues bestätigen';

  @override
  String get settingsBtnConfirm => 'Bestätigen';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date um $time';
  }

  @override
  String get eventPageTitle => 'VERANSTALTUNGEN';

  @override
  String get eventLabelMaxDistance => 'Maximale Distanz';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Genres';

  @override
  String get eventFilterAllGenres => 'Alle Genres';

  @override
  String get eventFilterMyGenres => 'Meine Genres';

  @override
  String get eventEmptyZone => 'Keine Veranstaltung in deiner Umgebung';

  @override
  String get eventEmptyCategory => 'Keine Veranstaltung in dieser Kategorie';

  @override
  String get eventSubmittedForModeration =>
      'Veranstaltung zur Moderation eingereicht';

  @override
  String get eventLimitTitle => 'Veranstaltungslimit erreicht';

  @override
  String eventLimitBody(int count) {
    return 'Du hast deine $count Veranstaltungsanmeldungen diesen Monat benutzt. Wechsle zu Nocturne für 4/Monat oder Abyssal für unbegrenzt.';
  }

  @override
  String get eventUnregisterConfirmed => 'Abmeldung bestätigt';

  @override
  String get eventRegisterConfirmed => 'Anmeldung bestätigt!';

  @override
  String get eventSectionDescription => 'BESCHREIBUNG';

  @override
  String get eventSectionParticipants => 'TEILNEHMER';

  @override
  String get eventBtnUnregisterLong => 'Angemeldet ✓ — Abmelden';

  @override
  String get eventPriceFree => 'Kostenlos';

  @override
  String get eventBadgeRegistered => 'Angemeldet ✓';

  @override
  String get eventBtnRegister => 'Anmelden';

  @override
  String eventAttendeeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Teilnehmer',
      one: '$count Teilnehmer',
    );
    return '$_temp0';
  }

  @override
  String eventMutualOne(String name) {
    return '$name nimmt teil';
  }

  @override
  String eventMutualTwo(String name1, String name2) {
    return '$name1 und $name2 nehmen teil';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: '$extra weitere Personen',
      one: '1 weitere Person',
    );
    return '$names und $_temp0 nehmen teil';
  }

  @override
  String get eventErrorTitleDescRequired =>
      'Titel und Beschreibung erforderlich';

  @override
  String get eventStepCoverTitle => 'Stelle deine Veranstaltung vor';

  @override
  String get eventStepCoverSubtitle => 'Foto, Titel und Beschreibung';

  @override
  String get eventBtnAddCoverPhoto => 'Titelbild hinzufügen';

  @override
  String get eventLabelTitleRequired => 'Titel *';

  @override
  String get eventLabelDescriptionRequired => 'Beschreibung *';

  @override
  String get eventBtnContinue => 'Weiter';

  @override
  String get eventErrorDateRequired => 'Wähle ein Datum und eine Uhrzeit';

  @override
  String get eventStepDatetimeTitle => 'Wann findet die Veranstaltung statt?';

  @override
  String get eventStepDatetimeSubtitle => 'Datum und Uhrzeit des Beginns';

  @override
  String get eventBtnPickDateTime => 'Datum und Uhrzeit wählen';

  @override
  String get eventErrorAddressRequired => 'Wähle eine Adresse aus der Liste';

  @override
  String get eventStepLocationTitle => 'Wo findet sie statt?';

  @override
  String get eventStepLocationSubtitle => 'Suche die Adresse des Ortes';

  @override
  String get eventStepGenresTitle => 'Musikgenres';

  @override
  String get eventStepGenresSubtitle => 'Wähle die Genres der Veranstaltung';

  @override
  String get eventErrorCapacityInvalid =>
      'Gib eine gültige Kapazität ein (mind. 1)';

  @override
  String get eventErrorCapacityMaxMin =>
      'Das Maximum muss größer als das Minimum sein';

  @override
  String get eventStepCapacityTitle => 'Wie viele Plätze?';

  @override
  String get eventStepCapacitySubtitle =>
      'Maximale Kapazität der Veranstaltung';

  @override
  String get eventToggleExactNumber => 'Genaue Anzahl';

  @override
  String get eventToggleRange => 'Bereich';

  @override
  String get eventLabelExactPlaces => 'Anzahl der Plätze *';

  @override
  String get eventLabelMin => 'Min. *';

  @override
  String get eventLabelMax => 'Max. *';

  @override
  String get eventErrorPriceInvalid => 'Gib einen gültigen Preis ein';

  @override
  String get eventStepPriceTitle => 'Wie hoch ist der Preis?';

  @override
  String get eventStepPriceSubtitle => 'Letzter Schritt vor dem Einreichen';

  @override
  String get eventTogglePaid => 'Kostenpflichtig';

  @override
  String get eventLabelPriceRequired => 'Preis *';

  @override
  String get eventBtnSubmit => 'Veranstaltung einreichen';

  @override
  String get eventFilterAll => 'Alle';

  @override
  String get eventFilterAttending => 'Angemeldet';

  @override
  String get eventFilterMatches => 'Meine Matches';

  @override
  String get eventFilterFavorites => 'Favoriten';

  @override
  String get eventSheetUnregisterTitle => 'Von der Veranstaltung abmelden';

  @override
  String get eventSheetRegisterTitle => 'Anmeldung bestätigen';

  @override
  String get eventBtnConfirmUnregister => 'Abmeldung bestätigen';

  @override
  String get eventBtnConfirmRegister => 'Ich nehme teil!';

  @override
  String get eventPaymentSheetTitle => 'Bestätige dein Ticket';

  @override
  String eventPaymentBtn(String amount) {
    return '$amount € bezahlen';
  }

  @override
  String get eventPaymentError =>
      'Zahlung fehlgeschlagen, versuch\'s noch einmal.';

  @override
  String get eventBtnCancel => 'Abbrechen';

  @override
  String get eventSectionInfo => 'INFOS';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max Plätze';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min Plätze',
      one: '1 Platz',
    );
    return '$_temp0';
  }

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Musikgenres';

  @override
  String get profileSectionVibe => 'Ambiente';

  @override
  String get profileSectionAesthetics => 'Ästhetik & Kultur';

  @override
  String get profileSectionSoundIntensity => 'Klangintensität';

  @override
  String get profileSectionEra => 'Epoche / Szene';

  @override
  String get profileSectionDiscovery => 'Musikentdeckung';

  @override
  String get profileSectionFavoriteBands => 'Lieblingskünstler';

  @override
  String get profileSectionUpcomingEvents => 'Kommende Veranstaltungen';

  @override
  String get profileSectionLinks => 'Links';

  @override
  String get profileSectionPhotos => 'FOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Mit Premium freischalten';

  @override
  String get profileEditTitle => 'MEIN PROFIL BEARBEITEN';

  @override
  String get profileEditTabIdentity => 'Identität';

  @override
  String get profileEditTabPhotos => 'Fotos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Ort';

  @override
  String get profileEditTabPreferences => 'Präferenzen';

  @override
  String get profileMenuTitle => 'MEIN BEREICH';

  @override
  String get profileMenuLikesHistory => 'Like-Verlauf';

  @override
  String get profileMenuVisitors => 'Besucher meines Profils';

  @override
  String get profileMenuMatches => 'Meine Matches';

  @override
  String get profileMenuSettings => 'Einstellungen';

  @override
  String get profileSnackIdentityUpdated => 'Identität aktualisiert!';

  @override
  String get profileLabelUsername => 'BENUTZERNAME';

  @override
  String get profileUsernameImmutableNote =>
      'Der Benutzername kann hier nicht geändert werden.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Erzähl von dir, deiner Musik...';

  @override
  String get profileLabelGender => 'Geschlecht';

  @override
  String get profileLabelPronouns => 'Pronomen';

  @override
  String get profileBtnSave => 'Speichern';

  @override
  String get profileSnackMaxPhotos => 'Maximal 6 Fotos';

  @override
  String get profileSnackPhotosUpdated => 'Fotos aktualisiert!';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 Fotos';
  }

  @override
  String get profileBadgeNew => 'Neu';

  @override
  String get profileBadgePending => 'Ausstehend';

  @override
  String get profileBtnAddPhoto => 'Hinzufügen';

  @override
  String get profileSnackTagsUpdated => 'Musik-Tags aktualisiert!';

  @override
  String get profileSubtitleMusicGenres =>
      'Deine wichtigste musikalische Identität';

  @override
  String get profileSectionMusicVibe => 'Musikalisches Ambiente';

  @override
  String get profileSubtitleMusicVibe => 'Was du beim Hören fühlst';

  @override
  String get profileSubtitleAesthetics => 'Deine Szene, dein Lebensstil';

  @override
  String get profileSubtitleSoundIntensity => 'Die Energie deiner Musik';

  @override
  String get profileSubtitleEra => 'Deine generationsbedingte Nostalgie';

  @override
  String get profileSubtitleDiscovery => 'Deine Hörgewohnheiten';

  @override
  String get profileSectionFavoriteBandsCaps => 'LIEBLINGSKÜNSTLER';

  @override
  String get profileHintBands => 'Eine Band nach der anderen, z. B.: Bauhaus';

  @override
  String get profileSectionSocialLinksCaps => 'LINKS';

  @override
  String get profileHintSocialLink =>
      'Füge einen Link ein: Spotify, Instagram, Bandcamp, Discord...';

  @override
  String get profileLinkNotRecognized =>
      'Link nicht erkannt. Akzeptiert: Spotify, Instagram, Bandcamp, Discord, Last.fm, Tumblr.';

  @override
  String profileLinkWrongPlatform(String platform) {
    return 'Dieser Link entspricht nicht $platform.';
  }

  @override
  String get profileDiscordConnectPrompt =>
      'Dein Discord-Konto verbinden? Du musst dich anmelden und den Zugriff in deinem Browser erlauben.';

  @override
  String profileDiscordConnectedAs(String username) {
    return 'Verbunden als $username.';
  }

  @override
  String get profileDiscordBtnConnect => 'Verbinden';

  @override
  String get profileDiscordConnectFailed =>
      'Discord konnte nicht verbunden werden. Versuch\'s noch einmal.';

  @override
  String get profileBandAlreadyAdded => 'Diese Band ist schon in deiner Liste.';

  @override
  String get profileBandNotAllowed => 'Dieser Bandname ist nicht erlaubt.';

  @override
  String get profileErrorSelectAddress => 'Wähle eine Adresse';

  @override
  String get profileSnackLocationUpdated => 'Standort aktualisiert!';

  @override
  String get profileSectionLocation => 'STANDORT';

  @override
  String get profileLocationDescription =>
      'Wird verwendet, um Profile und Veranstaltungen in deiner Nähe zu finden.';

  @override
  String get profileSnackPreferencesUpdated => 'Präferenzen aktualisiert!';

  @override
  String get profileLabelAgeRange => 'ALTERSGRUPPE';

  @override
  String profileAgeYears(int age) {
    return '$age Jahre';
  }

  @override
  String get profileLabelMaxDistance => 'MAXIMALE DISTANZ';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GESUCHTES GESCHLECHT';
}
