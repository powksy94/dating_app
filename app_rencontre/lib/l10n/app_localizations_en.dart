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
  String get subscriptionRestoreCta => 'Restore purchases';

  @override
  String get subscriptionRestoreSuccess => 'Purchases restored!';

  @override
  String get subscriptionRestoreEmpty => 'No purchases to restore.';

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

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'No profiles around for now...';

  @override
  String get discoveryBoostActivated =>
      'Boost activated — your profile is being featured for 30 min!';

  @override
  String get discoveryRewindTitle => 'Rewind unavailable';

  @override
  String get discoveryRewindBody =>
      'Rewind is available from the Nocturne plan.';

  @override
  String get discoveryBoostTitle => 'Boost unavailable';

  @override
  String get discoveryBoostBody =>
      'Boost is available from the Nocturne plan (1/month) or Abyssal (1/week).';

  @override
  String get discoverySwipeLimitTitle => 'Swipe limit reached';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'You\'ve used your $count swipes for today. Upgrade to Nocturne to swipe without limit.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit swipes today';
  }

  @override
  String get discoveryBtnElegie => 'Elegy';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'My likes';

  @override
  String get discoveryTabWhoLikedMe => 'Who liked me';

  @override
  String get discoveryEmptyMyLikes => 'No likes for now';

  @override
  String get discoveryEmptyWhoLikedMe => 'No one has liked your profile yet';

  @override
  String get discoveryPaywallTitle => 'Nocturne Feature';

  @override
  String get discoveryPaywallDescription =>
      'Discover who\'s liked your profile by upgrading to Nocturne or Abyssal.';

  @override
  String get discoveryPaywallSheetTitle => 'Who liked me';

  @override
  String get discoveryPaywallSheetDescription =>
      'Discover all the profiles that have liked yours.';

  @override
  String get discoveryBtnUpgrade => 'Upgrade to Nocturne';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Incorrect email or password.';

  @override
  String get authLabelEmail => 'Email';

  @override
  String get authLabelPassword => 'Password';

  @override
  String get authBtnLogin => 'Log in';

  @override
  String get authBtnGoToRegister => 'Don\'t have an account yet? Create one';

  @override
  String get authWelcomeTitle => 'WELCOME';

  @override
  String get authWelcomeSubtitle => 'into the darkness';

  @override
  String get authLabelUsername => 'Username';

  @override
  String get authErrorFillAllFields => 'Fill in all the fields.';

  @override
  String get authErrorInvalidEmail => 'Invalid email.';

  @override
  String get authErrorPasswordTooShort => 'Password: 12 characters minimum.';

  @override
  String get authErrorPasswordMismatch => 'Passwords don\'t match.';

  @override
  String get authStepCredentialsTitle => 'Welcome into \nthe darkness 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Create your account to join Nocturne.';

  @override
  String get authHelperPasswordMin => '12 characters minimum';

  @override
  String get authLabelConfirmPassword => 'Confirm password';

  @override
  String get authBtnContinue => 'Continue';

  @override
  String get authLabelBirthDate => 'Date of birth';

  @override
  String get authErrorUsernameInvalid =>
      'Choose a valid and available username.';

  @override
  String get authStepIdentityTitle => 'Who are you?';

  @override
  String get authStepIdentitySubtitle =>
      'This info won\'t be easily editable later.';

  @override
  String get authLabelGender => 'Gender';

  @override
  String get authLabelPronouns => 'Pronouns';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Tell us about you, your music, your world...';

  @override
  String get authOther => 'Other';

  @override
  String get authGenderMale => 'Man';

  @override
  String get authGenderFemale => 'Woman';

  @override
  String get authGenderNonBinary => 'Non-binary';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agender';

  @override
  String get authGenderTransmasculine => 'Transmasculine';

  @override
  String get authGenderTransfeminine => 'Transfeminine';

  @override
  String get authGenderAll => 'All';

  @override
  String get authPronounHeHim => 'He/him';

  @override
  String get authPronounSheHer => 'She/her';

  @override
  String get authPronounTheyThem => 'They/them';

  @override
  String get authPronounPluralNeutral => 'Them/them';

  @override
  String get authLabelSpecify => 'Specify...';

  @override
  String get authErrorSelectPreference => 'Select at least one preference.';

  @override
  String get authStepPreferencesTitle => 'Your preferences';

  @override
  String get authStepPreferencesSubtitle => 'Who do you want to meet?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Age range: $min - $max years';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Max distance: $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Gender(s) you\'re looking for';

  @override
  String get authBtnCreateAccount => 'Create my account';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Select at least one genre and one aesthetic.';

  @override
  String get authStepTagsTitle => 'Your musical world';

  @override
  String get authStepTagsSubtitle =>
      'These tags are used to match you with compatible profiles.';

  @override
  String get authSectionMusicGenres => 'Music genres';

  @override
  String get authSectionMusicVibes => 'Music vibe';

  @override
  String get authSectionAesthetics => 'Aesthetic';

  @override
  String get authSectionSoundIntensity => 'Sound intensity';

  @override
  String get authSectionMusicEras => 'Era';

  @override
  String get authSectionDiscoveryFormats => 'Music discovery';

  @override
  String get authSectionFavoriteBands => 'Favorite bands / artists (optional)';

  @override
  String get authHintBands => 'E.g: The Cure, Bauhaus...';

  @override
  String get authLocationPermissionDenied =>
      'Permission denied. You can skip this step';

  @override
  String get authLocationError =>
      'Couldn\'t get your location. You can skip this step.';

  @override
  String get authStepLocationTitle => 'Your location';

  @override
  String get authStepLocationSubtitle =>
      'To show you profiles near you. You can skip this step.';

  @override
  String get authLocationSaved => 'Location saved ✓';

  @override
  String get authBtnAllowLocation => 'Allow location';

  @override
  String get authBtnSkipStep => 'Skip this step';

  @override
  String get authErrorAddPhoto => 'Add at least one photo.';

  @override
  String get authStepPhotosTitle => 'Your photos';

  @override
  String get authStepPhotosSubtitle =>
      'Add up to 6 photos. The first one will be your main photo.';

  @override
  String get authBadgeMain => 'Main';

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsBtnEditProfile => 'Edit my profile';

  @override
  String get settingsBtnChangePassword => 'Change password';

  @override
  String get settingsBtnLogout => 'Log out';

  @override
  String get settingsBtnDeleteAccount => 'Delete account';

  @override
  String get settingsSectionDiscovery => 'Discovery';

  @override
  String get settingsLabelMaxDistance => 'Max distance';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Age range';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max years';
  }

  @override
  String get settingsSectionNotifications => 'Notifications';

  @override
  String get settingsNotifMatches => 'New matches';

  @override
  String get settingsNotifMessages => 'New messages';

  @override
  String get settingsNotifElegies => 'Elegies received';

  @override
  String get settingsSectionPrivacy => 'Privacy';

  @override
  String get settingsPrivacyVisible => 'Profile visible in swipe';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsVersionLabel => 'Version';

  @override
  String get settingsTermsOfService => 'Terms of service';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsDeleteAccountWarning =>
      'This action is irreversible.\nType your username to confirm.';

  @override
  String get settingsBtnCancel => 'Cancel';

  @override
  String get settingsBtnDeleteForever => 'Delete permanently';

  @override
  String get settingsErrorAllFieldsRequired => 'All fields are required';

  @override
  String get settingsErrorPasswordMismatch => 'Passwords don\'t match';

  @override
  String get settingsErrorPasswordMin => 'Minimum 12 characters';

  @override
  String get settingsLabelCurrentPassword => 'Current password';

  @override
  String get settingsLabelNewPassword => 'New password';

  @override
  String get settingsLabelConfirmNewPassword => 'Confirm new password';

  @override
  String get settingsBtnConfirm => 'Confirm';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date at $time';
  }

  @override
  String get eventPageTitle => 'EVENTS';

  @override
  String get eventLabelMaxDistance => 'Max distance';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Genres';

  @override
  String get eventFilterAllGenres => 'All genres';

  @override
  String get eventFilterMyGenres => 'My genres';

  @override
  String get eventEmptyZone => 'No events in your area';

  @override
  String get eventEmptyCategory => 'No events in this category';

  @override
  String get eventSubmittedForModeration => 'Event submitted for moderation';

  @override
  String get eventLimitTitle => 'Event limit reached';

  @override
  String eventLimitBody(int count) {
    return 'You\'ve used your $count event registrations for this month. Upgrade to Nocturne for 4/month or Abyssal for unlimited.';
  }

  @override
  String get eventUnregisterConfirmed => 'Unregistration confirmed';

  @override
  String get eventRegisterConfirmed => 'Registration confirmed!';

  @override
  String get eventSectionDescription => 'DESCRIPTION';

  @override
  String get eventSectionParticipants => 'PARTICIPANTS';

  @override
  String get eventBtnUnregisterLong => 'Registered ✓ — Unregister';

  @override
  String get eventPriceFree => 'Free';

  @override
  String get eventBadgeRegistered => 'Registered ✓';

  @override
  String get eventBtnRegister => 'Join';

  @override
  String eventAttendeeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attendees',
      one: '$count attendee',
    );
    return '$_temp0';
  }

  @override
  String eventMutualOne(String name) {
    return '$name is attending';
  }

  @override
  String eventMutualTwo(String name1, String name2) {
    return '$name1 and $name2 are attending';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: '$extra others',
      one: '1 other',
    );
    return '$names and $_temp0 are attending';
  }

  @override
  String get eventErrorTitleDescRequired => 'Title and description required';

  @override
  String get eventStepCoverTitle => 'Present your event';

  @override
  String get eventStepCoverSubtitle => 'Photo, title and description';

  @override
  String get eventBtnAddCoverPhoto => 'Add a cover photo';

  @override
  String get eventLabelTitleRequired => 'Title *';

  @override
  String get eventLabelDescriptionRequired => 'Description *';

  @override
  String get eventBtnContinue => 'Continue';

  @override
  String get eventErrorDateRequired => 'Choose a date and time';

  @override
  String get eventStepDatetimeTitle => 'When is the event?';

  @override
  String get eventStepDatetimeSubtitle => 'Start date and time';

  @override
  String get eventBtnPickDateTime => 'Choose a date and time';

  @override
  String get eventErrorAddressRequired => 'Select an address from the list';

  @override
  String get eventStepLocationTitle => 'Where does it take place?';

  @override
  String get eventStepLocationSubtitle => 'Search for the venue\'s address';

  @override
  String get eventStepGenresTitle => 'Music genres';

  @override
  String get eventStepGenresSubtitle => 'Select the event\'s genres';

  @override
  String get eventErrorCapacityInvalid => 'Enter a valid capacity (min 1)';

  @override
  String get eventErrorCapacityMaxMin => 'The max must be greater than the min';

  @override
  String get eventStepCapacityTitle => 'How many spots?';

  @override
  String get eventStepCapacitySubtitle => 'Maximum capacity of the event';

  @override
  String get eventToggleExactNumber => 'Exact number';

  @override
  String get eventToggleRange => 'Range';

  @override
  String get eventLabelExactPlaces => 'Number of spots *';

  @override
  String get eventLabelMin => 'Min *';

  @override
  String get eventLabelMax => 'Max *';

  @override
  String get eventErrorPriceInvalid => 'Enter a valid price';

  @override
  String get eventStepPriceTitle => 'What\'s the price?';

  @override
  String get eventStepPriceSubtitle => 'Last step before submitting';

  @override
  String get eventTogglePaid => 'Paid';

  @override
  String get eventLabelPriceRequired => 'Price *';

  @override
  String get eventBtnSubmit => 'Submit the event';

  @override
  String get eventFilterAll => 'All';

  @override
  String get eventFilterAttending => 'Attending';

  @override
  String get eventFilterMatches => 'My matches';

  @override
  String get eventFilterFavorites => 'Favorites';

  @override
  String get eventSheetUnregisterTitle => 'Unregister from the event';

  @override
  String get eventSheetRegisterTitle => 'Confirm registration';

  @override
  String get eventBtnConfirmUnregister => 'Confirm unregistration';

  @override
  String get eventBtnConfirmRegister => 'I\'m in!';

  @override
  String get eventPaymentSheetTitle => 'Confirm your ticket';

  @override
  String eventPaymentBtn(String amount) {
    return 'Pay $amount €';
  }

  @override
  String get eventPaymentError => 'Payment failed, try again.';

  @override
  String get eventBtnCancel => 'Cancel';

  @override
  String get eventSectionInfo => 'INFO';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max spots';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min spots',
      one: '1 spot',
    );
    return '$_temp0';
  }

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Music genres';

  @override
  String get profileSectionVibe => 'Vibe';

  @override
  String get profileSectionAesthetics => 'Aesthetic & culture';

  @override
  String get profileSectionSoundIntensity => 'Sound intensity';

  @override
  String get profileSectionEra => 'Era / scene';

  @override
  String get profileSectionDiscovery => 'Music discovery';

  @override
  String get profileSectionFavoriteBands => 'Favorite artists';

  @override
  String get profileSectionUpcomingEvents => 'Upcoming events';

  @override
  String get profileSectionLinks => 'Links';

  @override
  String get profileSectionPhotos => 'PHOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Unlock with Premium';

  @override
  String get profileEditTitle => 'EDIT MY PROFILE';

  @override
  String get profileEditTabIdentity => 'Identity';

  @override
  String get profileEditTabPhotos => 'Photos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Location';

  @override
  String get profileEditTabPreferences => 'Preferences';

  @override
  String get profileMenuTitle => 'MY SPACE';

  @override
  String get profileMenuLikesHistory => 'Likes history';

  @override
  String get profileMenuVisitors => 'Profile visitors';

  @override
  String get profileMenuMatches => 'My matches';

  @override
  String get profileMenuSettings => 'Settings';

  @override
  String get profileSnackIdentityUpdated => 'Identity updated!';

  @override
  String get profileLabelUsername => 'USERNAME';

  @override
  String get profileUsernameImmutableNote => 'Username can\'t be edited here.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Tell us about you, your music...';

  @override
  String get profileLabelGender => 'Gender';

  @override
  String get profileLabelPronouns => 'Pronouns';

  @override
  String get profileBtnSave => 'Save';

  @override
  String get profileSnackMaxPhotos => 'Maximum 6 photos';

  @override
  String get profileSnackPhotosUpdated => 'Photos updated!';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 photos';
  }

  @override
  String get profileBadgeNew => 'New';

  @override
  String get profileBtnAddPhoto => 'Add';

  @override
  String get profileSnackTagsUpdated => 'Music tags updated!';

  @override
  String get profileSubtitleMusicGenres => 'Your main sound identity';

  @override
  String get profileSectionMusicVibe => 'Musical vibe';

  @override
  String get profileSubtitleMusicVibe => 'What you feel while listening';

  @override
  String get profileSubtitleAesthetics => 'Your scene, your lifestyle';

  @override
  String get profileSubtitleSoundIntensity => 'The energy of your music';

  @override
  String get profileSubtitleEra => 'Your generational nostalgia';

  @override
  String get profileSubtitleDiscovery => 'Your listening habits';

  @override
  String get profileSectionFavoriteBandsCaps => 'FAVORITE ARTISTS';

  @override
  String get profileHintBands => 'Bauhaus, The Cure, Depeche Mode...';

  @override
  String get profileErrorSelectAddress => 'Select an address';

  @override
  String get profileSnackLocationUpdated => 'Location updated!';

  @override
  String get profileSectionLocation => 'LOCATION';

  @override
  String get profileLocationDescription =>
      'Used to find profiles and events near you.';

  @override
  String get profileSnackPreferencesUpdated => 'Preferences updated!';

  @override
  String get profileLabelAgeRange => 'AGE RANGE';

  @override
  String profileAgeYears(int age) {
    return '$age years';
  }

  @override
  String get profileLabelMaxDistance => 'MAX DISTANCE';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GENDER SOUGHT';
}
