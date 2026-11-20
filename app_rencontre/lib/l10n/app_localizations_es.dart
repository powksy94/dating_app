// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nocturne';

  @override
  String get commonGenericError => 'Ha ocurrido un error, inténtalo de nuevo.';

  @override
  String get commonLoadErrorSubtitle =>
      'Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get commonBtnRetry => 'Reintentar';

  @override
  String get commonOfflineBanner => 'Sin conexión';

  @override
  String commonStepProgress(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get commonAddressLabel => 'Dirección *';

  @override
  String get commonTotal => 'Total';

  @override
  String commonPageNotFound(String name) {
    return 'Página no encontrada: $name';
  }

  @override
  String commonAgoMinutes(int count) {
    return 'hace ${count}min';
  }

  @override
  String commonAgoHours(int count) {
    return 'hace ${count}h';
  }

  @override
  String commonAgoDays(int count) {
    return 'hace ${count}d';
  }

  @override
  String get commonUnknownError => 'Error desconocido';

  @override
  String get commonConnectionRequiredTitle => 'Conexión requerida';

  @override
  String get commonConnectionRequiredBody =>
      'Vuelve a conectarte a Internet para continuar.';

  @override
  String get subscriptionOfflineBody =>
      'Vuelve a conectarte a Internet para ver y gestionar las suscripciones.';

  @override
  String get eventLoadErrorTitle => 'No se pudieron cargar los eventos';

  @override
  String get profileLoadErrorTitle => 'No se pudo cargar tu perfil';

  @override
  String get discoveryFiltersTitle => 'FILTROS DE BÚSQUEDA';

  @override
  String get discoveryFiltersApply => 'Aplicar';

  @override
  String get discoveryFiltersConfirmTitle => '¿Aplicar estos filtros?';

  @override
  String get discoveryFiltersConfirmMessage =>
      'Tu feed de descubrimiento se recargará con la nueva distancia y franja de edad.';

  @override
  String get discoveryFiltersConfirmCancel => 'Cancelar';

  @override
  String get commonComingSoon => 'Próximamente';

  @override
  String get commonBtnOk => 'OK';

  @override
  String get commonBtnRemove => 'Quitar';

  @override
  String get updateRequiredTitle => 'Actualización requerida';

  @override
  String get updateRequiredBody =>
      'Hay una nueva versión de Nocturne disponible. Actualiza la aplicación para continuar.';

  @override
  String get updateRequiredBtn => 'Actualizar';

  @override
  String get eventPaidComingSoonBody =>
      'Los eventos de pago llegarán próximamente. Por ahora, puedes crear y unirte a eventos gratuitos.';

  @override
  String get visitorsTitle => 'VISITANTES';

  @override
  String get visitorsEmptyState => 'Nadie ha visitado tu perfil todavía';

  @override
  String get visitorsPaywallTitle => 'Función Nocturne';

  @override
  String get visitorsPaywallDescription =>
      'Descubre quién ha visitado tu perfil en los últimos 30 días pasándote a Nocturne o Abyssal.';

  @override
  String get visitorsPaywallSheetTitle => 'Visitantes del perfil';

  @override
  String get visitorsPaywallSheetDescription =>
      'Descubre todos los perfiles que han visto el tuyo.';

  @override
  String get visitorsBtnUpgrade => 'Pasar a Nocturne';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biometría no disponible en este dispositivo';

  @override
  String get adminAuthLocalizedReason =>
      'Verifica tu identidad para aprobar el inicio de sesión de administrador';

  @override
  String get adminAuthErrorBiometricFailed => 'Verificación biométrica fallida';

  @override
  String get adminAuthErrorBiometricGeneric => 'Error biométrico';

  @override
  String get adminAuthTitle => 'INICIO DE SESIÓN ADMIN';

  @override
  String get adminAuthDescription =>
      'Se ha iniciado una solicitud de inicio de sesión al panel admin desde un navegador.';

  @override
  String get adminAuthBiometricRequired => 'Biometría requerida para aprobar';

  @override
  String get adminAuthBtnApprove => 'Aprobar';

  @override
  String get adminAuthBtnDeny => 'Rechazar';

  @override
  String get adminLockTitle => 'ACCESO BLOQUEADO';

  @override
  String get adminLockSubtitle =>
      'Autentícate para acceder a las herramientas de administración.';

  @override
  String get adminLockLocalizedReason =>
      'Verifica tu identidad para acceder a las herramientas de administración';

  @override
  String get adminLockBtnRetry => 'Reintentar';

  @override
  String get adminLockBtnCancel => 'Cancelar';

  @override
  String get eventReviewTitle => 'EVENTOS POR VALIDAR';

  @override
  String get eventReviewEmpty => 'No hay eventos pendientes';

  @override
  String get eventReviewFree => 'Gratis';

  @override
  String get eventReviewBtnApprove => 'Aprobar';

  @override
  String get eventReviewBtnReject => 'Rechazar';

  @override
  String get eventReviewApproved => 'Evento aprobado';

  @override
  String get eventReviewRejected => 'Evento rechazado';

  @override
  String get photoReviewTitle => 'FOTOS POR VERIFICAR';

  @override
  String get photoReviewEmpty => 'No hay fotos pendientes';

  @override
  String get photoReviewBtnApprove => 'Aprobar';

  @override
  String get photoReviewBtnReject => 'Rechazar';

  @override
  String get photoReviewApproved => 'Foto aprobada';

  @override
  String get photoReviewRejected => 'Foto rechazada';

  @override
  String get photoReviewDetailTitle => 'Detalle de la foto';

  @override
  String get photoReviewLabelsLabel => 'Elementos detectados';

  @override
  String get photoReviewDateLabel => 'Añadida el';

  @override
  String profileSnackPhotosPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos en proceso de verificación',
      one: '1 foto en proceso de verificación',
    );
    return '$_temp0';
  }

  @override
  String profileSnackPhotosAutoRejected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos han sido rechazadas',
      one: '1 foto ha sido rechazada',
    );
    return '$_temp0';
  }

  @override
  String get reportReviewTitle => 'DENUNCIAS POR GESTIONAR';

  @override
  String get reportReviewEmpty => 'No hay denuncias pendientes';

  @override
  String get reportReviewReporterLabel => 'Denunciado por';

  @override
  String get reportReviewReasonLabel => 'Motivo';

  @override
  String get reportReviewMessageLabel => 'Mensaje denunciado';

  @override
  String get reportReviewBannedBadge => 'Baneado';

  @override
  String get reportReviewTestAccountBadge => 'Cuenta de prueba';

  @override
  String get reportReviewBtnDismiss => 'Descartar';

  @override
  String get reportReviewBtnBan => 'Banear';

  @override
  String get reportReviewBtnUnban => 'Desbanear';

  @override
  String get reportReviewDismissed => 'Denuncia descartada';

  @override
  String get reportReviewBanned => 'Usuario baneado';

  @override
  String get reportReviewUnbanned => 'Usuario desbaneado';

  @override
  String get reportDetailTitle => 'Detalle de la denuncia';

  @override
  String get reportDetailDateLabel => 'Denunciado el';

  @override
  String get homeNavDiscover => 'Descubrir';

  @override
  String get homeNavEvents => 'Eventos';

  @override
  String get homeNavMessages => 'Mensajes';

  @override
  String get homeNavProfile => 'Perfil';

  @override
  String get homeMyProfileTitle => 'MI PERFIL';

  @override
  String get onboardingTourSkip => 'Omitir';

  @override
  String get onboardingTourNext => 'Siguiente';

  @override
  String get onboardingTourGetStarted => 'Entrar en Nocturne';

  @override
  String get onboardingTourTitle1 => 'DESLÍZATE EN LA OSCURIDAD';

  @override
  String get onboardingTourSubtitle1 =>
      'Desliza perfiles que comparten tu estética y tus gustos musicales.';

  @override
  String get onboardingTourTitle2 => 'REUNÍOS EN LA NOCHE';

  @override
  String get onboardingTourSubtitle2 =>
      'Encuentra conciertos y encuentros cerca de ti, y únete a otros pájaros nocturnos.';

  @override
  String get onboardingTourTitle3 => 'ENVÍA UNA ELEGÍA';

  @override
  String get onboardingTourSubtitle3 =>
      'Rompe el hielo con una elegía sincera en lugar de un simple hola.';

  @override
  String get onboardingTourTitle4 => 'MODELA TU SOMBRA';

  @override
  String get onboardingTourSubtitle4 =>
      'Personaliza tus fotos, grupos favoritos y enlaces sociales.';

  @override
  String get homeExitConfirmTitle => '¿Salir de Nocturne?';

  @override
  String get homeExitConfirmMessage =>
      'Puedes volver cuando quieras, tus conversaciones seguirán intactas.';

  @override
  String get homeExitConfirmCancel => 'Cancelar';

  @override
  String get homeExitConfirmQuit => 'Salir';

  @override
  String get homeNoProfileTitle => 'Perfil no configurado';

  @override
  String get homeNoProfileDescription =>
      'Crea tu perfil para aparecer en el swipe';

  @override
  String get homeBtnCreateProfile => 'Crear mi perfil';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Elegía enviada a $username';
  }

  @override
  String get elegieLimitReachedTitle => 'Límite de elegías alcanzado';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Has usado tus $count elegías del día. Pasa a Nocturne para enviar más.',
      one: 'Has usado tu elegía del día. Pasa a Nocturne para enviar más.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Elegía para $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'Un mensaje breve antes de que decidan las tinieblas';

  @override
  String get elegieHintMessage => 'Escribe tu mensaje...';

  @override
  String get elegieBtnSend => 'Enviar la elegía';

  @override
  String get elegieBannerDescription =>
      'Pasa a Nocturne para enviar más elegías.';

  @override
  String get elegieBtnUpgrade => 'Pasar a Nocturne';

  @override
  String get periodWeek => 'semana';

  @override
  String get periodMonth => 'mes';

  @override
  String get periodYear => 'año';

  @override
  String get subscriptionRestoreCta => 'Restaurar mis compras';

  @override
  String get subscriptionRestoreSuccess => '¡Compras restauradas!';

  @override
  String get subscriptionRestoreEmpty => 'No hay compras que restaurar.';

  @override
  String get subscriptionBtnSwitchToFree => 'Pasar al plan gratuito';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Plan actual';

  @override
  String get subscriptionBtnChangePeriod => 'Cambiar de periodo';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return 'Elegir $planName';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ ¡Suscripción $planName activada!';
  }

  @override
  String get subscriptionSnackError => 'Error, inténtalo de nuevo.';

  @override
  String get subscriptionSnackCancelled => 'Suscripción cancelada.';

  @override
  String get subscriptionCancelSubscription => 'Cancelar la suscripción';

  @override
  String get subscriptionCancelAnytimeNote =>
      'Puedes cancelar en cualquier momento';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return 'Suscribirse a $planName';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Cancelar';

  @override
  String get subscriptionBtnDialogConfirm => 'Confirmar';

  @override
  String get subscriptionDialogCancelBody =>
      'Perderás el acceso a las funciones premium.';

  @override
  String get subscriptionBtnKeep => 'Mantener';

  @override
  String get subscriptionBtnConfirmCancel => 'Cancelar';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle => 'Únete a las tinieblas sin límites';

  @override
  String get subscriptionPaywallBtnViewPlans => 'Ver las suscripciones';

  @override
  String get subscriptionPaywallBtnNotNow => 'No ahora';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Disponible desde $planName';
  }

  @override
  String get subscriptionPlanOmbre => 'Sombra';

  @override
  String get subscriptionPlanNocturne => 'Nocturne';

  @override
  String get subscriptionPlanAbyssal => 'Abyssal';

  @override
  String get subscriptionBadgePopular => 'POPULAR';

  @override
  String get subscriptionPriceFree => 'Gratis';

  @override
  String get subscriptionPriceUnavailable => 'Precio no disponible';

  @override
  String get subscriptionBtnRetry => 'Reintentar';

  @override
  String get featureOmbreSwipes => '30 swipes al día';

  @override
  String get featureOmbreElegies => '3 elegías al mes';

  @override
  String get featureOmbreEvents => '2 eventos al mes';

  @override
  String get featureOmbrePhotos => '2 fotos por perfil';

  @override
  String get featureWhoLikedMe => 'Ver quién te ha dado like';

  @override
  String get featureWhoVisited => 'Quién ha visitado tu perfil';

  @override
  String get featureRewind => 'Rewind (deshacer un swipe)';

  @override
  String get featureBoostGeneric => 'Boost de perfil';

  @override
  String get featureUnlimitedSwipe => 'Swipe ilimitado';

  @override
  String get featureNocturneElegies => '15 elegías al mes';

  @override
  String get featureNocturneEvents => '4 eventos al mes';

  @override
  String get featurePhotos6 => '6 fotos por perfil';

  @override
  String get featureBoostMonthly => '1 boost al mes';

  @override
  String get featureUnlimitedElegies => 'Elegías ilimitadas';

  @override
  String get featureUnlimitedEvents => 'Eventos ilimitados';

  @override
  String get featureBoostWeekly => '1 boost a la semana';

  @override
  String get socialBtnReport => 'Denunciar';

  @override
  String get socialBtnBlock => 'Bloquear';

  @override
  String socialDialogBlockBody(String username) {
    return '¿Bloquear a $username? Vuestro match se eliminará.';
  }

  @override
  String get socialBtnCancel => 'Cancelar';

  @override
  String get reportCategoryHarassment => 'Acoso';

  @override
  String get reportSubHarassmentTargeted => 'Me ataca personalmente';

  @override
  String get reportSubHarassmentThreatening => 'Comportamiento amenazante';

  @override
  String get reportSubHarassmentRepeated => 'Mensajes no deseados repetidos';

  @override
  String get reportCategoryFakeProfile => 'Perfil falso';

  @override
  String get reportSubFakeStolenPhotos => 'Fotos robadas';

  @override
  String get reportSubFakeImpersonation => 'Suplantación de identidad';

  @override
  String get reportSubFakeGhost => 'Cuenta fantasma';

  @override
  String get reportCategoryNonConsensualSexual =>
      'Contenido sexual no consentido';

  @override
  String get reportCategorySpam => 'Spam o estafa';

  @override
  String get reportCategoryMinor => 'Menor de edad';

  @override
  String get reportCategoryHateSpeech => 'Discurso de odio o discriminatorio';

  @override
  String get reportCategoryOther => 'Otro';

  @override
  String socialReportHeaderTitle(String username) {
    return 'Denunciar a $username';
  }

  @override
  String get socialReportRootQuestion => '¿Por qué denuncias este perfil?';

  @override
  String get socialReportRootQuestionMessage =>
      '¿Por qué denuncias este mensaje?';

  @override
  String get socialReportHint => 'Describe el problema...';

  @override
  String get socialBtnSendReport => 'Enviar la denuncia';

  @override
  String get socialReportSentTitle => 'Denuncia enviada';

  @override
  String get socialReportSentBody =>
      'Gracias. Nuestro equipo revisará esta denuncia.';

  @override
  String get socialBtnClose => 'Cerrar';

  @override
  String get chatReplyPhoto => 'Foto';

  @override
  String get chatMessageDeleted => 'Mensaje eliminado';

  @override
  String get chatMessageUnderReview => 'Denuncia en proceso de verificación';

  @override
  String get chatStatusRead => 'Leído';

  @override
  String get chatStatusSent => 'Enviado';

  @override
  String get chatListTitle => 'MENSAJES';

  @override
  String get chatTabChats => 'CHATS';

  @override
  String get chatTabElegiesReceived => 'ELEGÍAS RECIBIDAS';

  @override
  String get chatTabElegiesSent => 'ELEGÍAS ENVIADAS';

  @override
  String get chatEmptyMatchesTitle => 'Ningún match todavía...';

  @override
  String get chatEmptyMatchesSub => 'Sigue explorando las tinieblas';

  @override
  String get giftRevealHint => 'Toca el sello para abrirlo';

  @override
  String get giftRevealTitle => 'DOS MESES DE NOCTURNE';

  @override
  String get giftRevealSubtitle =>
      'Un regalo para las cincuenta primeras almas que se atrevieron a entrar 🌙';

  @override
  String get giftRevealClose => 'Continuar';

  @override
  String get giftRevealErrorTitle => 'La cera no quiso ceder';

  @override
  String get giftRevealErrorSubtitle =>
      'Ha ocurrido un error. Inténtalo de nuevo.';

  @override
  String get giftRevealRetry => 'Reintentar';

  @override
  String get matchTitleBond => 'UN VÍNCULO OSCURO';

  @override
  String get matchTitleBorn => 'HA NACIDO';

  @override
  String get matchTitleElegie => 'TU ELEGÍA HA SIDO ESCUCHADA';

  @override
  String get matchSubtitleElegie => 'Las tinieblas han escuchado tu plegaria';

  @override
  String matchSubtitleBond(String username) {
    return 'Tú y $username estáis unidos por las tinieblas';
  }

  @override
  String get matchBtnMessage => 'ENVIAR UN MENSAJE';

  @override
  String get matchBtnKeepExploring => 'Seguir explorando';

  @override
  String get matchAvatarYou => 'Tú';

  @override
  String get matchesTileSubtitle => 'Unidos por las tinieblas';

  @override
  String get matchesBtnMessage => 'Mensaje';

  @override
  String get chatOpenErrorTitle => 'No se pudo abrir la conversación';

  @override
  String get commonBtnCancel => 'Cancelar';

  @override
  String get commonBtnSend => 'Enviar';

  @override
  String get starterCardTitle => 'Para romper el hielo';

  @override
  String get starterConfirmTitle => '¿Enviar este mensaje?';

  @override
  String get starterNoCommonDialog =>
      'Vuestros perfiles no tienen ningún tag en común, pero os habéis gustado igualmente. Aquí tienes algunas ideas para romper el hielo.';

  @override
  String get starterToggleClassic => 'Ideas clásicas';

  @override
  String get starterToggleShared => 'Según vuestros puntos en común';

  @override
  String starterHookShared(String tag) {
    return 'Tenéis $tag en común.';
  }

  @override
  String starterHookRare(String tag) {
    return 'Pocos perfiles tienen $tag, y vosotros dos formáis parte de ellos.';
  }

  @override
  String starterHookCombo(String tag1, String tag2) {
    return 'Tenéis $tag1 y $tag2 en común.';
  }

  @override
  String starterHookBand(String band) {
    return 'A ambos os gusta $band.';
  }

  @override
  String starterHookEvent(String event) {
    return 'Ambos participáis en el evento $event.';
  }

  @override
  String get starterHookMood =>
      'Os identificáis con el mismo ambiente musical.';

  @override
  String starterHookOtherBand(String band) {
    return 'A esta persona le gusta $band.';
  }

  @override
  String starterMsgGenre1(String tag) {
    return 'Ahora mismo estoy en plena fase $tag. ¿Y tú, qué canción tienes en bucle?';
  }

  @override
  String starterMsgGenre2(String tag) {
    return '¿Cuál fue el primer grupo de $tag que te metió de lleno en esto?';
  }

  @override
  String starterMsgGenre3(String tag) {
    return 'Si solo pudiera escuchar un álbum de $tag esta semana, ¿cuál me recomendarías?';
  }

  @override
  String starterMsgVibe1(String tag) {
    return 'Si tu playlist $tag fuera la banda sonora de una película, ¿cuál sería?';
  }

  @override
  String starterMsgVibe2(String tag) {
    return '¿Qué canción te pone directamente en modo $tag?';
  }

  @override
  String get starterMsgVibeSensitive =>
      '¿Qué canción te acompaña en esos momentos?';

  @override
  String starterMsgAesthetic1(String tag) {
    return 'Tu universo $tag, ¿por dónde empieza: la ropa, el cuarto, las portadas de los discos?';
  }

  @override
  String starterMsgIntensity1(String tag) {
    return 'En cuanto a intensidad $tag, ¿qué canción te representa mejor?';
  }

  @override
  String starterMsgEra1(String tag) {
    return '¿Qué disco de la época $tag te llevarías a una isla desierta?';
  }

  @override
  String get starterMsgFormatConcerts =>
      '¿El último concierto que te marcó, y el peor también?';

  @override
  String get starterMsgFormatVinyl =>
      '¿La pieza de tu colección que más significa para ti?';

  @override
  String get starterMsgFormatBandcamp =>
      '¿Tu último descubrimiento en Bandcamp? Busco algo para mi próxima sesión de escucha.';

  @override
  String get starterMsgFormatPlaylist =>
      '¿Una playlist que escuches en bucle? Mándame el enlace.';

  @override
  String get starterMsgFormatUnderground =>
      '¿Algún lugar pequeño o escena local que merezca ser más conocida, donde vives?';

  @override
  String starterMsgBand1(String band) {
    return '¿Tu álbum favorito de $band, y el que defiendes aunque divida opiniones?';
  }

  @override
  String get starterMsgEvent1 => '¿Qué es lo que más esperas de este evento?';

  @override
  String starterMsgOtherBand1(String band) {
    return 'He visto que te gusta $band. ¿Cuál es tu álbum favorito?';
  }

  @override
  String starterMsgCombo1(String tag1, String tag2) {
    return '$tag1 y $tag2, suena como la noche perfecta. ¿Con qué canción la empezarías?';
  }

  @override
  String get starterFallback1 =>
      '¿El último álbum que escuchaste de principio a fin?';

  @override
  String get starterFallback2 =>
      'Si tu playlist del momento fuera una película, ¿cómo se llamaría?';

  @override
  String get starterFallback3 =>
      '¿Un grupo que defiendes aunque nadie lo entienda?';

  @override
  String get starterFallback4 =>
      '¿Una canción que siempre te emociona, incluso después de cien escuchas?';

  @override
  String get starterFallback5 =>
      '¿Un concierto de ensueño, y tu peor recuerdo de concierto?';

  @override
  String get starterFallback6 =>
      'Reto: cada uno manda una canción que seguro el otro no conoce. ¿Trato?';

  @override
  String get chatEmptyElegiesReceivedTitle => 'Ninguna elegía recibida';

  @override
  String get chatEmptyElegiesReceivedSub => 'Alguien pensará en ti pronto...';

  @override
  String get chatEmptyElegiesSentTitle => 'Ninguna elegía enviada';

  @override
  String get chatEmptyElegiesSentSub => 'Atrévete a romper el silencio...';

  @override
  String get chatMessageBlockedContactInfo =>
      'Por tu seguridad, los enlaces y números de teléfono no están permitidos hasta que la otra persona responda.';

  @override
  String get chatNewMatch => 'Nuevo match';

  @override
  String get chatElegiePending => 'Pendiente';

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
  String get chatTyping => 'escribiendo...';

  @override
  String get chatInputHint => 'Mensaje...';

  @override
  String get chatEmojiHint => 'Elige un emoji...';

  @override
  String get chatBtnReportMessage => 'Denunciar este mensaje';

  @override
  String get chatBtnDeleteForMe => 'Eliminar para mí';

  @override
  String get chatBtnDeleteForAll => 'Eliminar para todos';

  @override
  String get chatLastSeenJustNow => 'visto justo ahora';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'visto hace $count min';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'visto hace $count h';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'visto hace $count d';
  }

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'Ningún perfil por aquí cerca...';

  @override
  String get discoveryEmptySubtitle =>
      'Has visto todos los perfiles disponibles por ahora.';

  @override
  String get discoveryEmptyResetLikes => 'Reiniciar tus likes';

  @override
  String get discoveryEmptyEditFilters => 'Modificar tus filtros de búsqueda';

  @override
  String get discoveryEmptyWaitMoon => 'Esperar una luna nueva';

  @override
  String get discoveryEmptyResetSuccess =>
      'Tus likes se han reiniciado, los perfiles vuelven a aparecer en el feed.';

  @override
  String get discoveryEmptyWaitMoonMessage =>
      'Llegan nuevos perfiles con la luna nueva. Vuelve pronto.';

  @override
  String get discoveryLoadErrorTitle => 'No se pudieron cargar los perfiles';

  @override
  String get discoveryLoadErrorSubtitle =>
      'Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get discoveryBtnRetry => 'Reintentar';

  @override
  String get discoveryBoostActivated =>
      '¡Boost activado! Tu perfil se destaca durante 30 minutos.';

  @override
  String get discoveryRewindTitle => 'Rewind no disponible';

  @override
  String get discoveryRewindBody =>
      'El rewind está disponible a partir del plan Nocturne.';

  @override
  String get discoveryBoostTitle => 'Boost no disponible';

  @override
  String get discoveryBoostBody =>
      'El boost está disponible a partir del plan Nocturne (1/mes) o Abyssal (1/semana).';

  @override
  String get discoverySwipeLimitTitle => 'Límite de swipes alcanzado';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'Has usado tus $count swipes del día. Pasa a Nocturne para swipear sin límite.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit swipes hoy';
  }

  @override
  String get discoveryBtnElegie => 'Elegía';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'Mis likes';

  @override
  String get discoveryTabWhoLikedMe => 'Quién me ha dado like';

  @override
  String get discoveryEmptyMyLikes => 'Ningún like por ahora';

  @override
  String get discoveryEmptyWhoLikedMe => 'Nadie te ha dado like todavía';

  @override
  String get discoveryPaywallTitle => 'Función Nocturne';

  @override
  String get discoveryPaywallDescription =>
      'Descubre quién le ha dado like a tu perfil pasándote a Nocturne o Abyssal.';

  @override
  String get discoveryPaywallSheetTitle => 'Quién me ha dado like';

  @override
  String get discoveryPaywallSheetDescription =>
      'Descubre todos los perfiles que le han dado like al tuyo.';

  @override
  String get discoveryBtnUpgrade => 'Pasar a Nocturne';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Email o contraseña incorrectos.';

  @override
  String get authLabelEmail => 'Email';

  @override
  String get authLabelPassword => 'Contraseña';

  @override
  String get authBtnLogin => 'Iniciar sesión';

  @override
  String get authBtnGoToRegister => '¿Aún no tienes cuenta? Crear una cuenta';

  @override
  String get authBtnForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authForgotTitle => 'Contraseña olvidada';

  @override
  String get authForgotSubtitle =>
      'Introduce tu email, te enviaremos un código de 6 cifras.';

  @override
  String get authBtnSendCode => 'Enviar el código';

  @override
  String get authForgotSentMessage =>
      'Si existe una cuenta con este email, se ha enviado un código.';

  @override
  String get authVerifyCodeTitle => 'Verificar el código';

  @override
  String get authVerifyCodeSubtitle =>
      'Introduce el código de 6 cifras recibido por email.';

  @override
  String get authBtnVerifyCode => 'Verificar';

  @override
  String get authResetTitle => 'Restablecer la contraseña';

  @override
  String get authResetSubtitle => 'Elige tu nueva contraseña.';

  @override
  String get authLabelResetCode => 'Código de 6 cifras';

  @override
  String get authLabelNewPassword => 'Nueva contraseña';

  @override
  String get authBtnResetPassword => 'Restablecer';

  @override
  String get authResetSuccessMessage =>
      'Contraseña restablecida. Inicia sesión con tu nueva contraseña.';

  @override
  String get authWelcomeTitle => 'BIENVENIDO/A';

  @override
  String get authWelcomeSubtitle => 'a las tinieblas';

  @override
  String get authLabelUsername => 'Nombre de usuario';

  @override
  String get authErrorFillAllFields => 'Completa todos los campos.';

  @override
  String get authErrorInvalidEmail => 'Email no válido.';

  @override
  String get authErrorPasswordTooShort => 'Contraseña: mínimo 12 caracteres.';

  @override
  String get authErrorPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get authStepCredentialsTitle => 'Bienvenido/a a \nlas tinieblas 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Crea tu cuenta para unirte a Nocturne.';

  @override
  String get authHelperPasswordMin => 'Mínimo 12 caracteres';

  @override
  String get authLabelConfirmPassword => 'Confirmar la contraseña';

  @override
  String get authBtnContinue => 'Continuar';

  @override
  String get authLabelBirthDate => 'Fecha de nacimiento';

  @override
  String get authErrorUsernameInvalid =>
      'Elige un nombre de usuario válido y disponible.';

  @override
  String get authStepIdentityTitle => '¿Quién eres?';

  @override
  String get authStepIdentitySubtitle =>
      'Esta información no se podrá modificar fácilmente.';

  @override
  String get authLabelGender => 'Género';

  @override
  String get authLabelPronouns => 'Pronombres';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Cuéntanos sobre ti, tu música, tu universo...';

  @override
  String get authOther => 'Otro';

  @override
  String get authGenderMale => 'Hombre';

  @override
  String get authGenderFemale => 'Mujer';

  @override
  String get authGenderNonBinary => 'No binario';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agénero';

  @override
  String get authGenderTransmasculine => 'Transmasculino';

  @override
  String get authGenderTransfeminine => 'Transfemenino';

  @override
  String get authGenderAll => 'Todos';

  @override
  String get authPronounHeHim => 'Él/él';

  @override
  String get authPronounSheHer => 'Ella/ella';

  @override
  String get authPronounTheyThem => 'Elle/elle';

  @override
  String get authPronounPluralNeutral => 'Ellxs/elles';

  @override
  String get authLabelSpecify => 'Especifica...';

  @override
  String get authErrorSelectPreference =>
      'Selecciona al menos una preferencia.';

  @override
  String get authStepPreferencesTitle => 'Tus preferencias';

  @override
  String get authStepPreferencesSubtitle => '¿A quién quieres conocer?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Franja de edad: $min - $max años';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Distancia máxima: $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Género(s) buscado(s)';

  @override
  String get authBtnCreateAccount => 'Crear mi cuenta';

  @override
  String get authStepVerifyEmailTitle => 'Verifica tu email';

  @override
  String authStepVerifyEmailSubtitle(String email) {
    return 'Introduce el código de 6 cifras enviado a $email';
  }

  @override
  String get authLabelVerificationCode => 'Código de 6 cifras';

  @override
  String get authBtnVerifyEmail => 'Verificar';

  @override
  String get authBtnResendVerificationCode => 'Reenviar el código';

  @override
  String get authVerifyEmailResentMessage => 'Se ha enviado un nuevo código.';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Selecciona al menos un género y una estética.';

  @override
  String get authStepTagsTitle => 'Tu universo musical';

  @override
  String get authStepTagsSubtitle =>
      'Estos tags sirven para hacerte match con perfiles compatibles.';

  @override
  String get authSectionMusicGenres => 'Géneros musicales';

  @override
  String get authSectionMusicVibes => 'Ambiente musical';

  @override
  String get authSectionAesthetics => 'Estética';

  @override
  String get authSectionSoundIntensity => 'Intensidad sonora';

  @override
  String get authSectionMusicEras => 'Época';

  @override
  String get authSectionDiscoveryFormats => 'Descubrimiento musical';

  @override
  String get authSectionFavoriteBands =>
      'Grupos / Artistas favoritos (opcional)';

  @override
  String get authHintBands => 'Un grupo cada vez, ej.: The Cure';

  @override
  String get bandSearchAttribution => 'Resultados vía Spotify';

  @override
  String get authLocationPermissionDenied =>
      'Permiso denegado. Puedes omitir este paso';

  @override
  String get authLocationError =>
      'No se pudo obtener la ubicación. Puedes omitir este paso.';

  @override
  String get authStepLocationTitle => 'Tu ubicación';

  @override
  String get authStepLocationSubtitle =>
      'Para mostrarte perfiles cerca de ti. Puedes omitir este paso.';

  @override
  String get authLocationSaved => 'Ubicación guardada ✓';

  @override
  String get authBtnAllowLocation => 'Permitir la ubicación';

  @override
  String get authBtnSkipStep => 'Omitir este paso';

  @override
  String get authErrorAddPhoto => 'Añade al menos una foto.';

  @override
  String get authStepPhotosTitle => 'Tus fotos';

  @override
  String get authStepPhotosSubtitle =>
      'Añade hasta 6 fotos. La primera será tu foto principal.';

  @override
  String get authBadgeMain => 'Principal';

  @override
  String get settingsTitle => 'AJUSTES';

  @override
  String get settingsSectionAccount => 'Cuenta';

  @override
  String get settingsBtnEditProfile => 'Editar mi perfil';

  @override
  String get settingsBtnChangePassword => 'Cambiar la contraseña';

  @override
  String get settingsBtnLogout => 'Cerrar sesión';

  @override
  String get settingsBtnDeleteAccount => 'Eliminar la cuenta';

  @override
  String get settingsLabelMaxDistance => 'Distancia máxima';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Franja de edad';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max años';
  }

  @override
  String get settingsSectionNotifications => 'Notificaciones';

  @override
  String get settingsNotifMatches => 'Nuevos matches';

  @override
  String get settingsNotifMessages => 'Nuevos mensajes';

  @override
  String get settingsNotifElegies => 'Elegías recibidas';

  @override
  String get settingsSectionPrivacy => 'Privacidad';

  @override
  String get settingsPrivacyVisible => 'Perfil visible en el swipe';

  @override
  String get settingsSectionAbout => 'Acerca de';

  @override
  String get settingsVersionLabel => 'Versión';

  @override
  String get settingsTermsOfService => 'Términos de uso';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsRateApp => 'Valorar la aplicación';

  @override
  String get settingsSectionAdmin => 'Administración';

  @override
  String get settingsAdminReports => 'Denuncias';

  @override
  String get settingsAdminPhotos => 'Fotos';

  @override
  String get settingsDeleteAccountWarning =>
      'Esta acción es irreversible.\nEscribe tu nombre de usuario para confirmar.';

  @override
  String get settingsBtnCancel => 'Cancelar';

  @override
  String get settingsBtnDeleteForever => 'Eliminar definitivamente';

  @override
  String get settingsErrorAllFieldsRequired =>
      'Todos los campos son obligatorios';

  @override
  String get settingsErrorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get settingsErrorPasswordMin => 'Mínimo 12 caracteres';

  @override
  String get settingsLabelCurrentPassword => 'Contraseña actual';

  @override
  String get settingsLabelNewPassword => 'Nueva contraseña';

  @override
  String get settingsLabelConfirmNewPassword => 'Confirmar la nueva';

  @override
  String get settingsBtnConfirm => 'Confirmar';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date a las $time';
  }

  @override
  String get eventPageTitle => 'EVENTOS';

  @override
  String get eventLabelMaxDistance => 'Distancia máxima';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Géneros';

  @override
  String get eventFilterAllGenres => 'Todos los géneros';

  @override
  String get eventFilterMyGenres => 'Mis géneros';

  @override
  String get eventEmptyZone => 'Ningún evento en tu zona';

  @override
  String get eventEmptyCategory => 'Ningún evento en esta categoría';

  @override
  String get eventSubmittedForModeration => 'Evento enviado para moderación';

  @override
  String get eventLimitTitle => 'Límite de eventos alcanzado';

  @override
  String eventLimitBody(int count) {
    return 'Has usado tus $count inscripciones a eventos este mes. Pasa a Nocturne para 4/mes o a Abyssal para ilimitadas.';
  }

  @override
  String get eventUnregisterConfirmed => 'Baja confirmada';

  @override
  String get eventRegisterConfirmed => '¡Inscripción confirmada!';

  @override
  String get eventSectionDescription => 'DESCRIPCIÓN';

  @override
  String get eventSectionParticipants => 'PARTICIPANTES';

  @override
  String get eventBtnUnregisterLong => 'Inscrito ✓ — Darse de baja';

  @override
  String get eventPriceFree => 'Gratis';

  @override
  String get eventBadgeRegistered => 'Inscrito ✓';

  @override
  String get eventBtnRegister => 'Inscribirse';

  @override
  String eventAttendeeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count participantes',
      one: '$count participante',
    );
    return '$_temp0';
  }

  @override
  String eventMutualOne(String name) {
    return '$name participa';
  }

  @override
  String eventMutualTwo(String name1, String name2) {
    return '$name1 y $name2 participan';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: '$extra más',
      one: '1 más',
    );
    return '$names y $_temp0 participan';
  }

  @override
  String get eventErrorTitleDescRequired => 'Título y descripción obligatorios';

  @override
  String get eventStepCoverTitle => 'Presenta tu evento';

  @override
  String get eventStepCoverSubtitle => 'Foto, título y descripción';

  @override
  String get eventBtnAddCoverPhoto => 'Añadir una foto de portada';

  @override
  String get eventLabelTitleRequired => 'Título *';

  @override
  String get eventLabelDescriptionRequired => 'Descripción *';

  @override
  String get eventBtnContinue => 'Continuar';

  @override
  String get eventErrorDateRequired => 'Elige una fecha y una hora';

  @override
  String get eventStepDatetimeTitle => '¿Cuándo tiene lugar el evento?';

  @override
  String get eventStepDatetimeSubtitle => 'Fecha y hora de inicio';

  @override
  String get eventBtnPickDateTime => 'Elegir una fecha y hora';

  @override
  String get eventErrorAddressRequired =>
      'Selecciona una dirección de la lista';

  @override
  String get eventStepLocationTitle => '¿Dónde se celebra?';

  @override
  String get eventStepLocationSubtitle => 'Busca la dirección del lugar';

  @override
  String get eventStepGenresTitle => 'Géneros musicales';

  @override
  String get eventStepGenresSubtitle => 'Selecciona los géneros del evento';

  @override
  String get eventErrorCapacityInvalid =>
      'Introduce una capacidad válida (mín. 1)';

  @override
  String get eventErrorCapacityMaxMin =>
      'El máximo debe ser mayor que el mínimo';

  @override
  String get eventStepCapacityTitle => '¿Cuántas plazas?';

  @override
  String get eventStepCapacitySubtitle => 'Capacidad máxima del evento';

  @override
  String get eventToggleExactNumber => 'Número exacto';

  @override
  String get eventToggleRange => 'Rango';

  @override
  String get eventLabelExactPlaces => 'Número de plazas *';

  @override
  String get eventLabelMin => 'Mín *';

  @override
  String get eventLabelMax => 'Máx *';

  @override
  String get eventErrorPriceInvalid => 'Introduce un precio válido';

  @override
  String get eventStepPriceTitle => '¿Cuál es el precio?';

  @override
  String get eventStepPriceSubtitle => 'Último paso antes de enviar';

  @override
  String get eventTogglePaid => 'De pago';

  @override
  String get eventLabelPriceRequired => 'Precio *';

  @override
  String get eventBtnSubmit => 'Enviar el evento';

  @override
  String get eventFilterAll => 'Todos';

  @override
  String get eventFilterAttending => 'Inscritos';

  @override
  String get eventFilterMatches => 'Mis matches';

  @override
  String get eventFilterFavorites => 'Favoritos';

  @override
  String get eventSheetUnregisterTitle => 'Darse de baja del evento';

  @override
  String get eventSheetRegisterTitle => 'Confirmar la inscripción';

  @override
  String get eventBtnConfirmUnregister => 'Confirmar la baja';

  @override
  String get eventBtnConfirmRegister => '¡Participo!';

  @override
  String get eventPaymentSheetTitle => 'Confirma tu entrada';

  @override
  String eventPaymentBtn(String amount) {
    return 'Pagar $amount €';
  }

  @override
  String get eventPaymentError => 'Pago fallido, inténtalo de nuevo.';

  @override
  String get eventBtnCancel => 'Cancelar';

  @override
  String get eventSectionInfo => 'INFO';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max plazas';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min plazas',
      one: '1 plaza',
    );
    return '$_temp0';
  }

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Géneros musicales';

  @override
  String get profileSectionVibe => 'Ambiente';

  @override
  String get profileSectionAesthetics => 'Estética y cultura';

  @override
  String get profileSectionSoundIntensity => 'Intensidad sonora';

  @override
  String get profileSectionEra => 'Época / escena';

  @override
  String get profileSectionDiscovery => 'Descubrimiento musical';

  @override
  String get profileSectionFavoriteBands => 'Artistas favoritos';

  @override
  String get profileSectionUpcomingEvents => 'Próximos eventos';

  @override
  String get profileSectionLinks => 'Enlaces';

  @override
  String get profileSectionPhotos => 'FOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Desbloquear con Premium';

  @override
  String get profileEditTitle => 'EDITAR MI PERFIL';

  @override
  String get profileEditTabIdentity => 'Identidad';

  @override
  String get profileEditTabPhotos => 'Fotos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Lugar';

  @override
  String get profileEditTabPreferences => 'Preferencias';

  @override
  String get profileMenuTitle => 'MI ESPACIO';

  @override
  String get profileMenuLikesHistory => 'Historial de likes';

  @override
  String get profileMenuVisitors => 'Visitantes de mi perfil';

  @override
  String get profileMenuMatches => 'Mis matches';

  @override
  String get profileMenuSettings => 'Ajustes';

  @override
  String get profileSnackIdentityUpdated => '¡Identidad actualizada!';

  @override
  String get profileLabelUsername => 'NOMBRE DE USUARIO';

  @override
  String get profileUsernameImmutableNote =>
      'El nombre de usuario no se puede modificar aquí.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Cuéntanos sobre ti, tu música...';

  @override
  String get profileLabelGender => 'Género';

  @override
  String get profileLabelPronouns => 'Pronombres';

  @override
  String get profileBtnSave => 'Guardar';

  @override
  String get profileSnackMaxPhotos => 'Máximo 6 fotos';

  @override
  String get profileSnackPhotosUpdated => '¡Fotos actualizadas!';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 fotos';
  }

  @override
  String get profileBadgeNew => 'Nuevo';

  @override
  String get profileBadgePending => 'Pendiente';

  @override
  String get profileBtnAddPhoto => 'Añadir';

  @override
  String get profileSnackTagsUpdated => '¡Tags musicales actualizados!';

  @override
  String get profileSubtitleMusicGenres => 'Tu identidad sonora principal';

  @override
  String get profileSectionMusicVibe => 'Ambiente musical';

  @override
  String get profileSubtitleMusicVibe => 'Lo que sientes al escuchar';

  @override
  String get profileSubtitleAesthetics => 'Tu escena, tu estilo de vida';

  @override
  String get profileSubtitleSoundIntensity => 'La energía de tu música';

  @override
  String get profileSubtitleEra => 'Tu nostalgia generacional';

  @override
  String get profileSubtitleDiscovery => 'Tus hábitos de escucha';

  @override
  String get profileSectionFavoriteBandsCaps => 'ARTISTAS FAVORITOS';

  @override
  String get profileHintBands => 'Un grupo cada vez, ej.: Bauhaus';

  @override
  String get profileSectionSocialLinksCaps => 'ENLACES';

  @override
  String get profileHintSocialLink =>
      'Pega un enlace: Spotify, Instagram, Bandcamp, Discord...';

  @override
  String get profileLinkNotRecognized =>
      'Enlace no reconocido. Aceptados: Spotify, Instagram, Bandcamp, Discord, Last.fm, Tumblr.';

  @override
  String profileLinkWrongPlatform(String platform) {
    return 'Este enlace no corresponde a $platform.';
  }

  @override
  String get profileDiscordConnectPrompt =>
      '¿Conectar tu cuenta de Discord? Tendrás que iniciar sesión y autorizar el acceso en tu navegador.';

  @override
  String profileDiscordConnectedAs(String username) {
    return 'Conectado como $username.';
  }

  @override
  String get profileDiscordBtnConnect => 'Conectar';

  @override
  String get profileDiscordConnectFailed =>
      'No se pudo conectar Discord. Inténtalo de nuevo.';

  @override
  String get profileBandAlreadyAdded => 'Este grupo ya está en tu lista.';

  @override
  String get profileBandNotAllowed => 'Este nombre de grupo no está permitido.';

  @override
  String get profileErrorSelectAddress => 'Selecciona una dirección';

  @override
  String get profileSnackLocationUpdated => '¡Ubicación actualizada!';

  @override
  String get profileSectionLocation => 'UBICACIÓN';

  @override
  String get profileLocationDescription =>
      'Se usa para encontrar perfiles y eventos cerca de ti.';

  @override
  String get profileSnackPreferencesUpdated => '¡Preferencias actualizadas!';

  @override
  String get profileLabelAgeRange => 'FRANJA DE EDAD';

  @override
  String profileAgeYears(int age) {
    return '$age años';
  }

  @override
  String get profileLabelMaxDistance => 'DISTANCIA MÁXIMA';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GÉNERO BUSCADO';
}
