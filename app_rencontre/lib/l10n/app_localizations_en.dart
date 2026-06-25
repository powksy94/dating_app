// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nocturne';

  @override
  String get visitorsTitle => 'VISITORS';

  @override
  String get visitorsEmptyState => 'No one has visited your profile yet';

  @override
  String get visitorsPaywallTitle => 'Nocturne Feature';

  @override
  String get visitorsPaywallDescription =>
      'See who\'s visited your profile in the last 30 days by upgrading to Nocturne or Abyssal.';

  @override
  String get visitorsPaywallSheetTitle => 'Profile visitors';

  @override
  String get visitorsPaywallSheetDescription =>
      'Discover all the profiles that have viewed yours.';

  @override
  String get visitorsBtnUpgrade => 'Upgrade to Nocturne';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biometrics unavailable on this device';

  @override
  String get adminAuthLocalizedReason =>
      'Verify your identity to approve the admin login';

  @override
  String get adminAuthErrorBiometricFailed => 'Biometric verification failed';

  @override
  String get adminAuthErrorBiometricGeneric => 'Biometric error';

  @override
  String get adminAuthTitle => 'ADMIN LOGIN';

  @override
  String get adminAuthDescription =>
      'A login request to the admin panel was initiated from a browser.';

  @override
  String get adminAuthBiometricRequired => 'Biometrics required to approve';

  @override
  String get adminAuthBtnApprove => 'Approve';

  @override
  String get adminAuthBtnDeny => 'Deny';

  @override
  String get homeNavDiscover => 'Discover';

  @override
  String get homeNavEvents => 'Events';

  @override
  String get homeNavMessages => 'Messages';

  @override
  String get homeNavProfile => 'Profile';

  @override
  String get homeMyProfileTitle => 'MY PROFILE';

  @override
  String get homeNoProfileTitle => 'Profile not set up';

  @override
  String get homeNoProfileDescription =>
      'Create your profile to appear in the swipe';

  @override
  String get homeBtnCreateProfile => 'Create my profile';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Elegy sent to $username';
  }

  @override
  String get elegieLimitReachedTitle => 'Elegy limit reached';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'You\'ve used your $count elegies for today. Upgrade to Nocturne to send more.',
      one:
          'You\'ve used your elegy for today. Upgrade to Nocturne to send more.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Elegy for $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'A short message before the darkness decides';

  @override
  String get elegieHintMessage => 'Write your message...';

  @override
  String get elegieBtnSend => 'Send the elegy';

  @override
  String get elegieBannerDescription =>
      'Upgrade to Nocturne to send more elegies.';

  @override
  String get elegieBtnUpgrade => 'Upgrade to Nocturne';

  @override
  String get periodWeek => 'week';

  @override
  String get periodMonth => 'month';

  @override
  String get periodYear => 'year';

  @override
  String get subscriptionBtnSwitchToFree => 'Switch to free plan';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Current plan';

  @override
  String get subscriptionBtnChangePeriod => 'Change period';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return 'Choose $planName';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ $planName subscription activated!';
  }

  @override
  String get subscriptionSnackError => 'Error, try again.';

  @override
  String get subscriptionSnackCancelled => 'Subscription cancelled.';

  @override
  String get subscriptionCancelSubscription => 'Cancel subscription';

  @override
  String get subscriptionCancelAnytimeNote => 'Cancel anytime';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return 'Subscribe to $planName';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Cancel';

  @override
  String get subscriptionBtnDialogConfirm => 'Confirm';

  @override
  String get subscriptionDialogCancelBody =>
      'You\'ll lose access to premium features.';

  @override
  String get subscriptionBtnKeep => 'Keep';

  @override
  String get subscriptionBtnConfirmCancel => 'Cancel';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle => 'Join the limitless darkness';

  @override
  String get subscriptionPaywallBtnViewPlans => 'View subscription plans';

  @override
  String get subscriptionPaywallBtnNotNow => 'Not now';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Available from $planName';
  }

  @override
  String get subscriptionPlanOmbre => 'Shadow';

  @override
  String get subscriptionPlanNocturne => 'Nocturne';

  @override
  String get subscriptionPlanAbyssal => 'Abyssal';

  @override
  String get subscriptionBadgePopular => 'POPULAR';

  @override
  String get subscriptionPriceFree => 'Free';

  @override
  String get featureOmbreSwipes => '30 swipes per day';

  @override
  String get featureOmbreElegies => '3 elegies per month';

  @override
  String get featureOmbreEvents => '2 events per month';

  @override
  String get featureOmbrePhotos => '2 photos per profile';

  @override
  String get featureWhoLikedMe => 'See who\'s liked you';

  @override
  String get featureWhoVisited => 'Who\'s visited your profile';

  @override
  String get featureRewind => 'Rewind (undo a swipe)';

  @override
  String get featureBoostGeneric => 'Profile boost';

  @override
  String get featureUnlimitedSwipe => 'Unlimited swipe';

  @override
  String get featureNocturneElegies => '15 elegies per month';

  @override
  String get featureNocturneEvents => '4 events per month';

  @override
  String get featurePhotos6 => '6 photos per profile';

  @override
  String get featureBoostMonthly => '1 boost per month';

  @override
  String get featureUnlimitedElegies => 'Unlimited elegies';

  @override
  String get featureUnlimitedEvents => 'Unlimited events';

  @override
  String get featureBoostWeekly => '1 boost per week';

  @override
  String get socialBtnReport => 'Report';

  @override
  String get socialBtnBlock => 'Block';

  @override
  String socialDialogBlockBody(String username) {
    return 'Block $username? Your match will be deleted.';
  }

  @override
  String get socialBtnCancel => 'Cancel';

  @override
  String get reportCategoryHarassment => 'Harassment';

  @override
  String get reportSubHarassmentTargeted => 'It\'s targeting me personally';

  @override
  String get reportSubHarassmentThreatening => 'Threatening behavior';

  @override
  String get reportSubHarassmentRepeated => 'Repeated unwanted messages';

  @override
  String get reportCategoryFakeProfile => 'Fake profile';

  @override
  String get reportSubFakeStolenPhotos => 'Stolen photos';

  @override
  String get reportSubFakeImpersonation => 'Impersonation';

  @override
  String get reportSubFakeGhost => 'Ghost account';

  @override
  String get reportCategoryNonConsensualSexual =>
      'Non-consensual sexual content';

  @override
  String get reportCategorySpam => 'Spam or scam';

  @override
  String get reportCategoryMinor => 'Minor';

  @override
  String get reportCategoryHateSpeech => 'Hate speech or discrimination';

  @override
  String get reportCategoryOther => 'Other';

  @override
  String socialReportHeaderTitle(String username) {
    return 'Report $username';
  }

  @override
  String get socialReportRootQuestion => 'Why are you reporting this profile?';

  @override
  String get socialReportHint => 'Describe the problem...';

  @override
  String get socialBtnSendReport => 'Send report';

  @override
  String get socialReportSentTitle => 'Report sent';

  @override
  String get socialReportSentBody =>
      'Thank you. Our team will review this report.';

  @override
  String get socialBtnClose => 'Close';

  @override
  String get chatReplyPhoto => 'Photo';

  @override
  String get chatMessageDeleted => 'Message deleted';

  @override
  String get chatStatusRead => 'Read';

  @override
  String get chatStatusSent => 'Sent';

  @override
  String get chatListTitle => 'MESSAGES';

  @override
  String get chatTabChats => 'CHATS';

  @override
  String get chatTabElegiesReceived => 'RECEIVED ELEGIES';

  @override
  String get chatTabElegiesSent => 'SENT ELEGIES';

  @override
  String get chatEmptyMatchesTitle => 'No matches yet...';

  @override
  String get chatEmptyMatchesSub => 'Keep exploring the darkness';

  @override
  String get chatEmptyElegiesReceivedTitle => 'No elegies received';

  @override
  String get chatEmptyElegiesReceivedSub => 'Someone will think of you soon...';

  @override
  String get chatEmptyElegiesSentTitle => 'No elegies sent';

  @override
  String get chatEmptyElegiesSentSub => 'Dare to break the silence...';

  @override
  String get chatNewMatch => 'New match';

  @override
  String get chatElegiePending => 'Pending';

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
    return '${count}d';
  }

  @override
  String get chatTyping => 'typing...';

  @override
  String get chatInputHint => 'Message...';

  @override
  String get chatEmojiHint => 'Choose an emoji...';

  @override
  String get chatBtnDeleteForMe => 'Delete for me';

  @override
  String get chatBtnDeleteForAll => 'Delete for everyone';

  @override
  String get chatLastSeenJustNow => 'seen just now';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'seen $count min ago';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'seen ${count}h ago';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'seen ${count}d ago';
  }
}
