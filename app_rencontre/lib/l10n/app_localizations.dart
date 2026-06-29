import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Nocturne'**
  String get appTitle;

  /// No description provided for @visitorsTitle.
  ///
  /// In en, this message translates to:
  /// **'VISITORS'**
  String get visitorsTitle;

  /// No description provided for @visitorsEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No one has visited your profile yet'**
  String get visitorsEmptyState;

  /// No description provided for @visitorsPaywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Nocturne Feature'**
  String get visitorsPaywallTitle;

  /// No description provided for @visitorsPaywallDescription.
  ///
  /// In en, this message translates to:
  /// **'See who\'s visited your profile in the last 30 days by upgrading to Nocturne or Abyssal.'**
  String get visitorsPaywallDescription;

  /// No description provided for @visitorsPaywallSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile visitors'**
  String get visitorsPaywallSheetTitle;

  /// No description provided for @visitorsPaywallSheetDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover all the profiles that have viewed yours.'**
  String get visitorsPaywallSheetDescription;

  /// No description provided for @visitorsBtnUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Nocturne'**
  String get visitorsBtnUpgrade;

  /// No description provided for @adminAuthErrorBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics unavailable on this device'**
  String get adminAuthErrorBiometricUnavailable;

  /// No description provided for @adminAuthLocalizedReason.
  ///
  /// In en, this message translates to:
  /// **'Verify your identity to approve the admin login'**
  String get adminAuthLocalizedReason;

  /// No description provided for @adminAuthErrorBiometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric verification failed'**
  String get adminAuthErrorBiometricFailed;

  /// No description provided for @adminAuthErrorBiometricGeneric.
  ///
  /// In en, this message translates to:
  /// **'Biometric error'**
  String get adminAuthErrorBiometricGeneric;

  /// No description provided for @adminAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'ADMIN LOGIN'**
  String get adminAuthTitle;

  /// No description provided for @adminAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'A login request to the admin panel was initiated from a browser.'**
  String get adminAuthDescription;

  /// No description provided for @adminAuthBiometricRequired.
  ///
  /// In en, this message translates to:
  /// **'Biometrics required to approve'**
  String get adminAuthBiometricRequired;

  /// No description provided for @adminAuthBtnApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get adminAuthBtnApprove;

  /// No description provided for @adminAuthBtnDeny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get adminAuthBtnDeny;

  /// No description provided for @homeNavDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get homeNavDiscover;

  /// No description provided for @homeNavEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get homeNavEvents;

  /// No description provided for @homeNavMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get homeNavMessages;

  /// No description provided for @homeNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homeNavProfile;

  /// No description provided for @homeMyProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'MY PROFILE'**
  String get homeMyProfileTitle;

  /// No description provided for @homeNoProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile not set up'**
  String get homeNoProfileTitle;

  /// No description provided for @homeNoProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your profile to appear in the swipe'**
  String get homeNoProfileDescription;

  /// No description provided for @homeBtnCreateProfile.
  ///
  /// In en, this message translates to:
  /// **'Create my profile'**
  String get homeBtnCreateProfile;

  /// No description provided for @homePremiumBanner.
  ///
  /// In en, this message translates to:
  /// **'NOCTURNE PREMIUM'**
  String get homePremiumBanner;

  /// No description provided for @elegieSnackSent.
  ///
  /// In en, this message translates to:
  /// **'Elegy sent to {username}'**
  String elegieSnackSent(String username);

  /// No description provided for @elegieLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Elegy limit reached'**
  String get elegieLimitReachedTitle;

  /// No description provided for @elegieLimitReachedBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You\'ve used your elegy for today. Upgrade to Nocturne to send more.} other{You\'ve used your {count} elegies for today. Upgrade to Nocturne to send more.}}'**
  String elegieLimitReachedBody(int count);

  /// No description provided for @elegieSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Elegy for {username}'**
  String elegieSheetTitle(String username);

  /// No description provided for @elegieSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A short message before the darkness decides'**
  String get elegieSheetSubtitle;

  /// No description provided for @elegieHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Write your message...'**
  String get elegieHintMessage;

  /// No description provided for @elegieBtnSend.
  ///
  /// In en, this message translates to:
  /// **'Send the elegy'**
  String get elegieBtnSend;

  /// No description provided for @elegieBannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Nocturne to send more elegies.'**
  String get elegieBannerDescription;

  /// No description provided for @elegieBtnUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Nocturne'**
  String get elegieBtnUpgrade;

  /// No description provided for @periodWeek.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get periodYear;

  /// No description provided for @subscriptionBtnSwitchToFree.
  ///
  /// In en, this message translates to:
  /// **'Switch to free plan'**
  String get subscriptionBtnSwitchToFree;

  /// No description provided for @subscriptionBtnCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'✓ Current plan'**
  String get subscriptionBtnCurrentPlan;

  /// No description provided for @subscriptionBtnChangePeriod.
  ///
  /// In en, this message translates to:
  /// **'Change period'**
  String get subscriptionBtnChangePeriod;

  /// No description provided for @subscriptionBtnChoosePlan.
  ///
  /// In en, this message translates to:
  /// **'Choose {planName}'**
  String subscriptionBtnChoosePlan(String planName);

  /// No description provided for @subscriptionSnackSubscribed.
  ///
  /// In en, this message translates to:
  /// **'✓ {planName} subscription activated!'**
  String subscriptionSnackSubscribed(String planName);

  /// No description provided for @subscriptionSnackError.
  ///
  /// In en, this message translates to:
  /// **'Error, try again.'**
  String get subscriptionSnackError;

  /// No description provided for @subscriptionSnackCancelled.
  ///
  /// In en, this message translates to:
  /// **'Subscription cancelled.'**
  String get subscriptionSnackCancelled;

  /// No description provided for @subscriptionCancelSubscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get subscriptionCancelSubscription;

  /// No description provided for @subscriptionCancelAnytimeNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get subscriptionCancelAnytimeNote;

  /// No description provided for @subscriptionDialogSubscribeTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to {planName}'**
  String subscriptionDialogSubscribeTitle(String planName);

  /// No description provided for @subscriptionBtnDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get subscriptionBtnDialogCancel;

  /// No description provided for @subscriptionBtnDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get subscriptionBtnDialogConfirm;

  /// No description provided for @subscriptionDialogCancelBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll lose access to premium features.'**
  String get subscriptionDialogCancelBody;

  /// No description provided for @subscriptionBtnKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get subscriptionBtnKeep;

  /// No description provided for @subscriptionBtnConfirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get subscriptionBtnConfirmCancel;

  /// No description provided for @subscriptionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'NOCTURNE PREMIUM'**
  String get subscriptionPageTitle;

  /// No description provided for @subscriptionPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join the limitless darkness'**
  String get subscriptionPageSubtitle;

  /// No description provided for @subscriptionPaywallBtnViewPlans.
  ///
  /// In en, this message translates to:
  /// **'View subscription plans'**
  String get subscriptionPaywallBtnViewPlans;

  /// No description provided for @subscriptionPaywallBtnNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get subscriptionPaywallBtnNotNow;

  /// No description provided for @subscriptionPaywallAvailableFrom.
  ///
  /// In en, this message translates to:
  /// **'Available from {planName}'**
  String subscriptionPaywallAvailableFrom(String planName);

  /// No description provided for @subscriptionPlanOmbre.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get subscriptionPlanOmbre;

  /// No description provided for @subscriptionPlanNocturne.
  ///
  /// In en, this message translates to:
  /// **'Nocturne'**
  String get subscriptionPlanNocturne;

  /// No description provided for @subscriptionPlanAbyssal.
  ///
  /// In en, this message translates to:
  /// **'Abyssal'**
  String get subscriptionPlanAbyssal;

  /// No description provided for @subscriptionBadgePopular.
  ///
  /// In en, this message translates to:
  /// **'POPULAR'**
  String get subscriptionBadgePopular;

  /// No description provided for @subscriptionPriceFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get subscriptionPriceFree;

  /// No description provided for @featureOmbreSwipes.
  ///
  /// In en, this message translates to:
  /// **'30 swipes per day'**
  String get featureOmbreSwipes;

  /// No description provided for @featureOmbreElegies.
  ///
  /// In en, this message translates to:
  /// **'3 elegies per month'**
  String get featureOmbreElegies;

  /// No description provided for @featureOmbreEvents.
  ///
  /// In en, this message translates to:
  /// **'2 events per month'**
  String get featureOmbreEvents;

  /// No description provided for @featureOmbrePhotos.
  ///
  /// In en, this message translates to:
  /// **'2 photos per profile'**
  String get featureOmbrePhotos;

  /// No description provided for @featureWhoLikedMe.
  ///
  /// In en, this message translates to:
  /// **'See who\'s liked you'**
  String get featureWhoLikedMe;

  /// No description provided for @featureWhoVisited.
  ///
  /// In en, this message translates to:
  /// **'Who\'s visited your profile'**
  String get featureWhoVisited;

  /// No description provided for @featureRewind.
  ///
  /// In en, this message translates to:
  /// **'Rewind (undo a swipe)'**
  String get featureRewind;

  /// No description provided for @featureBoostGeneric.
  ///
  /// In en, this message translates to:
  /// **'Profile boost'**
  String get featureBoostGeneric;

  /// No description provided for @featureUnlimitedSwipe.
  ///
  /// In en, this message translates to:
  /// **'Unlimited swipe'**
  String get featureUnlimitedSwipe;

  /// No description provided for @featureNocturneElegies.
  ///
  /// In en, this message translates to:
  /// **'15 elegies per month'**
  String get featureNocturneElegies;

  /// No description provided for @featureNocturneEvents.
  ///
  /// In en, this message translates to:
  /// **'4 events per month'**
  String get featureNocturneEvents;

  /// No description provided for @featurePhotos6.
  ///
  /// In en, this message translates to:
  /// **'6 photos per profile'**
  String get featurePhotos6;

  /// No description provided for @featureBoostMonthly.
  ///
  /// In en, this message translates to:
  /// **'1 boost per month'**
  String get featureBoostMonthly;

  /// No description provided for @featureUnlimitedElegies.
  ///
  /// In en, this message translates to:
  /// **'Unlimited elegies'**
  String get featureUnlimitedElegies;

  /// No description provided for @featureUnlimitedEvents.
  ///
  /// In en, this message translates to:
  /// **'Unlimited events'**
  String get featureUnlimitedEvents;

  /// No description provided for @featureBoostWeekly.
  ///
  /// In en, this message translates to:
  /// **'1 boost per week'**
  String get featureBoostWeekly;

  /// No description provided for @socialBtnReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get socialBtnReport;

  /// No description provided for @socialBtnBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get socialBtnBlock;

  /// No description provided for @socialDialogBlockBody.
  ///
  /// In en, this message translates to:
  /// **'Block {username}? Your match will be deleted.'**
  String socialDialogBlockBody(String username);

  /// No description provided for @socialBtnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get socialBtnCancel;

  /// No description provided for @reportCategoryHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get reportCategoryHarassment;

  /// No description provided for @reportSubHarassmentTargeted.
  ///
  /// In en, this message translates to:
  /// **'It\'s targeting me personally'**
  String get reportSubHarassmentTargeted;

  /// No description provided for @reportSubHarassmentThreatening.
  ///
  /// In en, this message translates to:
  /// **'Threatening behavior'**
  String get reportSubHarassmentThreatening;

  /// No description provided for @reportSubHarassmentRepeated.
  ///
  /// In en, this message translates to:
  /// **'Repeated unwanted messages'**
  String get reportSubHarassmentRepeated;

  /// No description provided for @reportCategoryFakeProfile.
  ///
  /// In en, this message translates to:
  /// **'Fake profile'**
  String get reportCategoryFakeProfile;

  /// No description provided for @reportSubFakeStolenPhotos.
  ///
  /// In en, this message translates to:
  /// **'Stolen photos'**
  String get reportSubFakeStolenPhotos;

  /// No description provided for @reportSubFakeImpersonation.
  ///
  /// In en, this message translates to:
  /// **'Impersonation'**
  String get reportSubFakeImpersonation;

  /// No description provided for @reportSubFakeGhost.
  ///
  /// In en, this message translates to:
  /// **'Ghost account'**
  String get reportSubFakeGhost;

  /// No description provided for @reportCategoryNonConsensualSexual.
  ///
  /// In en, this message translates to:
  /// **'Non-consensual sexual content'**
  String get reportCategoryNonConsensualSexual;

  /// No description provided for @reportCategorySpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or scam'**
  String get reportCategorySpam;

  /// No description provided for @reportCategoryMinor.
  ///
  /// In en, this message translates to:
  /// **'Minor'**
  String get reportCategoryMinor;

  /// No description provided for @reportCategoryHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate speech or discrimination'**
  String get reportCategoryHateSpeech;

  /// No description provided for @reportCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reportCategoryOther;

  /// No description provided for @socialReportHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Report {username}'**
  String socialReportHeaderTitle(String username);

  /// No description provided for @socialReportRootQuestion.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this profile?'**
  String get socialReportRootQuestion;

  /// No description provided for @socialReportHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the problem...'**
  String get socialReportHint;

  /// No description provided for @socialBtnSendReport.
  ///
  /// In en, this message translates to:
  /// **'Send report'**
  String get socialBtnSendReport;

  /// No description provided for @socialReportSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Report sent'**
  String get socialReportSentTitle;

  /// No description provided for @socialReportSentBody.
  ///
  /// In en, this message translates to:
  /// **'Thank you. Our team will review this report.'**
  String get socialReportSentBody;

  /// No description provided for @socialBtnClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get socialBtnClose;

  /// No description provided for @chatReplyPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get chatReplyPhoto;

  /// No description provided for @chatMessageDeleted.
  ///
  /// In en, this message translates to:
  /// **'Message deleted'**
  String get chatMessageDeleted;

  /// No description provided for @chatStatusRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get chatStatusRead;

  /// No description provided for @chatStatusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get chatStatusSent;

  /// No description provided for @chatListTitle.
  ///
  /// In en, this message translates to:
  /// **'MESSAGES'**
  String get chatListTitle;

  /// No description provided for @chatTabChats.
  ///
  /// In en, this message translates to:
  /// **'CHATS'**
  String get chatTabChats;

  /// No description provided for @chatTabElegiesReceived.
  ///
  /// In en, this message translates to:
  /// **'RECEIVED ELEGIES'**
  String get chatTabElegiesReceived;

  /// No description provided for @chatTabElegiesSent.
  ///
  /// In en, this message translates to:
  /// **'SENT ELEGIES'**
  String get chatTabElegiesSent;

  /// No description provided for @chatEmptyMatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'No matches yet...'**
  String get chatEmptyMatchesTitle;

  /// No description provided for @chatEmptyMatchesSub.
  ///
  /// In en, this message translates to:
  /// **'Keep exploring the darkness'**
  String get chatEmptyMatchesSub;

  /// No description provided for @chatEmptyElegiesReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'No elegies received'**
  String get chatEmptyElegiesReceivedTitle;

  /// No description provided for @chatEmptyElegiesReceivedSub.
  ///
  /// In en, this message translates to:
  /// **'Someone will think of you soon...'**
  String get chatEmptyElegiesReceivedSub;

  /// No description provided for @chatEmptyElegiesSentTitle.
  ///
  /// In en, this message translates to:
  /// **'No elegies sent'**
  String get chatEmptyElegiesSentTitle;

  /// No description provided for @chatEmptyElegiesSentSub.
  ///
  /// In en, this message translates to:
  /// **'Dare to break the silence...'**
  String get chatEmptyElegiesSentSub;

  /// No description provided for @chatNewMatch.
  ///
  /// In en, this message translates to:
  /// **'New match'**
  String get chatNewMatch;

  /// No description provided for @chatElegiePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get chatElegiePending;

  /// No description provided for @chatTimeMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'{count}m'**
  String chatTimeMinutesShort(int count);

  /// No description provided for @chatTimeHoursShort.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String chatTimeHoursShort(int count);

  /// No description provided for @chatTimeDaysShort.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String chatTimeDaysShort(int count);

  /// No description provided for @chatTyping.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get chatTyping;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Message...'**
  String get chatInputHint;

  /// No description provided for @chatEmojiHint.
  ///
  /// In en, this message translates to:
  /// **'Choose an emoji...'**
  String get chatEmojiHint;

  /// No description provided for @chatBtnDeleteForMe.
  ///
  /// In en, this message translates to:
  /// **'Delete for me'**
  String get chatBtnDeleteForMe;

  /// No description provided for @chatBtnDeleteForAll.
  ///
  /// In en, this message translates to:
  /// **'Delete for everyone'**
  String get chatBtnDeleteForAll;

  /// No description provided for @chatLastSeenJustNow.
  ///
  /// In en, this message translates to:
  /// **'seen just now'**
  String get chatLastSeenJustNow;

  /// No description provided for @chatLastSeenMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'seen {count} min ago'**
  String chatLastSeenMinutesAgo(int count);

  /// No description provided for @chatLastSeenHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'seen {count}h ago'**
  String chatLastSeenHoursAgo(int count);

  /// No description provided for @chatLastSeenDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'seen {count}d ago'**
  String chatLastSeenDaysAgo(int count);

  /// No description provided for @discoverySwipePageTitle.
  ///
  /// In en, this message translates to:
  /// **'NOCTURNE'**
  String get discoverySwipePageTitle;

  /// No description provided for @discoveryEmptyProfiles.
  ///
  /// In en, this message translates to:
  /// **'No profiles around for now...'**
  String get discoveryEmptyProfiles;

  /// No description provided for @discoveryBoostActivated.
  ///
  /// In en, this message translates to:
  /// **'Boost activated — your profile is being featured for 30 min!'**
  String get discoveryBoostActivated;

  /// No description provided for @discoverySwipeLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe limit reached'**
  String get discoverySwipeLimitTitle;

  /// No description provided for @discoverySwipeLimitBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used your {count} swipes for today. Upgrade to Nocturne to swipe without limit.'**
  String discoverySwipeLimitBody(int count);

  /// No description provided for @discoverySwipeCounter.
  ///
  /// In en, this message translates to:
  /// **'{remaining} / {limit} swipes today'**
  String discoverySwipeCounter(int remaining, int limit);

  /// No description provided for @discoveryBtnElegie.
  ///
  /// In en, this message translates to:
  /// **'Elegy'**
  String get discoveryBtnElegie;

  /// No description provided for @discoveryLikesTitle.
  ///
  /// In en, this message translates to:
  /// **'LIKES'**
  String get discoveryLikesTitle;

  /// No description provided for @discoveryTabMyLikes.
  ///
  /// In en, this message translates to:
  /// **'My likes'**
  String get discoveryTabMyLikes;

  /// No description provided for @discoveryTabWhoLikedMe.
  ///
  /// In en, this message translates to:
  /// **'Who liked me'**
  String get discoveryTabWhoLikedMe;

  /// No description provided for @discoveryEmptyMyLikes.
  ///
  /// In en, this message translates to:
  /// **'No likes for now'**
  String get discoveryEmptyMyLikes;

  /// No description provided for @discoveryEmptyWhoLikedMe.
  ///
  /// In en, this message translates to:
  /// **'No one has liked your profile yet'**
  String get discoveryEmptyWhoLikedMe;

  /// No description provided for @discoveryPaywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Nocturne Feature'**
  String get discoveryPaywallTitle;

  /// No description provided for @discoveryPaywallDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover who\'s liked your profile by upgrading to Nocturne or Abyssal.'**
  String get discoveryPaywallDescription;

  /// No description provided for @discoveryPaywallSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Who liked me'**
  String get discoveryPaywallSheetTitle;

  /// No description provided for @discoveryPaywallSheetDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover all the profiles that have liked yours.'**
  String get discoveryPaywallSheetDescription;

  /// No description provided for @discoveryBtnUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Nocturne'**
  String get discoveryBtnUpgrade;

  /// No description provided for @discoveryOverlayLike.
  ///
  /// In en, this message translates to:
  /// **'LIKE'**
  String get discoveryOverlayLike;

  /// No description provided for @discoveryOverlayNope.
  ///
  /// In en, this message translates to:
  /// **'NOPE'**
  String get discoveryOverlayNope;

  /// No description provided for @discoveryBadgeMatch.
  ///
  /// In en, this message translates to:
  /// **'MATCH'**
  String get discoveryBadgeMatch;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'NOCTURNE'**
  String get authLoginTitle;

  /// No description provided for @authLoginError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authLoginError;

  /// No description provided for @authLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authLabelEmail;

  /// No description provided for @authLabelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authLabelPassword;

  /// No description provided for @authBtnLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authBtnLogin;

  /// No description provided for @authBtnGoToRegister.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet? Create one'**
  String get authBtnGoToRegister;

  /// No description provided for @authWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get authWelcomeTitle;

  /// No description provided for @authWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'into the darkness'**
  String get authWelcomeSubtitle;

  /// No description provided for @authLabelUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get authLabelUsername;

  /// No description provided for @authErrorFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Fill in all the fields.'**
  String get authErrorFillAllFields;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password: 12 characters minimum.'**
  String get authErrorPasswordTooShort;

  /// No description provided for @authErrorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match.'**
  String get authErrorPasswordMismatch;

  /// No description provided for @authStepCredentialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome into \nthe darkness 🌙'**
  String get authStepCredentialsTitle;

  /// No description provided for @authStepCredentialsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account to join Nocturne.'**
  String get authStepCredentialsSubtitle;

  /// No description provided for @authHelperPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'12 characters minimum'**
  String get authHelperPasswordMin;

  /// No description provided for @authLabelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authLabelConfirmPassword;

  /// No description provided for @authBtnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authBtnContinue;

  /// No description provided for @authLabelBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get authLabelBirthDate;

  /// No description provided for @authErrorUsernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Choose a valid and available username.'**
  String get authErrorUsernameInvalid;

  /// No description provided for @authStepIdentityTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get authStepIdentityTitle;

  /// No description provided for @authStepIdentitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This info won\'t be easily editable later.'**
  String get authStepIdentitySubtitle;

  /// No description provided for @authLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get authLabelGender;

  /// No description provided for @authLabelPronouns.
  ///
  /// In en, this message translates to:
  /// **'Pronouns'**
  String get authLabelPronouns;

  /// No description provided for @authLabelBio.
  ///
  /// In en, this message translates to:
  /// **'BIO'**
  String get authLabelBio;

  /// No description provided for @authHintBio.
  ///
  /// In en, this message translates to:
  /// **'Tell us about you, your music, your world...'**
  String get authHintBio;

  /// No description provided for @authOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get authOther;

  /// No description provided for @authGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get authGenderMale;

  /// No description provided for @authGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get authGenderFemale;

  /// No description provided for @authGenderNonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get authGenderNonBinary;

  /// No description provided for @authGenderGenderfluid.
  ///
  /// In en, this message translates to:
  /// **'Genderfluid'**
  String get authGenderGenderfluid;

  /// No description provided for @authGenderAgender.
  ///
  /// In en, this message translates to:
  /// **'Agender'**
  String get authGenderAgender;

  /// No description provided for @authGenderTransmasculine.
  ///
  /// In en, this message translates to:
  /// **'Transmasculine'**
  String get authGenderTransmasculine;

  /// No description provided for @authGenderTransfeminine.
  ///
  /// In en, this message translates to:
  /// **'Transfeminine'**
  String get authGenderTransfeminine;

  /// No description provided for @authGenderAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get authGenderAll;

  /// No description provided for @authPronounHeHim.
  ///
  /// In en, this message translates to:
  /// **'He/him'**
  String get authPronounHeHim;

  /// No description provided for @authPronounSheHer.
  ///
  /// In en, this message translates to:
  /// **'She/her'**
  String get authPronounSheHer;

  /// No description provided for @authPronounTheyThem.
  ///
  /// In en, this message translates to:
  /// **'They/them'**
  String get authPronounTheyThem;

  /// No description provided for @authPronounPluralNeutral.
  ///
  /// In en, this message translates to:
  /// **'Them/them'**
  String get authPronounPluralNeutral;

  /// No description provided for @authLabelSpecify.
  ///
  /// In en, this message translates to:
  /// **'Specify...'**
  String get authLabelSpecify;

  /// No description provided for @authErrorSelectPreference.
  ///
  /// In en, this message translates to:
  /// **'Select at least one preference.'**
  String get authErrorSelectPreference;

  /// No description provided for @authStepPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your preferences'**
  String get authStepPreferencesTitle;

  /// No description provided for @authStepPreferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who do you want to meet?'**
  String get authStepPreferencesSubtitle;

  /// No description provided for @authAgeRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age range: {min} - {max} years'**
  String authAgeRangeLabel(int min, int max);

  /// No description provided for @authMaxDistanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Max distance: {km} km'**
  String authMaxDistanceLabel(int km);

  /// No description provided for @authLabelGenderPreferences.
  ///
  /// In en, this message translates to:
  /// **'Gender(s) you\'re looking for'**
  String get authLabelGenderPreferences;

  /// No description provided for @authBtnCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create my account'**
  String get authBtnCreateAccount;

  /// No description provided for @authErrorSelectGenreAesthetic.
  ///
  /// In en, this message translates to:
  /// **'Select at least one genre and one aesthetic.'**
  String get authErrorSelectGenreAesthetic;

  /// No description provided for @authStepTagsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your musical world'**
  String get authStepTagsTitle;

  /// No description provided for @authStepTagsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These tags are used to match you with compatible profiles.'**
  String get authStepTagsSubtitle;

  /// No description provided for @authSectionMusicGenres.
  ///
  /// In en, this message translates to:
  /// **'Music genres'**
  String get authSectionMusicGenres;

  /// No description provided for @authSectionMusicVibes.
  ///
  /// In en, this message translates to:
  /// **'Music vibe'**
  String get authSectionMusicVibes;

  /// No description provided for @authSectionAesthetics.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic'**
  String get authSectionAesthetics;

  /// No description provided for @authSectionSoundIntensity.
  ///
  /// In en, this message translates to:
  /// **'Sound intensity'**
  String get authSectionSoundIntensity;

  /// No description provided for @authSectionMusicEras.
  ///
  /// In en, this message translates to:
  /// **'Era'**
  String get authSectionMusicEras;

  /// No description provided for @authSectionDiscoveryFormats.
  ///
  /// In en, this message translates to:
  /// **'Music discovery'**
  String get authSectionDiscoveryFormats;

  /// No description provided for @authSectionFavoriteBands.
  ///
  /// In en, this message translates to:
  /// **'Favorite bands / artists (optional)'**
  String get authSectionFavoriteBands;

  /// No description provided for @authHintBands.
  ///
  /// In en, this message translates to:
  /// **'E.g: The Cure, Bauhaus...'**
  String get authHintBands;

  /// No description provided for @authLocationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. You can skip this step'**
  String get authLocationPermissionDenied;

  /// No description provided for @authLocationError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get your location. You can skip this step.'**
  String get authLocationError;

  /// No description provided for @authStepLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get authStepLocationTitle;

  /// No description provided for @authStepLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To show you profiles near you. You can skip this step.'**
  String get authStepLocationSubtitle;

  /// No description provided for @authLocationSaved.
  ///
  /// In en, this message translates to:
  /// **'Location saved ✓'**
  String get authLocationSaved;

  /// No description provided for @authBtnAllowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get authBtnAllowLocation;

  /// No description provided for @authBtnSkipStep.
  ///
  /// In en, this message translates to:
  /// **'Skip this step'**
  String get authBtnSkipStep;

  /// No description provided for @authErrorAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add at least one photo.'**
  String get authErrorAddPhoto;

  /// No description provided for @authStepPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Your photos'**
  String get authStepPhotosTitle;

  /// No description provided for @authStepPhotosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add up to 6 photos. The first one will be your main photo.'**
  String get authStepPhotosSubtitle;

  /// No description provided for @authBadgeMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get authBadgeMain;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsSectionAccount;

  /// No description provided for @settingsBtnEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit my profile'**
  String get settingsBtnEditProfile;

  /// No description provided for @settingsBtnChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsBtnChangePassword;

  /// No description provided for @settingsBtnLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsBtnLogout;

  /// No description provided for @settingsBtnDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsBtnDeleteAccount;

  /// No description provided for @settingsSectionDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get settingsSectionDiscovery;

  /// No description provided for @settingsLabelMaxDistance.
  ///
  /// In en, this message translates to:
  /// **'Max distance'**
  String get settingsLabelMaxDistance;

  /// No description provided for @settingsValueKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String settingsValueKm(int km);

  /// No description provided for @settingsLabelAgeRange.
  ///
  /// In en, this message translates to:
  /// **'Age range'**
  String get settingsLabelAgeRange;

  /// No description provided for @settingsValueAgeRange.
  ///
  /// In en, this message translates to:
  /// **'{min} – {max} years'**
  String settingsValueAgeRange(int min, int max);

  /// No description provided for @settingsSectionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsSectionNotifications;

  /// No description provided for @settingsNotifMatches.
  ///
  /// In en, this message translates to:
  /// **'New matches'**
  String get settingsNotifMatches;

  /// No description provided for @settingsNotifMessages.
  ///
  /// In en, this message translates to:
  /// **'New messages'**
  String get settingsNotifMessages;

  /// No description provided for @settingsNotifElegies.
  ///
  /// In en, this message translates to:
  /// **'Elegies received'**
  String get settingsNotifElegies;

  /// No description provided for @settingsSectionPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsSectionPrivacy;

  /// No description provided for @settingsPrivacyVisible.
  ///
  /// In en, this message translates to:
  /// **'Profile visible in swipe'**
  String get settingsPrivacyVisible;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// No description provided for @settingsVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersionLabel;

  /// No description provided for @settingsTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingsTermsOfService;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsDeleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible.\nType your username to confirm.'**
  String get settingsDeleteAccountWarning;

  /// No description provided for @settingsBtnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsBtnCancel;

  /// No description provided for @settingsBtnDeleteForever.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get settingsBtnDeleteForever;

  /// No description provided for @settingsErrorAllFieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'All fields are required'**
  String get settingsErrorAllFieldsRequired;

  /// No description provided for @settingsErrorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get settingsErrorPasswordMismatch;

  /// No description provided for @settingsErrorPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum 12 characters'**
  String get settingsErrorPasswordMin;

  /// No description provided for @settingsLabelCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get settingsLabelCurrentPassword;

  /// No description provided for @settingsLabelNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get settingsLabelNewPassword;

  /// No description provided for @settingsLabelConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get settingsLabelConfirmNewPassword;

  /// No description provided for @settingsBtnConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get settingsBtnConfirm;

  /// No description provided for @eventDateAtTime.
  ///
  /// In en, this message translates to:
  /// **'{date} at {time}'**
  String eventDateAtTime(String date, String time);

  /// No description provided for @eventPageTitle.
  ///
  /// In en, this message translates to:
  /// **'EVENTS'**
  String get eventPageTitle;

  /// No description provided for @eventLabelMaxDistance.
  ///
  /// In en, this message translates to:
  /// **'Max distance'**
  String get eventLabelMaxDistance;

  /// No description provided for @eventValueKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String eventValueKm(int km);

  /// No description provided for @eventLabelGenres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get eventLabelGenres;

  /// No description provided for @eventFilterAllGenres.
  ///
  /// In en, this message translates to:
  /// **'All genres'**
  String get eventFilterAllGenres;

  /// No description provided for @eventFilterMyGenres.
  ///
  /// In en, this message translates to:
  /// **'My genres'**
  String get eventFilterMyGenres;

  /// No description provided for @eventEmptyZone.
  ///
  /// In en, this message translates to:
  /// **'No events in your area'**
  String get eventEmptyZone;

  /// No description provided for @eventEmptyCategory.
  ///
  /// In en, this message translates to:
  /// **'No events in this category'**
  String get eventEmptyCategory;

  /// No description provided for @eventSubmittedForModeration.
  ///
  /// In en, this message translates to:
  /// **'Event submitted for moderation'**
  String get eventSubmittedForModeration;

  /// No description provided for @eventUnregisterConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Unregistration confirmed'**
  String get eventUnregisterConfirmed;

  /// No description provided for @eventRegisterConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Registration confirmed!'**
  String get eventRegisterConfirmed;

  /// No description provided for @eventSectionDescription.
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get eventSectionDescription;

  /// No description provided for @eventSectionParticipants.
  ///
  /// In en, this message translates to:
  /// **'PARTICIPANTS'**
  String get eventSectionParticipants;

  /// No description provided for @eventBtnUnregisterLong.
  ///
  /// In en, this message translates to:
  /// **'Registered ✓ — Unregister'**
  String get eventBtnUnregisterLong;

  /// No description provided for @eventPriceFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get eventPriceFree;

  /// No description provided for @eventBadgeRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered ✓'**
  String get eventBadgeRegistered;

  /// No description provided for @eventBtnRegister.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get eventBtnRegister;

  /// No description provided for @eventAttendeeCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} attendee} other{{count} attendees}}'**
  String eventAttendeeCount(int count);

  /// No description provided for @eventMutualOne.
  ///
  /// In en, this message translates to:
  /// **'{name} is attending'**
  String eventMutualOne(String name);

  /// No description provided for @eventMutualTwo.
  ///
  /// In en, this message translates to:
  /// **'{name1} and {name2} are attending'**
  String eventMutualTwo(String name1, String name2);

  /// No description provided for @eventMutualWithExtra.
  ///
  /// In en, this message translates to:
  /// **'{names} and {extra, plural, =1{1 other} other{{extra} others}} are attending'**
  String eventMutualWithExtra(String names, int extra);

  /// No description provided for @eventErrorTitleDescRequired.
  ///
  /// In en, this message translates to:
  /// **'Title and description required'**
  String get eventErrorTitleDescRequired;

  /// No description provided for @eventStepCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Present your event'**
  String get eventStepCoverTitle;

  /// No description provided for @eventStepCoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Photo, title and description'**
  String get eventStepCoverSubtitle;

  /// No description provided for @eventBtnAddCoverPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a cover photo'**
  String get eventBtnAddCoverPhoto;

  /// No description provided for @eventLabelTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title *'**
  String get eventLabelTitleRequired;

  /// No description provided for @eventLabelDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description *'**
  String get eventLabelDescriptionRequired;

  /// No description provided for @eventBtnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get eventBtnContinue;

  /// No description provided for @eventErrorDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a date and time'**
  String get eventErrorDateRequired;

  /// No description provided for @eventStepDatetimeTitle.
  ///
  /// In en, this message translates to:
  /// **'When is the event?'**
  String get eventStepDatetimeTitle;

  /// No description provided for @eventStepDatetimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start date and time'**
  String get eventStepDatetimeSubtitle;

  /// No description provided for @eventBtnPickDateTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a date and time'**
  String get eventBtnPickDateTime;

  /// No description provided for @eventErrorAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Select an address from the list'**
  String get eventErrorAddressRequired;

  /// No description provided for @eventStepLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Where does it take place?'**
  String get eventStepLocationTitle;

  /// No description provided for @eventStepLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search for the venue\'s address'**
  String get eventStepLocationSubtitle;

  /// No description provided for @eventStepGenresTitle.
  ///
  /// In en, this message translates to:
  /// **'Music genres'**
  String get eventStepGenresTitle;

  /// No description provided for @eventStepGenresSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the event\'s genres'**
  String get eventStepGenresSubtitle;

  /// No description provided for @eventErrorCapacityInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid capacity (min 1)'**
  String get eventErrorCapacityInvalid;

  /// No description provided for @eventErrorCapacityMaxMin.
  ///
  /// In en, this message translates to:
  /// **'The max must be greater than the min'**
  String get eventErrorCapacityMaxMin;

  /// No description provided for @eventStepCapacityTitle.
  ///
  /// In en, this message translates to:
  /// **'How many spots?'**
  String get eventStepCapacityTitle;

  /// No description provided for @eventStepCapacitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Maximum capacity of the event'**
  String get eventStepCapacitySubtitle;

  /// No description provided for @eventToggleExactNumber.
  ///
  /// In en, this message translates to:
  /// **'Exact number'**
  String get eventToggleExactNumber;

  /// No description provided for @eventToggleRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get eventToggleRange;

  /// No description provided for @eventLabelExactPlaces.
  ///
  /// In en, this message translates to:
  /// **'Number of spots *'**
  String get eventLabelExactPlaces;

  /// No description provided for @eventLabelMin.
  ///
  /// In en, this message translates to:
  /// **'Min *'**
  String get eventLabelMin;

  /// No description provided for @eventLabelMax.
  ///
  /// In en, this message translates to:
  /// **'Max *'**
  String get eventLabelMax;

  /// No description provided for @eventErrorPriceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price'**
  String get eventErrorPriceInvalid;

  /// No description provided for @eventStepPriceTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s the price?'**
  String get eventStepPriceTitle;

  /// No description provided for @eventStepPriceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last step before submitting'**
  String get eventStepPriceSubtitle;

  /// No description provided for @eventTogglePaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get eventTogglePaid;

  /// No description provided for @eventLabelPriceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price *'**
  String get eventLabelPriceRequired;

  /// No description provided for @eventBtnSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit the event'**
  String get eventBtnSubmit;

  /// No description provided for @eventFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get eventFilterAll;

  /// No description provided for @eventFilterAttending.
  ///
  /// In en, this message translates to:
  /// **'Attending'**
  String get eventFilterAttending;

  /// No description provided for @eventFilterMatches.
  ///
  /// In en, this message translates to:
  /// **'My matches'**
  String get eventFilterMatches;

  /// No description provided for @eventFilterFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get eventFilterFavorites;

  /// No description provided for @eventSheetUnregisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Unregister from the event'**
  String get eventSheetUnregisterTitle;

  /// No description provided for @eventSheetRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm registration'**
  String get eventSheetRegisterTitle;

  /// No description provided for @eventBtnConfirmUnregister.
  ///
  /// In en, this message translates to:
  /// **'Confirm unregistration'**
  String get eventBtnConfirmUnregister;

  /// No description provided for @eventBtnConfirmRegister.
  ///
  /// In en, this message translates to:
  /// **'I\'m in!'**
  String get eventBtnConfirmRegister;

  /// No description provided for @eventBtnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get eventBtnCancel;

  /// No description provided for @eventSectionInfo.
  ///
  /// In en, this message translates to:
  /// **'INFO'**
  String get eventSectionInfo;

  /// No description provided for @eventCapacityRange.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max} spots'**
  String eventCapacityRange(int min, int max);

  /// No description provided for @eventCapacityMin.
  ///
  /// In en, this message translates to:
  /// **'{min, plural, =1{1 spot} other{{min} spots}}'**
  String eventCapacityMin(int min);

  /// No description provided for @profileSectionBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get profileSectionBio;

  /// No description provided for @profileSectionMusicGenres.
  ///
  /// In en, this message translates to:
  /// **'Music genres'**
  String get profileSectionMusicGenres;

  /// No description provided for @profileSectionVibe.
  ///
  /// In en, this message translates to:
  /// **'Vibe'**
  String get profileSectionVibe;

  /// No description provided for @profileSectionAesthetics.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic & culture'**
  String get profileSectionAesthetics;

  /// No description provided for @profileSectionSoundIntensity.
  ///
  /// In en, this message translates to:
  /// **'Sound intensity'**
  String get profileSectionSoundIntensity;

  /// No description provided for @profileSectionEra.
  ///
  /// In en, this message translates to:
  /// **'Era / scene'**
  String get profileSectionEra;

  /// No description provided for @profileSectionDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Music discovery'**
  String get profileSectionDiscovery;

  /// No description provided for @profileSectionFavoriteBands.
  ///
  /// In en, this message translates to:
  /// **'Favorite artists'**
  String get profileSectionFavoriteBands;

  /// No description provided for @profileSectionUpcomingEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming events'**
  String get profileSectionUpcomingEvents;

  /// No description provided for @profileSectionLinks.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get profileSectionLinks;

  /// No description provided for @profileSectionPhotos.
  ///
  /// In en, this message translates to:
  /// **'PHOTOS'**
  String get profileSectionPhotos;

  /// No description provided for @profileBadgePremium.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get profileBadgePremium;

  /// No description provided for @profileBtnUnlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Premium'**
  String get profileBtnUnlockPremium;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'EDIT MY PROFILE'**
  String get profileEditTitle;

  /// No description provided for @profileEditTabIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get profileEditTabIdentity;

  /// No description provided for @profileEditTabPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get profileEditTabPhotos;

  /// No description provided for @profileEditTabTags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get profileEditTabTags;

  /// No description provided for @profileEditTabLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get profileEditTabLocation;

  /// No description provided for @profileEditTabPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profileEditTabPreferences;

  /// No description provided for @profileMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'MY SPACE'**
  String get profileMenuTitle;

  /// No description provided for @profileMenuLikesHistory.
  ///
  /// In en, this message translates to:
  /// **'Likes history'**
  String get profileMenuLikesHistory;

  /// No description provided for @profileMenuVisitors.
  ///
  /// In en, this message translates to:
  /// **'Profile visitors'**
  String get profileMenuVisitors;

  /// No description provided for @profileMenuMatches.
  ///
  /// In en, this message translates to:
  /// **'My matches'**
  String get profileMenuMatches;

  /// No description provided for @profileMenuSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileMenuSettings;

  /// No description provided for @profileSnackIdentityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Identity updated!'**
  String get profileSnackIdentityUpdated;

  /// No description provided for @profileLabelUsername.
  ///
  /// In en, this message translates to:
  /// **'USERNAME'**
  String get profileLabelUsername;

  /// No description provided for @profileUsernameImmutableNote.
  ///
  /// In en, this message translates to:
  /// **'Username can\'t be edited here.'**
  String get profileUsernameImmutableNote;

  /// No description provided for @profileLabelBio.
  ///
  /// In en, this message translates to:
  /// **'BIO'**
  String get profileLabelBio;

  /// No description provided for @profileHintBio.
  ///
  /// In en, this message translates to:
  /// **'Tell us about you, your music...'**
  String get profileHintBio;

  /// No description provided for @profileLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileLabelGender;

  /// No description provided for @profileLabelPronouns.
  ///
  /// In en, this message translates to:
  /// **'Pronouns'**
  String get profileLabelPronouns;

  /// No description provided for @profileBtnSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileBtnSave;

  /// No description provided for @profileSnackMaxPhotos.
  ///
  /// In en, this message translates to:
  /// **'Maximum 6 photos'**
  String get profileSnackMaxPhotos;

  /// No description provided for @profileSnackPhotosUpdated.
  ///
  /// In en, this message translates to:
  /// **'Photos updated!'**
  String get profileSnackPhotosUpdated;

  /// No description provided for @profilePhotoCount.
  ///
  /// In en, this message translates to:
  /// **'{total} / 6 photos'**
  String profilePhotoCount(int total);

  /// No description provided for @profileBadgeNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get profileBadgeNew;

  /// No description provided for @profileBtnAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get profileBtnAddPhoto;

  /// No description provided for @profileSnackTagsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Music tags updated!'**
  String get profileSnackTagsUpdated;

  /// No description provided for @profileSubtitleMusicGenres.
  ///
  /// In en, this message translates to:
  /// **'Your main sound identity'**
  String get profileSubtitleMusicGenres;

  /// No description provided for @profileSectionMusicVibe.
  ///
  /// In en, this message translates to:
  /// **'Musical vibe'**
  String get profileSectionMusicVibe;

  /// No description provided for @profileSubtitleMusicVibe.
  ///
  /// In en, this message translates to:
  /// **'What you feel while listening'**
  String get profileSubtitleMusicVibe;

  /// No description provided for @profileSubtitleAesthetics.
  ///
  /// In en, this message translates to:
  /// **'Your scene, your lifestyle'**
  String get profileSubtitleAesthetics;

  /// No description provided for @profileSubtitleSoundIntensity.
  ///
  /// In en, this message translates to:
  /// **'The energy of your music'**
  String get profileSubtitleSoundIntensity;

  /// No description provided for @profileSubtitleEra.
  ///
  /// In en, this message translates to:
  /// **'Your generational nostalgia'**
  String get profileSubtitleEra;

  /// No description provided for @profileSubtitleDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Your listening habits'**
  String get profileSubtitleDiscovery;

  /// No description provided for @profileSectionFavoriteBandsCaps.
  ///
  /// In en, this message translates to:
  /// **'FAVORITE ARTISTS'**
  String get profileSectionFavoriteBandsCaps;

  /// No description provided for @profileHintBands.
  ///
  /// In en, this message translates to:
  /// **'Bauhaus, The Cure, Depeche Mode...'**
  String get profileHintBands;

  /// No description provided for @profileErrorSelectAddress.
  ///
  /// In en, this message translates to:
  /// **'Select an address'**
  String get profileErrorSelectAddress;

  /// No description provided for @profileSnackLocationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Location updated!'**
  String get profileSnackLocationUpdated;

  /// No description provided for @profileSectionLocation.
  ///
  /// In en, this message translates to:
  /// **'LOCATION'**
  String get profileSectionLocation;

  /// No description provided for @profileLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to find profiles and events near you.'**
  String get profileLocationDescription;

  /// No description provided for @profileSnackPreferencesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Preferences updated!'**
  String get profileSnackPreferencesUpdated;

  /// No description provided for @profileLabelAgeRange.
  ///
  /// In en, this message translates to:
  /// **'AGE RANGE'**
  String get profileLabelAgeRange;

  /// No description provided for @profileAgeYears.
  ///
  /// In en, this message translates to:
  /// **'{age} years'**
  String profileAgeYears(int age);

  /// No description provided for @profileLabelMaxDistance.
  ///
  /// In en, this message translates to:
  /// **'MAX DISTANCE'**
  String get profileLabelMaxDistance;

  /// No description provided for @profileValueKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String profileValueKm(int km);

  /// No description provided for @profileLabelGenderSought.
  ///
  /// In en, this message translates to:
  /// **'GENDER SOUGHT'**
  String get profileLabelGenderSought;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
