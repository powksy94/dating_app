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
}
