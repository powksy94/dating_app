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
