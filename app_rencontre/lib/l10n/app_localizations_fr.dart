// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Nocturne';

  @override
  String get visitorsTitle => 'VISITEURS';

  @override
  String get visitorsEmptyState => 'Personne n\'a encore visité ton profil';

  @override
  String get visitorsPaywallTitle => 'Fonctionnalité Nocturne';

  @override
  String get visitorsPaywallDescription =>
      'Vois qui a visité ton profil ces 30 derniers jours en passant à Nocturne ou Abyssal.';

  @override
  String get visitorsPaywallSheetTitle => 'Visiteurs de profil';

  @override
  String get visitorsPaywallSheetDescription =>
      'Découvre tous les profils qui ont consulté le tien.';

  @override
  String get visitorsBtnUpgrade => 'Passer à Nocturne';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biométrie non disponible sur cet appareil';

  @override
  String get adminAuthLocalizedReason =>
      'Vérifiez votre identité pour approuver la connexion admin';

  @override
  String get adminAuthErrorBiometricFailed =>
      'Vérification biométrique échouée';

  @override
  String get adminAuthErrorBiometricGeneric => 'Erreur biométrique';

  @override
  String get adminAuthTitle => 'CONNEXION ADMIN';

  @override
  String get adminAuthDescription =>
      'Une demande de connexion au panel admin a été initiée depuis un navigateur.';

  @override
  String get adminAuthBiometricRequired => 'Biométrie requise pour approuver';

  @override
  String get adminAuthBtnApprove => 'Approuver';

  @override
  String get adminAuthBtnDeny => 'Refuser';

  @override
  String get homeNavDiscover => 'Découvrir';

  @override
  String get homeNavEvents => 'Événements';

  @override
  String get homeNavMessages => 'Messages';

  @override
  String get homeNavProfile => 'Profil';

  @override
  String get homeMyProfileTitle => 'MON PROFIL';

  @override
  String get homeNoProfileTitle => 'Profil non configuré';

  @override
  String get homeNoProfileDescription =>
      'Crée ton profil pour apparaître dans le swipe';

  @override
  String get homeBtnCreateProfile => 'Créer mon profil';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Élégie envoyée à $username';
  }

  @override
  String get elegieLimitReachedTitle => 'Limite d\'élégies atteinte';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Tu as utilisé tes $count élégies du jour. Passe à Nocturne pour en envoyer plus.',
      one:
          'Tu as utilisé ton élégie du jour. Passe à Nocturne pour en envoyer plus.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Élégie pour $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'Un court message avant que les ténèbres décident';

  @override
  String get elegieHintMessage => 'Écris ton message...';

  @override
  String get elegieBtnSend => 'Envoyer l\'élégie';

  @override
  String get elegieBannerDescription =>
      'Passe à Nocturne pour envoyer plus d\'élégies.';

  @override
  String get elegieBtnUpgrade => 'Passer à Nocturne';

  @override
  String get periodWeek => 'semaine';

  @override
  String get periodMonth => 'mois';

  @override
  String get periodYear => 'an';

  @override
  String get subscriptionBtnSwitchToFree => 'Passer au plan gratuit';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Plan actuel';

  @override
  String get subscriptionBtnChangePeriod => 'Changer de période';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return 'Choisir $planName';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ Abonnement $planName activé !';
  }

  @override
  String get subscriptionSnackError => 'Erreur, réessaie.';

  @override
  String get subscriptionSnackCancelled => 'Abonnement résilié.';

  @override
  String get subscriptionCancelSubscription => 'Résilier l\'abonnement';

  @override
  String get subscriptionCancelAnytimeNote =>
      'Résiliation possible à tout moment';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return 'Souscrire à $planName';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Annuler';

  @override
  String get subscriptionBtnDialogConfirm => 'Confirmer';

  @override
  String get subscriptionDialogCancelBody =>
      'Tu perdras accès aux fonctionnalités premium.';

  @override
  String get subscriptionBtnKeep => 'Garder';

  @override
  String get subscriptionBtnConfirmCancel => 'Résilier';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle => 'Rejoins les ténèbres sans limites';

  @override
  String get subscriptionPaywallBtnViewPlans => 'Voir les abonnements';

  @override
  String get subscriptionPaywallBtnNotNow => 'Pas maintenant';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Disponible dès $planName';
  }

  @override
  String get subscriptionPlanOmbre => 'Ombre';

  @override
  String get subscriptionPlanNocturne => 'Nocturne';

  @override
  String get subscriptionPlanAbyssal => 'Abyssal';

  @override
  String get subscriptionBadgePopular => 'POPULAIRE';

  @override
  String get subscriptionPriceFree => 'Gratuit';

  @override
  String get featureOmbreSwipes => '30 swipes par jour';

  @override
  String get featureOmbreElegies => '3 élégies par mois';

  @override
  String get featureOmbreEvents => '2 événements par mois';

  @override
  String get featureOmbrePhotos => '2 photos par profil';

  @override
  String get featureWhoLikedMe => 'Voir qui t\'a liké';

  @override
  String get featureWhoVisited => 'Qui a visité ton profil';

  @override
  String get featureRewind => 'Rewind (annuler un swipe)';

  @override
  String get featureBoostGeneric => 'Boost de profil';

  @override
  String get featureUnlimitedSwipe => 'Swipe illimité';

  @override
  String get featureNocturneElegies => '15 élégies par mois';

  @override
  String get featureNocturneEvents => '4 événements par mois';

  @override
  String get featurePhotos6 => '6 photos par profil';

  @override
  String get featureBoostMonthly => '1 boost par mois';

  @override
  String get featureUnlimitedElegies => 'Élégies illimitées';

  @override
  String get featureUnlimitedEvents => 'Événements illimités';

  @override
  String get featureBoostWeekly => '1 boost par semaine';

  @override
  String get socialBtnReport => 'Signaler';

  @override
  String get socialBtnBlock => 'Bloquer';

  @override
  String socialDialogBlockBody(String username) {
    return 'Bloquer $username ? Votre match sera supprimé.';
  }

  @override
  String get socialBtnCancel => 'Annuler';

  @override
  String get reportCategoryHarassment => 'Harcèlement';

  @override
  String get reportSubHarassmentTargeted => 'Ça me cible personnellement';

  @override
  String get reportSubHarassmentThreatening => 'Comportement menaçant';

  @override
  String get reportSubHarassmentRepeated => 'Messages non désirés répétés';

  @override
  String get reportCategoryFakeProfile => 'Faux profil';

  @override
  String get reportSubFakeStolenPhotos => 'Photos volées';

  @override
  String get reportSubFakeImpersonation => 'Usurpation d\'identité';

  @override
  String get reportSubFakeGhost => 'Compte fantôme';

  @override
  String get reportCategoryNonConsensualSexual => 'Contenu sexuel non consenti';

  @override
  String get reportCategorySpam => 'Spam ou arnaque';

  @override
  String get reportCategoryMinor => 'Mineur';

  @override
  String get reportCategoryHateSpeech => 'Discours haineux ou discriminatoire';

  @override
  String get reportCategoryOther => 'Autre';

  @override
  String socialReportHeaderTitle(String username) {
    return 'Signaler $username';
  }

  @override
  String get socialReportRootQuestion => 'Pourquoi signales-tu ce profil ?';

  @override
  String get socialReportHint => 'Décris le problème...';

  @override
  String get socialBtnSendReport => 'Envoyer le signalement';

  @override
  String get socialReportSentTitle => 'Signalement envoyé';

  @override
  String get socialReportSentBody =>
      'Merci. Notre équipe va examiner ce signalement.';

  @override
  String get socialBtnClose => 'Fermer';

  @override
  String get chatReplyPhoto => 'Photo';

  @override
  String get chatMessageDeleted => 'Message supprimé';

  @override
  String get chatStatusRead => 'Lu';

  @override
  String get chatStatusSent => 'Envoyé';

  @override
  String get chatListTitle => 'MESSAGES';

  @override
  String get chatTabChats => 'CHATS';

  @override
  String get chatTabElegiesReceived => 'ÉLÉGIES REÇUES';

  @override
  String get chatTabElegiesSent => 'ÉLÉGIES ENVOYÉES';

  @override
  String get chatEmptyMatchesTitle => 'Aucun match pour l\'instant...';

  @override
  String get chatEmptyMatchesSub => 'Continue d\'explorer les ténèbres';

  @override
  String get chatEmptyElegiesReceivedTitle => 'Aucune élégie reçue';

  @override
  String get chatEmptyElegiesReceivedSub =>
      'Quelqu\'un pensera à toi bientôt...';

  @override
  String get chatEmptyElegiesSentTitle => 'Aucune élégie envoyée';

  @override
  String get chatEmptyElegiesSentSub => 'Ose briser le silence...';

  @override
  String get chatNewMatch => 'Nouveau match';

  @override
  String get chatElegiePending => 'En attente';

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
    return '${count}j';
  }

  @override
  String get chatTyping => 'en train d\'écrire...';

  @override
  String get chatInputHint => 'Message...';

  @override
  String get chatEmojiHint => 'Choisis un emoji...';

  @override
  String get chatBtnDeleteForMe => 'Supprimer pour moi';

  @override
  String get chatBtnDeleteForAll => 'Supprimer pour tout le monde';

  @override
  String get chatLastSeenJustNow => 'vu à l\'instant';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'vu il y a $count min';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'vu il y a $count h';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'vu il y a $count j';
  }

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'Aucun profil dans les parages...';

  @override
  String get discoveryBoostActivated =>
      'Boost activé — ton profil est mis en avant 30 min !';

  @override
  String get discoverySwipeLimitTitle => 'Limite de swipes atteinte';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'Tu as utilisé tes $count swipes du jour. Passe à Nocturne pour swiper sans limite.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit swipes aujourd\'hui';
  }

  @override
  String get discoveryBtnElegie => 'Élégie';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'Mes likes';

  @override
  String get discoveryTabWhoLikedMe => 'Qui m\'a liké';

  @override
  String get discoveryEmptyMyLikes => 'Aucun like pour l\'instant';

  @override
  String get discoveryEmptyWhoLikedMe => 'Personne n\'a encore liké ton profil';

  @override
  String get discoveryPaywallTitle => 'Fonctionnalité Nocturne';

  @override
  String get discoveryPaywallDescription =>
      'Découvre qui a liké ton profil en passant à Nocturne ou Abyssal.';

  @override
  String get discoveryPaywallSheetTitle => 'Qui m\'a liké';

  @override
  String get discoveryPaywallSheetDescription =>
      'Découvre tous les profils qui ont liké le tien.';

  @override
  String get discoveryBtnUpgrade => 'Passer à Nocturne';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Email ou mot de passe incorrect.';

  @override
  String get authLabelEmail => 'Email';

  @override
  String get authLabelPassword => 'Mot de passe';

  @override
  String get authBtnLogin => 'Se connecter';

  @override
  String get authBtnGoToRegister => 'Pas encore de compte ? Créer un compte';

  @override
  String get authWelcomeTitle => 'BIENVENUE';

  @override
  String get authWelcomeSubtitle => 'dans les ténèbres';

  @override
  String get authLabelUsername => 'Pseudo';

  @override
  String get authErrorFillAllFields => 'Remplis tous les champs.';

  @override
  String get authErrorInvalidEmail => 'Email invalide.';

  @override
  String get authErrorPasswordTooShort =>
      'Mot de passe : 12 caractères minimum.';

  @override
  String get authErrorPasswordMismatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get authStepCredentialsTitle => 'Bienvenue dans \nles ténèbres 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Crée ton compte pour rejoindre Nocturne.';

  @override
  String get authHelperPasswordMin => '12 caractères minimum';

  @override
  String get authLabelConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get authBtnContinue => 'Continuer';

  @override
  String get authLabelBirthDate => 'Date de naissance';

  @override
  String get authErrorUsernameInvalid =>
      'Choisis un pseudo valide et disponible.';

  @override
  String get authStepIdentityTitle => 'Qui es-tu ?';

  @override
  String get authStepIdentitySubtitle =>
      'Ces infos ne seront pas modifiables facilement.';

  @override
  String get authLabelGender => 'Genre';

  @override
  String get authLabelPronouns => 'Pronoms';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Parle de toi, de ta musique, de ton univers...';

  @override
  String get authOther => 'Autre';

  @override
  String get authGenderMale => 'Homme';

  @override
  String get authGenderFemale => 'Femme';

  @override
  String get authGenderNonBinary => 'Non-binaire';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agenre';

  @override
  String get authGenderTransmasculine => 'Transmasculin';

  @override
  String get authGenderTransfeminine => 'Transféminin';

  @override
  String get authGenderAll => 'Tous';

  @override
  String get authPronounHeHim => 'Il/lui';

  @override
  String get authPronounSheHer => 'Elle/elle';

  @override
  String get authPronounTheyThem => 'Iel/iel';

  @override
  String get authPronounPluralNeutral => 'Eux/eux';

  @override
  String get authLabelSpecify => 'Précise...';

  @override
  String get authErrorSelectPreference =>
      'Sélectionne au moins une préférence.';

  @override
  String get authStepPreferencesTitle => 'Tes préférences';

  @override
  String get authStepPreferencesSubtitle => 'Qui veux-tu rencontrer ?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Tranche d\'âge : $min - $max ans';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Distance max : $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Genre(s) recherché(s)';

  @override
  String get authBtnCreateAccount => 'Créer mon compte';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Sélectionne au moins un genre et une esthétique.';

  @override
  String get authStepTagsTitle => 'Ton univers musical';

  @override
  String get authStepTagsSubtitle =>
      'Ces tags servent à te matcher avec des profils compatibles.';

  @override
  String get authSectionMusicGenres => 'Genres musicaux';

  @override
  String get authSectionMusicVibes => 'Ambiance musicale';

  @override
  String get authSectionAesthetics => 'Esthétique';

  @override
  String get authSectionSoundIntensity => 'Intensité sonore';

  @override
  String get authSectionMusicEras => 'Époque';

  @override
  String get authSectionDiscoveryFormats => 'Découverte musicale';

  @override
  String get authSectionFavoriteBands =>
      'Groupes / Artistes favoris (optionnel)';

  @override
  String get authHintBands => 'Ex: The Cure, Bauhaus...';

  @override
  String get authLocationPermissionDenied =>
      'Permission refusée. Tu peux passer cette étape';

  @override
  String get authLocationError =>
      'Impossible d\'obtenir la position. Tu peux passer cette étape.';

  @override
  String get authStepLocationTitle => 'Ta localisation';

  @override
  String get authStepLocationSubtitle =>
      'Pour te montrer des profils proches de chez toi. Tu peux passer cette étape.';

  @override
  String get authLocationSaved => 'Localisation enregistrée ✓';

  @override
  String get authBtnAllowLocation => 'Autoriser la localisation';

  @override
  String get authBtnSkipStep => 'Passer cette étape';

  @override
  String get authErrorAddPhoto => 'Ajoute au moins une photo.';

  @override
  String get authStepPhotosTitle => 'Tes photos';

  @override
  String get authStepPhotosSubtitle =>
      'Ajoute jusqu\'à 6 photos. La première sera ta photo principale.';

  @override
  String get authBadgeMain => 'Principale';

  @override
  String get settingsTitle => 'PARAMÈTRES';

  @override
  String get settingsSectionAccount => 'Compte';

  @override
  String get settingsBtnEditProfile => 'Modifier mon profil';

  @override
  String get settingsBtnChangePassword => 'Changer le mot de passe';

  @override
  String get settingsBtnLogout => 'Se déconnecter';

  @override
  String get settingsBtnDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsSectionDiscovery => 'Découverte';

  @override
  String get settingsLabelMaxDistance => 'Distance max';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Tranche d\'âge';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max ans';
  }

  @override
  String get settingsSectionNotifications => 'Notifications';

  @override
  String get settingsNotifMatches => 'Nouveaux matchs';

  @override
  String get settingsNotifMessages => 'Nouveaux messages';

  @override
  String get settingsNotifElegies => 'Élégies reçues';

  @override
  String get settingsSectionPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacyVisible => 'Profil visible dans le swipe';

  @override
  String get settingsSectionAbout => 'À propos';

  @override
  String get settingsVersionLabel => 'Version';

  @override
  String get settingsTermsOfService => 'Conditions d\'utilisation';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsDeleteAccountWarning =>
      'Cette action est irréversible.\nTape ton pseudo pour confirmer.';

  @override
  String get settingsBtnCancel => 'Annuler';

  @override
  String get settingsBtnDeleteForever => 'Supprimer définitivement';

  @override
  String get settingsErrorAllFieldsRequired => 'Tous les champs sont requis';

  @override
  String get settingsErrorPasswordMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get settingsErrorPasswordMin => 'Minimum 12 caractères';

  @override
  String get settingsLabelCurrentPassword => 'Mot de passe actuel';

  @override
  String get settingsLabelNewPassword => 'Nouveau mot de passe';

  @override
  String get settingsLabelConfirmNewPassword => 'Confirmer le nouveau';

  @override
  String get settingsBtnConfirm => 'Confirmer';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date à $time';
  }

  @override
  String get eventPageTitle => 'ÉVÉNEMENTS';

  @override
  String get eventLabelMaxDistance => 'Distance max';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Genres';

  @override
  String get eventFilterAllGenres => 'Tous les genres';

  @override
  String get eventFilterMyGenres => 'Mes genres';

  @override
  String get eventEmptyZone => 'Aucun événement dans ta zone';

  @override
  String get eventEmptyCategory => 'Aucun événement dans cette catégorie';

  @override
  String get eventSubmittedForModeration => 'Événement soumis pour modération';

  @override
  String get eventUnregisterConfirmed => 'Désinscription confirmée';

  @override
  String get eventRegisterConfirmed => 'Inscription confirmée !';

  @override
  String get eventSectionDescription => 'DESCRIPTION';

  @override
  String get eventSectionParticipants => 'PARTICIPANTS';

  @override
  String get eventBtnUnregisterLong => 'Inscrit ✓ — Se désinscrire';

  @override
  String get eventPriceFree => 'Gratuit';

  @override
  String get eventBadgeRegistered => 'Inscrit ✓';

  @override
  String get eventBtnRegister => 'S\'inscrire';

  @override
  String eventAttendeeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count participants',
      one: '$count participant',
    );
    return '$_temp0';
  }

  @override
  String eventMutualOne(String name) {
    return '$name participe';
  }

  @override
  String eventMutualTwo(String name1, String name2) {
    return '$name1 et $name2 participent';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: '$extra autres',
      one: '1 autre',
    );
    return '$names et $_temp0 participent';
  }

  @override
  String get eventErrorTitleDescRequired => 'Titre et description requis';

  @override
  String get eventStepCoverTitle => 'Présente ton événement';

  @override
  String get eventStepCoverSubtitle => 'Photo, titre et description';

  @override
  String get eventBtnAddCoverPhoto => 'Ajouter une photo de couverture';

  @override
  String get eventLabelTitleRequired => 'Titre *';

  @override
  String get eventLabelDescriptionRequired => 'Description *';

  @override
  String get eventBtnContinue => 'Continuer';

  @override
  String get eventErrorDateRequired => 'Choisis une date et une heure';

  @override
  String get eventStepDatetimeTitle => 'Quand a lieu l\'événement ?';

  @override
  String get eventStepDatetimeSubtitle => 'Date et heure de début';

  @override
  String get eventBtnPickDateTime => 'Choisir une date et heure';

  @override
  String get eventErrorAddressRequired =>
      'Sélectionne une adresse dans la liste';

  @override
  String get eventStepLocationTitle => 'Où se déroule-t-il ?';

  @override
  String get eventStepLocationSubtitle => 'Recherche l\'adresse du lieu';

  @override
  String get eventStepGenresTitle => 'Genres musicaux';

  @override
  String get eventStepGenresSubtitle =>
      'Sélectionne les genres de l\'événement';

  @override
  String get eventErrorCapacityInvalid => 'Entre une capacité valide (min 1)';

  @override
  String get eventErrorCapacityMaxMin => 'Le max doit être supérieur au min';

  @override
  String get eventStepCapacityTitle => 'Combien de places ?';

  @override
  String get eventStepCapacitySubtitle => 'Capacité maximale de l\'événement';

  @override
  String get eventToggleExactNumber => 'Nombre exact';

  @override
  String get eventToggleRange => 'Tranche';

  @override
  String get eventLabelExactPlaces => 'Nombre de places *';

  @override
  String get eventLabelMin => 'Min *';

  @override
  String get eventLabelMax => 'Max *';

  @override
  String get eventErrorPriceInvalid => 'Entre un prix valide';

  @override
  String get eventStepPriceTitle => 'Quel est le prix ?';

  @override
  String get eventStepPriceSubtitle => 'Dernière étape avant de soumettre';

  @override
  String get eventTogglePaid => 'Payant';

  @override
  String get eventLabelPriceRequired => 'Prix *';

  @override
  String get eventBtnSubmit => 'Soumettre l\'événement';

  @override
  String get eventFilterAll => 'Tous';

  @override
  String get eventFilterAttending => 'Inscrits';

  @override
  String get eventFilterMatches => 'Mes matchs';

  @override
  String get eventFilterFavorites => 'Favoris';

  @override
  String get eventSheetUnregisterTitle => 'Se désinscrire de l\'événement';

  @override
  String get eventSheetRegisterTitle => 'Confirmer l\'inscription';

  @override
  String get eventBtnConfirmUnregister => 'Confirmer la désinscription';

  @override
  String get eventBtnConfirmRegister => 'Je participe !';

  @override
  String get eventBtnCancel => 'Annuler';

  @override
  String get eventSectionInfo => 'INFOS';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max places';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min places',
      one: '1 place',
    );
    return '$_temp0';
  }
}
