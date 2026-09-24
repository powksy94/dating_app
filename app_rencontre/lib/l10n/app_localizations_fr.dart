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
  String get commonGenericError => 'Une erreur est survenue, réessaie.';

  @override
  String get commonLoadErrorSubtitle => 'Vérifie ta connexion et réessaie.';

  @override
  String get commonBtnRetry => 'Réessayer';

  @override
  String get commonOfflineBanner => 'Pas de connexion';

  @override
  String commonStepProgress(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get commonAddressLabel => 'Adresse *';

  @override
  String get commonTotal => 'Total';

  @override
  String commonPageNotFound(String name) {
    return 'Page introuvable : $name';
  }

  @override
  String commonAgoMinutes(int count) {
    return 'il y a ${count}min';
  }

  @override
  String commonAgoHours(int count) {
    return 'il y a ${count}h';
  }

  @override
  String commonAgoDays(int count) {
    return 'il y a ${count}j';
  }

  @override
  String get commonUnknownError => 'Erreur inconnue';

  @override
  String get commonConnectionRequiredTitle => 'Connexion requise';

  @override
  String get commonConnectionRequiredBody =>
      'Reconnecte-toi à Internet pour continuer.';

  @override
  String get subscriptionOfflineBody =>
      'Reconnecte-toi à Internet pour voir et gérer les abonnements.';

  @override
  String get eventLoadErrorTitle => 'Impossible de charger les événements';

  @override
  String get profileLoadErrorTitle => 'Impossible de charger ton profil';

  @override
  String get discoveryFiltersTitle => 'FILTRES DE RECHERCHE';

  @override
  String get discoveryFiltersApply => 'Appliquer';

  @override
  String get commonComingSoon => 'Bientôt disponible';

  @override
  String get commonBtnOk => 'OK';

  @override
  String get commonBtnRemove => 'Retirer';

  @override
  String get updateRequiredTitle => 'Mise à jour requise';

  @override
  String get updateRequiredBody =>
      'Une nouvelle version de Nocturne est disponible. Mets l\'application à jour pour continuer.';

  @override
  String get updateRequiredBtn => 'Mettre à jour';

  @override
  String get eventPaidComingSoonBody =>
      'Les événements payants arrivent bientôt. Pour l\'instant, tu peux créer et rejoindre des événements gratuits.';

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
  String get eventReviewTitle => 'ÉVÈNEMENTS À VALIDER';

  @override
  String get eventReviewEmpty => 'Aucun évènement en attente';

  @override
  String get eventReviewFree => 'Gratuit';

  @override
  String get eventReviewBtnApprove => 'Approuver';

  @override
  String get eventReviewBtnReject => 'Rejeter';

  @override
  String get eventReviewApproved => 'Évènement approuvé';

  @override
  String get eventReviewRejected => 'Évènement rejeté';

  @override
  String get reportReviewTitle => 'SIGNALEMENTS À TRAITER';

  @override
  String get reportReviewEmpty => 'Aucun signalement en attente';

  @override
  String get reportReviewReporterLabel => 'Signalé par';

  @override
  String get reportReviewReasonLabel => 'Motif';

  @override
  String get reportReviewBannedBadge => 'Banni';

  @override
  String get reportReviewTestAccountBadge => 'Compte test';

  @override
  String get reportReviewBtnDismiss => 'Classer sans suite';

  @override
  String get reportReviewBtnBan => 'Bannir';

  @override
  String get reportReviewBtnUnban => 'Débannir';

  @override
  String get reportReviewDismissed => 'Signalement classé sans suite';

  @override
  String get reportReviewBanned => 'Utilisateur banni';

  @override
  String get reportReviewUnbanned => 'Utilisateur débanni';

  @override
  String get reportDetailTitle => 'Détail du signalement';

  @override
  String get reportDetailDateLabel => 'Signalé le';

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
  String get homeExitConfirmTitle => 'Quitter Nocturne ?';

  @override
  String get homeExitConfirmMessage =>
      'Tu peux revenir à tout moment, tes conversations resteront intactes.';

  @override
  String get homeExitConfirmCancel => 'Annuler';

  @override
  String get homeExitConfirmQuit => 'Quitter';

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
  String get subscriptionRestoreCta => 'Restaurer mes achats';

  @override
  String get subscriptionRestoreSuccess => 'Achats restaurés !';

  @override
  String get subscriptionRestoreEmpty => 'Aucun achat à restaurer.';

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
  String get subscriptionPriceUnavailable => 'Prix indisponible';

  @override
  String get subscriptionBtnRetry => 'Réessayer';

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
  String get giftRevealHint => 'Touche le sceau pour l\'ouvrir';

  @override
  String get giftRevealTitle => 'DEUX MOIS DE NOCTURNE';

  @override
  String get giftRevealSubtitle =>
      'Un cadeau pour les cinquante premières âmes qui ont osé entrer 🌙';

  @override
  String get giftRevealClose => 'Continuer';

  @override
  String get giftRevealErrorTitle => 'La cire n\'a pas voulu céder';

  @override
  String get giftRevealErrorSubtitle => 'Une erreur est survenue. Réessaie.';

  @override
  String get giftRevealRetry => 'Réessayer';

  @override
  String get matchTitleBond => 'UN LIEN OBSCUR';

  @override
  String get matchTitleBorn => 'EST NÉ';

  @override
  String get matchTitleElegie => 'TON ÉLÉGIE A ÉTÉ ENTENDUE';

  @override
  String get matchSubtitleElegie => 'Les ténèbres ont exaucé ta prière';

  @override
  String matchSubtitleBond(String username) {
    return 'Toi & $username êtes liés par les ténèbres';
  }

  @override
  String get matchBtnMessage => 'ENVOYER UN MESSAGE';

  @override
  String get matchBtnKeepExploring => 'Continuer à explorer';

  @override
  String get matchAvatarYou => 'Toi';

  @override
  String get matchesTileSubtitle => 'Liés par les ténèbres';

  @override
  String get matchesBtnMessage => 'Message';

  @override
  String get chatOpenErrorTitle => 'Impossible d\'ouvrir la conversation';

  @override
  String get commonBtnCancel => 'Annuler';

  @override
  String get commonBtnSend => 'Envoyer';

  @override
  String get starterCardTitle => 'Pour briser la glace';

  @override
  String get starterConfirmTitle => 'Envoyer ce message ?';

  @override
  String get starterNoCommonDialog =>
      'Vos profils n\'ont pas de tag en commun, mais vous vous êtes quand même plu. Voici des idées pour lancer la conversation.';

  @override
  String get starterToggleClassic => 'Idées classiques';

  @override
  String get starterToggleShared => 'Selon vos points communs';

  @override
  String starterHookShared(String tag) {
    return 'Vous avez $tag en commun.';
  }

  @override
  String starterHookRare(String tag) {
    return 'Peu de profils ont $tag, et vous en faites partie tous les deux.';
  }

  @override
  String starterHookCombo(String tag1, String tag2) {
    return 'Vous avez $tag1 et $tag2 en commun.';
  }

  @override
  String starterHookBand(String band) {
    return 'Vous aimez tous les deux $band.';
  }

  @override
  String starterHookEvent(String event) {
    return 'Vous participez tous les deux à l\'événement $event.';
  }

  @override
  String get starterHookMood =>
      'Vous vous retrouvez dans la même ambiance musicale.';

  @override
  String starterHookOtherBand(String band) {
    return 'Cette personne aime $band.';
  }

  @override
  String starterMsgGenre1(String tag) {
    return 'Je suis en pleine phase $tag en ce moment. Et toi, quel morceau tu remets en boucle ?';
  }

  @override
  String starterMsgGenre2(String tag) {
    return 'Quel est le premier groupe de $tag qui t\'a fait plonger dedans ?';
  }

  @override
  String starterMsgGenre3(String tag) {
    return 'Si je ne devais écouter qu\'un album de $tag cette semaine, tu me conseillerais lequel ?';
  }

  @override
  String starterMsgVibe1(String tag) {
    return 'Si ta playlist $tag devenait la bande-son d\'un film, ce serait lequel ?';
  }

  @override
  String starterMsgVibe2(String tag) {
    return 'Quel morceau te met tout de suite dans une ambiance $tag ?';
  }

  @override
  String get starterMsgVibeSensitive =>
      'Quel morceau t\'accompagne dans ces moments-là ?';

  @override
  String starterMsgAesthetic1(String tag) {
    return 'Ton univers $tag, ça commence où : les vêtements, la chambre, les pochettes de disques ?';
  }

  @override
  String starterMsgIntensity1(String tag) {
    return 'Côté intensité $tag, quel morceau te correspond le mieux ?';
  }

  @override
  String starterMsgEra1(String tag) {
    return 'Quel disque de la période $tag tu emporterais sur une île déserte ?';
  }

  @override
  String get starterMsgFormatConcerts =>
      'Le dernier concert qui t\'a marqué, et le pire aussi ?';

  @override
  String get starterMsgFormatVinyl =>
      'La pièce de ta collection qui compte le plus pour toi ?';

  @override
  String get starterMsgFormatBandcamp =>
      'Ta dernière trouvaille sur Bandcamp ? Je cherche de quoi remplir ma prochaine écoute.';

  @override
  String get starterMsgFormatPlaylist =>
      'Une playlist que tu écoutes en boucle ? Envoie-moi le lien.';

  @override
  String get starterMsgFormatUnderground =>
      'Un petit lieu ou une scène locale qui mérite d\'être connue, chez toi ?';

  @override
  String starterMsgBand1(String band) {
    return 'Ton album préféré de $band, et celui que tu défends même s\'il divise ?';
  }

  @override
  String get starterMsgEvent1 =>
      'Qu\'est-ce que tu attends le plus de cet événement ?';

  @override
  String starterMsgOtherBand1(String band) {
    return 'J\'ai vu que tu aimes $band. Quel est ton album préféré ?';
  }

  @override
  String starterMsgCombo1(String tag1, String tag2) {
    return '$tag1 et $tag2, ça sonne comme une soirée parfaite. Tu la commencerais par quel morceau ?';
  }

  @override
  String get starterFallback1 =>
      'Le dernier album que tu as écouté d\'un bout à l\'autre ?';

  @override
  String get starterFallback2 =>
      'Si ta playlist du moment était un film, il s\'appellerait comment ?';

  @override
  String get starterFallback3 =>
      'Un groupe que tu défends alors que personne ne comprend ?';

  @override
  String get starterFallback4 =>
      'Une chanson qui te fait toujours quelque chose, même après cent écoutes ?';

  @override
  String get starterFallback5 =>
      'Un concert de rêve, et ton pire souvenir de concert ?';

  @override
  String get starterFallback6 =>
      'Défi : chacun envoie un morceau que l\'autre ne connaît sûrement pas. Deal ?';

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
  String get chatMessageBlockedContactInfo =>
      'Pour ta sécurité, les liens et numéros de téléphone ne sont pas autorisés tant que l\'autre personne n\'a pas répondu.';

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
  String get discoveryEmptySubtitle =>
      'Tu as fait le tour des profils disponibles pour le moment.';

  @override
  String get discoveryEmptyResetLikes => 'Réinitialiser tes likes';

  @override
  String get discoveryEmptyEditFilters => 'Modifier tes filtres de recherche';

  @override
  String get discoveryEmptyWaitMoon => 'Attendre une nouvelle lune';

  @override
  String get discoveryEmptyResetSuccess =>
      'Tes likes ont été réinitialisés, les profils reviennent dans le feed.';

  @override
  String get discoveryEmptyWaitMoonMessage =>
      'De nouveaux profils arrivent avec la nouvelle lune. Reviens bientôt.';

  @override
  String get discoveryLoadErrorTitle => 'Impossible de charger les profils';

  @override
  String get discoveryLoadErrorSubtitle => 'Vérifie ta connexion et réessaie.';

  @override
  String get discoveryBtnRetry => 'Réessayer';

  @override
  String get discoveryBoostActivated =>
      'Boost activé — ton profil est mis en avant 30 min !';

  @override
  String get discoveryRewindTitle => 'Rewind non disponible';

  @override
  String get discoveryRewindBody =>
      'Le rewind est disponible à partir du plan Nocturne.';

  @override
  String get discoveryBoostTitle => 'Boost non disponible';

  @override
  String get discoveryBoostBody =>
      'Le boost est disponible à partir du plan Nocturne (1/mois) ou Abyssal (1/semaine).';

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
  String get authHintBands => 'Un groupe à la fois, ex. : The Cure';

  @override
  String get bandSearchAttribution => 'Résultats via Spotify';

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
  String get settingsRateApp => 'Noter l\'application';

  @override
  String get settingsSectionAdmin => 'Administration';

  @override
  String get settingsAdminReports => 'Signalements';

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
  String get eventLimitTitle => 'Limite d\'événements atteinte';

  @override
  String eventLimitBody(int count) {
    return 'Tu as utilisé tes $count inscriptions aux événements ce mois-ci. Passe à Nocturne pour 4/mois ou Abyssal pour illimité.';
  }

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
  String get eventPaymentSheetTitle => 'Confirmer ton billet';

  @override
  String eventPaymentBtn(String amount) {
    return 'Payer $amount €';
  }

  @override
  String get eventPaymentError => 'Paiement échoué, réessaie.';

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

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Genres musicaux';

  @override
  String get profileSectionVibe => 'Ambiance';

  @override
  String get profileSectionAesthetics => 'Esthétique & culture';

  @override
  String get profileSectionSoundIntensity => 'Intensité sonore';

  @override
  String get profileSectionEra => 'Époque / scène';

  @override
  String get profileSectionDiscovery => 'Découverte musicale';

  @override
  String get profileSectionFavoriteBands => 'Artistes favoris';

  @override
  String get profileSectionUpcomingEvents => 'Événements à venir';

  @override
  String get profileSectionLinks => 'Liens';

  @override
  String get profileSectionPhotos => 'PHOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Débloquer avec Premium';

  @override
  String get profileEditTitle => 'ÉDITER MON PROFIL';

  @override
  String get profileEditTabIdentity => 'Identité';

  @override
  String get profileEditTabPhotos => 'Photos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Lieu';

  @override
  String get profileEditTabPreferences => 'Préférences';

  @override
  String get profileMenuTitle => 'MON ESPACE';

  @override
  String get profileMenuLikesHistory => 'Historique des likes';

  @override
  String get profileMenuVisitors => 'Visiteurs de mon profil';

  @override
  String get profileMenuMatches => 'Mes matchs';

  @override
  String get profileMenuSettings => 'Paramètres';

  @override
  String get profileSnackIdentityUpdated => 'Identité mise à jour !';

  @override
  String get profileLabelUsername => 'PSEUDO';

  @override
  String get profileUsernameImmutableNote =>
      'Le pseudo ne peut pas être modifié ici.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Parle de toi, de ta musique...';

  @override
  String get profileLabelGender => 'Genre';

  @override
  String get profileLabelPronouns => 'Pronoms';

  @override
  String get profileBtnSave => 'Sauvegarder';

  @override
  String get profileSnackMaxPhotos => 'Maximum 6 photos';

  @override
  String get profileSnackPhotosUpdated => 'Photos mises à jour !';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 photos';
  }

  @override
  String get profileBadgeNew => 'Nouveau';

  @override
  String get profileBtnAddPhoto => 'Ajouter';

  @override
  String get profileSnackTagsUpdated => 'Tags musicaux mis à jour !';

  @override
  String get profileSubtitleMusicGenres => 'Ton identité sonore principale';

  @override
  String get profileSectionMusicVibe => 'Ambiance musicale';

  @override
  String get profileSubtitleMusicVibe => 'Ce que tu ressens en écoutant';

  @override
  String get profileSubtitleAesthetics => 'Ta scène, ton style de vie';

  @override
  String get profileSubtitleSoundIntensity => 'L\'énergie de ta musique';

  @override
  String get profileSubtitleEra => 'Ta nostalgie générationnelle';

  @override
  String get profileSubtitleDiscovery => 'Tes habitudes d\'écoute';

  @override
  String get profileSectionFavoriteBandsCaps => 'ARTISTES FAVORIS';

  @override
  String get profileHintBands => 'Un groupe à la fois, ex. : Bauhaus';

  @override
  String get profileSectionSocialLinksCaps => 'LIENS';

  @override
  String get profileHintSocialLink =>
      'Colle un lien : Spotify, Instagram, Bandcamp, Discord...';

  @override
  String get profileLinkNotRecognized =>
      'Lien non reconnu. Acceptés : Spotify, Instagram, Bandcamp, Discord, Last.fm, Tumblr.';

  @override
  String profileLinkWrongPlatform(String platform) {
    return 'Ce lien ne correspond pas à $platform.';
  }

  @override
  String get profileDiscordConnectPrompt =>
      'Connecter ton compte Discord ? Tu devras te connecter et autoriser l\'accès dans ton navigateur.';

  @override
  String profileDiscordConnectedAs(String username) {
    return 'Connecté en tant que $username.';
  }

  @override
  String get profileDiscordBtnConnect => 'Connecter';

  @override
  String get profileDiscordConnectFailed =>
      'Impossible de connecter Discord. Réessaie.';

  @override
  String get profileBandAlreadyAdded => 'Ce groupe est déjà dans ta liste.';

  @override
  String get profileBandNotAllowed => 'Ce nom de groupe n\'est pas autorisé.';

  @override
  String get profileErrorSelectAddress => 'Sélectionne une adresse';

  @override
  String get profileSnackLocationUpdated => 'Localisation mise à jour !';

  @override
  String get profileSectionLocation => 'LOCALISATION';

  @override
  String get profileLocationDescription =>
      'Utilisée pour trouver des profils et événements proches de toi.';

  @override
  String get profileSnackPreferencesUpdated => 'Préférences mises à jour !';

  @override
  String get profileLabelAgeRange => 'TRANCHE D\'ÂGE';

  @override
  String profileAgeYears(int age) {
    return '$age ans';
  }

  @override
  String get profileLabelMaxDistance => 'DISTANCE MAX';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GENRE RECHERCHÉ';
}
