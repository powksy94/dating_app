// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Nocturne';

  @override
  String get commonGenericError => 'Ocorreu um erro, tenta novamente.';

  @override
  String get commonLoadErrorSubtitle =>
      'Verifica a tua ligação e tenta novamente.';

  @override
  String get commonBtnRetry => 'Tentar novamente';

  @override
  String get commonOfflineBanner => 'Sem ligação';

  @override
  String commonStepProgress(int current, int total) {
    return 'Passo $current de $total';
  }

  @override
  String get commonAddressLabel => 'Endereço *';

  @override
  String get commonTotal => 'Total';

  @override
  String commonPageNotFound(String name) {
    return 'Página não encontrada: $name';
  }

  @override
  String commonAgoMinutes(int count) {
    return 'há ${count}min';
  }

  @override
  String commonAgoHours(int count) {
    return 'há ${count}h';
  }

  @override
  String commonAgoDays(int count) {
    return 'há ${count}d';
  }

  @override
  String get commonUnknownError => 'Erro desconhecido';

  @override
  String get commonConnectionRequiredTitle => 'Ligação necessária';

  @override
  String get commonConnectionRequiredBody =>
      'Liga-te à internet para continuar.';

  @override
  String get subscriptionOfflineBody =>
      'Liga-te à internet para ver e gerir as subscrições.';

  @override
  String get eventLoadErrorTitle => 'Não foi possível carregar os eventos';

  @override
  String get profileLoadErrorTitle => 'Não foi possível carregar o teu perfil';

  @override
  String get discoveryFiltersTitle => 'FILTROS DE PESQUISA';

  @override
  String get discoveryFiltersApply => 'Aplicar';

  @override
  String get discoveryFiltersConfirmTitle => 'Aplicar estes filtros?';

  @override
  String get discoveryFiltersConfirmMessage =>
      'O teu feed de descoberta será recarregado com a nova distância e faixa etária.';

  @override
  String get discoveryFiltersConfirmCancel => 'Cancelar';

  @override
  String get commonComingSoon => 'Brevemente';

  @override
  String get commonBtnOk => 'OK';

  @override
  String get commonBtnRemove => 'Remover';

  @override
  String get updateRequiredTitle => 'Atualização necessária';

  @override
  String get updateRequiredBody =>
      'Está disponível uma nova versão do Nocturne. Atualiza a aplicação para continuar.';

  @override
  String get updateRequiredBtn => 'Atualizar';

  @override
  String get eventPaidComingSoonBody =>
      'Os eventos pagos chegarão brevemente. Por agora, podes criar e participar em eventos gratuitos.';

  @override
  String get visitorsTitle => 'VISITANTES';

  @override
  String get visitorsEmptyState => 'Ainda ninguém visitou o teu perfil';

  @override
  String get visitorsPaywallTitle => 'Funcionalidade Nocturne';

  @override
  String get visitorsPaywallDescription =>
      'Vê quem visitou o teu perfil nos últimos 30 dias ao subscreveres o Nocturne ou o Abyssal.';

  @override
  String get visitorsPaywallSheetTitle => 'Visitantes do perfil';

  @override
  String get visitorsPaywallSheetDescription =>
      'Descobre todos os perfis que viram o teu.';

  @override
  String get visitorsBtnUpgrade => 'Subscrever o Nocturne';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biometria não disponível neste dispositivo';

  @override
  String get adminAuthLocalizedReason =>
      'Confirma a tua identidade para aprovar o login de administrador';

  @override
  String get adminAuthErrorBiometricFailed => 'Verificação biométrica falhou';

  @override
  String get adminAuthErrorBiometricGeneric => 'Erro biométrico';

  @override
  String get adminAuthTitle => 'LOGIN DE ADMINISTRADOR';

  @override
  String get adminAuthDescription =>
      'Foi iniciado um pedido de login ao painel de administração a partir de um navegador.';

  @override
  String get adminAuthBiometricRequired => 'Biometria necessária para aprovar';

  @override
  String get adminAuthBtnApprove => 'Aprovar';

  @override
  String get adminAuthBtnDeny => 'Rejeitar';

  @override
  String get adminLockTitle => 'ACESSO BLOQUEADO';

  @override
  String get adminLockSubtitle =>
      'Autentica-te para aceder às ferramentas de administração.';

  @override
  String get adminLockLocalizedReason =>
      'Confirma a tua identidade para aceder às ferramentas de administração';

  @override
  String get adminLockBtnRetry => 'Tentar novamente';

  @override
  String get adminLockBtnCancel => 'Cancelar';

  @override
  String get eventReviewTitle => 'EVENTOS A VALIDAR';

  @override
  String get eventReviewEmpty => 'Nenhum evento pendente';

  @override
  String get eventReviewFree => 'Grátis';

  @override
  String get eventReviewBtnApprove => 'Aprovar';

  @override
  String get eventReviewBtnReject => 'Rejeitar';

  @override
  String get eventReviewApproved => 'Evento aprovado';

  @override
  String get eventReviewRejected => 'Evento rejeitado';

  @override
  String get photoReviewTitle => 'FOTOS A VERIFICAR';

  @override
  String get photoReviewEmpty => 'Nenhuma foto pendente';

  @override
  String get photoReviewBtnApprove => 'Aprovar';

  @override
  String get photoReviewBtnReject => 'Rejeitar';

  @override
  String get photoReviewApproved => 'Foto aprovada';

  @override
  String get photoReviewRejected => 'Foto rejeitada';

  @override
  String get photoReviewDetailTitle => 'Detalhe da foto';

  @override
  String get photoReviewLabelsLabel => 'Elementos detetados';

  @override
  String get photoReviewDateLabel => 'Adicionada em';

  @override
  String profileSnackPhotosPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos em verificação',
      one: '1 foto em verificação',
    );
    return '$_temp0';
  }

  @override
  String profileSnackPhotosAutoRejected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos foram rejeitadas',
      one: '1 foto foi rejeitada',
    );
    return '$_temp0';
  }

  @override
  String get reportReviewTitle => 'DENÚNCIAS A TRATAR';

  @override
  String get reportReviewEmpty => 'Nenhuma denúncia pendente';

  @override
  String get reportReviewReporterLabel => 'Denunciado por';

  @override
  String get reportReviewReasonLabel => 'Motivo';

  @override
  String get reportReviewMessageLabel => 'Mensagem denunciada';

  @override
  String get reportReviewBannedBadge => 'Banido';

  @override
  String get reportReviewTestAccountBadge => 'Conta de teste';

  @override
  String get reportReviewBtnDismiss => 'Descartar';

  @override
  String get reportReviewBtnBan => 'Banir';

  @override
  String get reportReviewBtnUnban => 'Desbanir';

  @override
  String get reportReviewDismissed => 'Denúncia descartada';

  @override
  String get reportReviewBanned => 'Utilizador banido';

  @override
  String get reportReviewUnbanned => 'Utilizador desbanido';

  @override
  String get reportDetailTitle => 'Detalhe da denúncia';

  @override
  String get reportDetailDateLabel => 'Denunciado em';

  @override
  String get homeNavDiscover => 'Descobrir';

  @override
  String get homeNavEvents => 'Eventos';

  @override
  String get homeNavMessages => 'Mensagens';

  @override
  String get homeNavProfile => 'Perfil';

  @override
  String get homeMyProfileTitle => 'O MEU PERFIL';

  @override
  String get onboardingTourSkip => 'Saltar';

  @override
  String get onboardingTourNext => 'Seguinte';

  @override
  String get onboardingTourGetStarted => 'Entrar no Nocturne';

  @override
  String get onboardingTourTitle1 => 'DESLIZA PARA A OBSCURIDADE';

  @override
  String get onboardingTourSubtitle1 =>
      'Desliza por perfis que partilham a tua estética e os teus gostos musicais.';

  @override
  String get onboardingTourTitle2 => 'JUNTA-TE À NOITE';

  @override
  String get onboardingTourSubtitle2 =>
      'Encontra concertos e encontros perto de ti, e junta-te a outros pássaros noturnos.';

  @override
  String get onboardingTourTitle3 => 'ENVIA UMA ELEGIA';

  @override
  String get onboardingTourSubtitle3 =>
      'Quebra o gelo com uma elegia sincera em vez de um simples olá.';

  @override
  String get onboardingTourTitle4 => 'MODELA A TUA SOMBRA';

  @override
  String get onboardingTourSubtitle4 =>
      'Personaliza as tuas fotos, bandas favoritas e links sociais.';

  @override
  String get homeExitConfirmTitle => 'Sair do Nocturne?';

  @override
  String get homeExitConfirmMessage =>
      'Podes voltar quando quiseres, as tuas conversas vão continuar intactas.';

  @override
  String get homeExitConfirmCancel => 'Cancelar';

  @override
  String get homeExitConfirmQuit => 'Sair';

  @override
  String get homeNoProfileTitle => 'Perfil não configurado';

  @override
  String get homeNoProfileDescription =>
      'Cria o teu perfil para apareceres no swipe';

  @override
  String get homeBtnCreateProfile => 'Criar o meu perfil';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Elegia enviada a $username';
  }

  @override
  String get elegieLimitReachedTitle => 'Limite de elegias atingido';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Usaste as tuas $count elegias do dia. Muda para o Nocturne para enviar mais.',
      one: 'Usaste a tua elegia do dia. Muda para o Nocturne para enviar mais.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Elegia para $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'Uma mensagem curta antes de as trevas decidirem';

  @override
  String get elegieHintMessage => 'Escreve a tua mensagem...';

  @override
  String get elegieBtnSend => 'Enviar a elegia';

  @override
  String get elegieBannerDescription =>
      'Muda para o Nocturne para enviar mais elegias.';

  @override
  String get elegieBtnUpgrade => 'Mudar para o Nocturne';

  @override
  String get periodWeek => 'semana';

  @override
  String get periodMonth => 'mês';

  @override
  String get periodYear => 'ano';

  @override
  String get subscriptionRestoreCta => 'Restaurar as minhas compras';

  @override
  String get subscriptionRestoreSuccess => 'Compras restauradas!';

  @override
  String get subscriptionRestoreEmpty => 'Não há compras para restaurar.';

  @override
  String get subscriptionBtnSwitchToFree => 'Mudar para o plano gratuito';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Plano atual';

  @override
  String get subscriptionBtnChangePeriod => 'Mudar o período';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return 'Escolher $planName';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ Subscrição $planName ativada!';
  }

  @override
  String get subscriptionSnackError => 'Erro, tenta novamente.';

  @override
  String get subscriptionSnackCancelled => 'Subscrição cancelada.';

  @override
  String get subscriptionCancelSubscription => 'Cancelar a subscrição';

  @override
  String get subscriptionCancelAnytimeNote =>
      'Podes cancelar em qualquer momento';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return 'Subscrever $planName';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Cancelar';

  @override
  String get subscriptionBtnDialogConfirm => 'Confirmar';

  @override
  String get subscriptionDialogCancelBody =>
      'Vais perder o acesso às funcionalidades premium.';

  @override
  String get subscriptionBtnKeep => 'Manter';

  @override
  String get subscriptionBtnConfirmCancel => 'Cancelar';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle => 'Junta-te às trevas sem limites';

  @override
  String get subscriptionPaywallBtnViewPlans => 'Ver as subscrições';

  @override
  String get subscriptionPaywallBtnNotNow => 'Agora não';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Disponível a partir de $planName';
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
  String get subscriptionPriceFree => 'Grátis';

  @override
  String get subscriptionPriceUnavailable => 'Preço não disponível';

  @override
  String get subscriptionBtnRetry => 'Tentar novamente';

  @override
  String get featureOmbreSwipes => '30 swipes por dia';

  @override
  String get featureOmbreElegies => '3 elegias por mês';

  @override
  String get featureOmbreEvents => '2 eventos por mês';

  @override
  String get featureOmbrePhotos => '2 fotos por perfil';

  @override
  String get featureWhoLikedMe => 'Ver quem te deu like';

  @override
  String get featureWhoVisited => 'Quem visitou o teu perfil';

  @override
  String get featureRewind => 'Rewind (desfazer um swipe)';

  @override
  String get featureBoostGeneric => 'Boost de perfil';

  @override
  String get featureUnlimitedSwipe => 'Swipe ilimitado';

  @override
  String get featureNocturneElegies => '15 elegias por mês';

  @override
  String get featureNocturneEvents => '4 eventos por mês';

  @override
  String get featurePhotos6 => '6 fotos por perfil';

  @override
  String get featureBoostMonthly => '1 boost por mês';

  @override
  String get featureUnlimitedElegies => 'Elegias ilimitadas';

  @override
  String get featureUnlimitedEvents => 'Eventos ilimitados';

  @override
  String get featureBoostWeekly => '1 boost por semana';

  @override
  String get socialBtnReport => 'Denunciar';

  @override
  String get socialBtnBlock => 'Bloquear';

  @override
  String socialDialogBlockBody(String username) {
    return 'Bloquear $username? O teu match vai ser eliminado.';
  }

  @override
  String get socialBtnCancel => 'Cancelar';

  @override
  String get reportCategoryHarassment => 'Assédio';

  @override
  String get reportSubHarassmentTargeted => 'Isto visa-me pessoalmente';

  @override
  String get reportSubHarassmentThreatening => 'Comportamento ameaçador';

  @override
  String get reportSubHarassmentRepeated => 'Mensagens indesejadas repetidas';

  @override
  String get reportCategoryFakeProfile => 'Perfil falso';

  @override
  String get reportSubFakeStolenPhotos => 'Fotos roubadas';

  @override
  String get reportSubFakeImpersonation => 'Usurpação de identidade';

  @override
  String get reportSubFakeGhost => 'Conta fantasma';

  @override
  String get reportCategoryNonConsensualSexual =>
      'Conteúdo sexual não consentido';

  @override
  String get reportCategorySpam => 'Spam ou fraude';

  @override
  String get reportCategoryMinor => 'Menor de idade';

  @override
  String get reportCategoryHateSpeech => 'Discurso de ódio ou discriminatório';

  @override
  String get reportCategoryOther => 'Outro';

  @override
  String socialReportHeaderTitle(String username) {
    return 'Denunciar $username';
  }

  @override
  String get socialReportRootQuestion =>
      'Porque é que estás a denunciar este perfil?';

  @override
  String get socialReportRootQuestionMessage =>
      'Porque é que estás a denunciar esta mensagem?';

  @override
  String get socialReportHint => 'Descreve o problema...';

  @override
  String get socialBtnSendReport => 'Enviar a denúncia';

  @override
  String get socialReportSentTitle => 'Denúncia enviada';

  @override
  String get socialReportSentBody =>
      'Obrigado. A nossa equipa vai analisar esta denúncia.';

  @override
  String get socialBtnClose => 'Fechar';

  @override
  String get chatReplyPhoto => 'Foto';

  @override
  String get chatMessageDeleted => 'Mensagem eliminada';

  @override
  String get chatMessageUnderReview => 'Denúncia em verificação';

  @override
  String get chatStatusRead => 'Lida';

  @override
  String get chatStatusSent => 'Enviada';

  @override
  String get chatListTitle => 'MENSAGENS';

  @override
  String get chatTabChats => 'CONVERSAS';

  @override
  String get chatTabElegiesReceived => 'ELEGIAS RECEBIDAS';

  @override
  String get chatTabElegiesSent => 'ELEGIAS ENVIADAS';

  @override
  String get chatEmptyMatchesTitle => 'Ainda nenhum match...';

  @override
  String get chatEmptyMatchesSub => 'Continua a explorar as trevas';

  @override
  String get giftRevealHint => 'Toca no selo para o abrir';

  @override
  String get giftRevealTitle => 'DOIS MESES DE NOCTURNE';

  @override
  String get giftRevealSubtitle =>
      'Um presente para as primeiras cinquenta almas que se atreveram a entrar 🌙';

  @override
  String get giftRevealClose => 'Continuar';

  @override
  String get giftRevealErrorTitle => 'A cera não quis ceder';

  @override
  String get giftRevealErrorSubtitle => 'Ocorreu um erro. Tenta novamente.';

  @override
  String get giftRevealRetry => 'Tentar novamente';

  @override
  String get matchTitleBond => 'UM VÍNCULO OBSCURO';

  @override
  String get matchTitleBorn => 'NASCEU';

  @override
  String get matchTitleElegie => 'A TUA ELEGIA FOI OUVIDA';

  @override
  String get matchSubtitleElegie => 'As trevas atenderam à tua súplica';

  @override
  String matchSubtitleBond(String username) {
    return 'Tu & $username estão ligados pelas trevas';
  }

  @override
  String get matchBtnMessage => 'ENVIAR UMA MENSAGEM';

  @override
  String get matchBtnKeepExploring => 'Continuar a explorar';

  @override
  String get matchAvatarYou => 'Tu';

  @override
  String get matchesTileSubtitle => 'Ligados pelas trevas';

  @override
  String get matchesBtnMessage => 'Mensagem';

  @override
  String get chatOpenErrorTitle => 'Não foi possível abrir a conversa';

  @override
  String get commonBtnCancel => 'Cancelar';

  @override
  String get commonBtnSend => 'Enviar';

  @override
  String get starterCardTitle => 'Para quebrar o gelo';

  @override
  String get starterConfirmTitle => 'Enviar esta mensagem?';

  @override
  String get starterNoCommonDialog =>
      'Os vossos perfis não têm nenhuma tag em comum, mas gostaram um do outro da mesma forma. Aqui tens algumas ideias para começar a conversa.';

  @override
  String get starterToggleClassic => 'Ideias clássicas';

  @override
  String get starterToggleShared => 'Com base nos vossos pontos em comum';

  @override
  String starterHookShared(String tag) {
    return 'Têm $tag em comum.';
  }

  @override
  String starterHookRare(String tag) {
    return 'Poucos perfis têm $tag, e vocês os dois fazem parte deles.';
  }

  @override
  String starterHookCombo(String tag1, String tag2) {
    return 'Têm $tag1 e $tag2 em comum.';
  }

  @override
  String starterHookBand(String band) {
    return 'Ambos gostam de $band.';
  }

  @override
  String starterHookEvent(String event) {
    return 'Ambos participam no evento $event.';
  }

  @override
  String get starterHookMood => 'Identificam-se com o mesmo ambiente musical.';

  @override
  String starterHookOtherBand(String band) {
    return 'Esta pessoa gosta de $band.';
  }

  @override
  String starterMsgGenre1(String tag) {
    return 'Estou mesmo na fase $tag agora. E tu, que música tens em repetição?';
  }

  @override
  String starterMsgGenre2(String tag) {
    return 'Qual foi a primeira banda de $tag que te fez entrar de cabeça nisto?';
  }

  @override
  String starterMsgGenre3(String tag) {
    return 'Se só pudesse ouvir um álbum de $tag esta semana, qual me recomendarias?';
  }

  @override
  String starterMsgVibe1(String tag) {
    return 'Se a tua playlist $tag fosse a banda sonora de um filme, qual seria?';
  }

  @override
  String starterMsgVibe2(String tag) {
    return 'Que música te põe logo no ambiente $tag?';
  }

  @override
  String get starterMsgVibeSensitive =>
      'Que música te acompanha nesses momentos?';

  @override
  String starterMsgAesthetic1(String tag) {
    return 'O teu universo $tag, por onde começa: a roupa, o quarto, as capas dos discos?';
  }

  @override
  String starterMsgIntensity1(String tag) {
    return 'Em termos de intensidade $tag, que música te representa melhor?';
  }

  @override
  String starterMsgEra1(String tag) {
    return 'Que disco da época $tag levarias para uma ilha deserta?';
  }

  @override
  String get starterMsgFormatConcerts =>
      'O último concerto que te marcou, e o pior também?';

  @override
  String get starterMsgFormatVinyl =>
      'A peça da tua coleção que mais significa para ti?';

  @override
  String get starterMsgFormatBandcamp =>
      'A tua última descoberta no Bandcamp? Ando à procura de algo para a minha próxima sessão de escuta.';

  @override
  String get starterMsgFormatPlaylist =>
      'Uma playlist que ouves sem parar? Manda-me o link.';

  @override
  String get starterMsgFormatUnderground =>
      'Algum lugar pequeno ou cena local que mereça ser mais conhecida, onde vives?';

  @override
  String starterMsgBand1(String band) {
    return 'O teu álbum preferido de $band, e aquele que defendes mesmo a dividir opiniões?';
  }

  @override
  String get starterMsgEvent1 => 'O que esperas mais deste evento?';

  @override
  String starterMsgOtherBand1(String band) {
    return 'Vi que gostas de $band. Qual é o teu álbum preferido?';
  }

  @override
  String starterMsgCombo1(String tag1, String tag2) {
    return '$tag1 e $tag2, parece a noite perfeita. Com que música a começarias?';
  }

  @override
  String get starterFallback1 =>
      'O último álbum que ouviste do princípio ao fim?';

  @override
  String get starterFallback2 =>
      'Se a tua playlist do momento fosse um filme, como se chamaria?';

  @override
  String get starterFallback3 =>
      'Uma banda que defendes mesmo que ninguém entenda?';

  @override
  String get starterFallback4 =>
      'Uma música que sempre te emociona, mesmo depois de cem audições?';

  @override
  String get starterFallback5 =>
      'Um concerto de sonho, e a tua pior lembrança de concerto?';

  @override
  String get starterFallback6 =>
      'Desafio: cada um manda uma música que o outro provavelmente não conhece. Combinado?';

  @override
  String get chatEmptyElegiesReceivedTitle => 'Nenhuma elegia recebida';

  @override
  String get chatEmptyElegiesReceivedSub =>
      'Alguém vai pensar em ti brevemente...';

  @override
  String get chatEmptyElegiesSentTitle => 'Nenhuma elegia enviada';

  @override
  String get chatEmptyElegiesSentSub => 'Atreve-te a quebrar o silêncio...';

  @override
  String get chatMessageBlockedContactInfo =>
      'Para a tua segurança, links e números de telefone não são permitidos enquanto a outra pessoa não responder.';

  @override
  String get chatNewMatch => 'Novo match';

  @override
  String get chatElegiePending => 'Pendente';

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
  String get chatTyping => 'a escrever...';

  @override
  String get chatInputHint => 'Mensagem...';

  @override
  String get chatEmojiHint => 'Escolhe um emoji...';

  @override
  String get chatBtnReportMessage => 'Denunciar esta mensagem';

  @override
  String get chatBtnDeleteForMe => 'Eliminar para mim';

  @override
  String get chatBtnDeleteForAll => 'Eliminar para todos';

  @override
  String get chatLastSeenJustNow => 'visto agora mesmo';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'visto há $count min';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'visto há $count h';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'visto há $count d';
  }

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'Nenhum perfil por aqui...';

  @override
  String get discoveryEmptySubtitle =>
      'Já viste todos os perfis disponíveis por agora.';

  @override
  String get discoveryEmptyResetLikes => 'Repor os teus likes';

  @override
  String get discoveryEmptyEditFilters => 'Editar os teus filtros de pesquisa';

  @override
  String get discoveryEmptyWaitMoon => 'Esperar por uma lua nova';

  @override
  String get discoveryEmptyResetSuccess =>
      'Os teus likes foram repostos, os perfis voltam a aparecer no feed.';

  @override
  String get discoveryEmptyWaitMoonMessage =>
      'Novos perfis chegam com a lua nova. Volta brevemente.';

  @override
  String get discoveryLoadErrorTitle => 'Não foi possível carregar os perfis';

  @override
  String get discoveryLoadErrorSubtitle =>
      'Verifica a tua ligação e tenta novamente.';

  @override
  String get discoveryBtnRetry => 'Tentar novamente';

  @override
  String get discoveryBoostActivated =>
      'Boost ativado! O teu perfil fica em destaque durante 30 minutos.';

  @override
  String get discoveryRewindTitle => 'Rewind não disponível';

  @override
  String get discoveryRewindBody =>
      'O rewind está disponível a partir do plano Nocturne.';

  @override
  String get discoveryBoostTitle => 'Boost não disponível';

  @override
  String get discoveryBoostBody =>
      'O boost está disponível a partir do plano Nocturne (1/mês) ou Abyssal (1/semana).';

  @override
  String get discoverySwipeLimitTitle => 'Limite de swipes atingido';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'Usaste os teus $count swipes do dia. Muda para o Nocturne para swipares sem limite.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit swipes hoje';
  }

  @override
  String get discoveryBtnElegie => 'Elegia';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'Os meus likes';

  @override
  String get discoveryTabWhoLikedMe => 'Quem me deu like';

  @override
  String get discoveryEmptyMyLikes => 'Nenhum like por agora';

  @override
  String get discoveryEmptyWhoLikedMe => 'Ainda ninguém deu like ao teu perfil';

  @override
  String get discoveryPaywallTitle => 'Funcionalidade Nocturne';

  @override
  String get discoveryPaywallDescription =>
      'Descobre quem deu like ao teu perfil ao mudares para o Nocturne ou o Abyssal.';

  @override
  String get discoveryPaywallSheetTitle => 'Quem me deu like';

  @override
  String get discoveryPaywallSheetDescription =>
      'Descobre todos os perfis que deram like ao teu.';

  @override
  String get discoveryBtnUpgrade => 'Mudar para o Nocturne';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Email ou palavra-passe incorretos.';

  @override
  String get authLabelEmail => 'Email';

  @override
  String get authLabelPassword => 'Palavra-passe';

  @override
  String get authBtnLogin => 'Entrar';

  @override
  String get authBtnGoToRegister => 'Ainda não tens conta? Criar uma conta';

  @override
  String get authBtnForgotPassword => 'Esqueceste-te da palavra-passe?';

  @override
  String get authForgotTitle => 'Palavra-passe esquecida';

  @override
  String get authForgotSubtitle =>
      'Introduz o teu email, vamos enviar-te um código de 6 dígitos.';

  @override
  String get authBtnSendCode => 'Enviar o código';

  @override
  String get authForgotSentMessage =>
      'Se existir uma conta com este email, foi enviado um código.';

  @override
  String get authVerifyCodeTitle => 'Verificar o código';

  @override
  String get authVerifyCodeSubtitle =>
      'Introduz o código de 6 dígitos recebido por email.';

  @override
  String get authBtnVerifyCode => 'Verificar';

  @override
  String get authResetTitle => 'Redefinir a palavra-passe';

  @override
  String get authResetSubtitle => 'Escolhe a tua nova palavra-passe.';

  @override
  String get authLabelResetCode => 'Código de 6 dígitos';

  @override
  String get authLabelNewPassword => 'Nova palavra-passe';

  @override
  String get authBtnResetPassword => 'Redefinir';

  @override
  String get authResetSuccessMessage =>
      'Palavra-passe redefinida. Entra com a tua nova palavra-passe.';

  @override
  String get authWelcomeTitle => 'BEM-VINDO/A';

  @override
  String get authWelcomeSubtitle => 'às trevas';

  @override
  String get authLabelUsername => 'Nome de utilizador';

  @override
  String get authErrorFillAllFields => 'Preenche todos os campos.';

  @override
  String get authErrorInvalidEmail => 'Email inválido.';

  @override
  String get authErrorPasswordTooShort =>
      'Palavra-passe: mínimo de 12 carateres.';

  @override
  String get authErrorPasswordMismatch => 'As palavras-passe não coincidem.';

  @override
  String get authStepCredentialsTitle => 'Bem-vindo/a às \ntrevas 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Cria a tua conta para te juntares ao Nocturne.';

  @override
  String get authHelperPasswordMin => 'Mínimo de 12 carateres';

  @override
  String get authLabelConfirmPassword => 'Confirmar a palavra-passe';

  @override
  String get authBtnContinue => 'Continuar';

  @override
  String get authLabelBirthDate => 'Data de nascimento';

  @override
  String get authErrorUsernameInvalid =>
      'Escolhe um nome de utilizador válido e disponível.';

  @override
  String get authStepIdentityTitle => 'Quem és tu?';

  @override
  String get authStepIdentitySubtitle =>
      'Esta informação não vai poder ser alterada facilmente.';

  @override
  String get authLabelGender => 'Género';

  @override
  String get authLabelPronouns => 'Pronomes';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Fala sobre ti, a tua música, o teu universo...';

  @override
  String get authOther => 'Outro';

  @override
  String get authGenderMale => 'Homem';

  @override
  String get authGenderFemale => 'Mulher';

  @override
  String get authGenderNonBinary => 'Não binário';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agénero';

  @override
  String get authGenderTransmasculine => 'Transmasculino';

  @override
  String get authGenderTransfeminine => 'Transfeminino';

  @override
  String get authGenderAll => 'Todos';

  @override
  String get authPronounHeHim => 'Ele/ele';

  @override
  String get authPronounSheHer => 'Ela/ela';

  @override
  String get authPronounTheyThem => 'Elu/elu';

  @override
  String get authPronounPluralNeutral => 'Elus/elus';

  @override
  String get authLabelSpecify => 'Especifica...';

  @override
  String get authErrorSelectPreference =>
      'Seleciona pelo menos uma preferência.';

  @override
  String get authStepPreferencesTitle => 'As tuas preferências';

  @override
  String get authStepPreferencesSubtitle => 'Quem queres conhecer?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Faixa etária: $min - $max anos';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Distância máxima: $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Género(s) procurado(s)';

  @override
  String get authBtnCreateAccount => 'Criar a minha conta';

  @override
  String get authStepVerifyEmailTitle => 'Verifica o teu email';

  @override
  String authStepVerifyEmailSubtitle(String email) {
    return 'Introduz o código de 6 dígitos enviado para $email';
  }

  @override
  String get authLabelVerificationCode => 'Código de 6 dígitos';

  @override
  String get authBtnVerifyEmail => 'Verificar';

  @override
  String get authBtnResendVerificationCode => 'Reenviar o código';

  @override
  String get authVerifyEmailResentMessage => 'Foi enviado um novo código.';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Seleciona pelo menos um género e uma estética.';

  @override
  String get authStepTagsTitle => 'O teu universo musical';

  @override
  String get authStepTagsSubtitle =>
      'Estas tags servem para te associar a perfis compatíveis.';

  @override
  String get authSectionMusicGenres => 'Géneros musicais';

  @override
  String get authSectionMusicVibes => 'Ambiente musical';

  @override
  String get authSectionAesthetics => 'Estética';

  @override
  String get authSectionSoundIntensity => 'Intensidade sonora';

  @override
  String get authSectionMusicEras => 'Época';

  @override
  String get authSectionDiscoveryFormats => 'Descoberta musical';

  @override
  String get authSectionFavoriteBands =>
      'Bandas / Artistas favoritos (opcional)';

  @override
  String get authHintBands => 'Uma banda de cada vez, ex.: The Cure';

  @override
  String get bandSearchAttribution => 'Resultados via Spotify';

  @override
  String get authLocationPermissionDenied =>
      'Permissão negada. Podes saltar este passo';

  @override
  String get authLocationError =>
      'Não foi possível obter a localização. Podes saltar este passo.';

  @override
  String get authStepLocationTitle => 'A tua localização';

  @override
  String get authStepLocationSubtitle =>
      'Para te mostrar perfis perto de ti. Podes saltar este passo.';

  @override
  String get authLocationSaved => 'Localização guardada ✓';

  @override
  String get authBtnAllowLocation => 'Permitir a localização';

  @override
  String get authBtnSkipStep => 'Saltar este passo';

  @override
  String get authErrorAddPhoto => 'Adiciona pelo menos uma foto.';

  @override
  String get authStepPhotosTitle => 'As tuas fotos';

  @override
  String get authStepPhotosSubtitle =>
      'Adiciona até 6 fotos. A primeira será a tua foto principal.';

  @override
  String get authBadgeMain => 'Principal';

  @override
  String get settingsTitle => 'DEFINIÇÕES';

  @override
  String get settingsSectionAccount => 'Conta';

  @override
  String get settingsBtnEditProfile => 'Editar o meu perfil';

  @override
  String get settingsBtnChangePassword => 'Alterar a palavra-passe';

  @override
  String get settingsBtnLogout => 'Terminar sessão';

  @override
  String get settingsBtnDeleteAccount => 'Eliminar a conta';

  @override
  String get settingsLabelMaxDistance => 'Distância máxima';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Faixa etária';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max anos';
  }

  @override
  String get settingsSectionNotifications => 'Notificações';

  @override
  String get settingsNotifMatches => 'Novos matches';

  @override
  String get settingsNotifMessages => 'Novas mensagens';

  @override
  String get settingsNotifElegies => 'Elegias recebidas';

  @override
  String get settingsSectionPrivacy => 'Privacidade';

  @override
  String get settingsPrivacyVisible => 'Perfil visível no swipe';

  @override
  String get settingsSectionAbout => 'Sobre';

  @override
  String get settingsVersionLabel => 'Versão';

  @override
  String get settingsTermsOfService => 'Termos de utilização';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidade';

  @override
  String get settingsRateApp => 'Avaliar a aplicação';

  @override
  String get settingsSectionAdmin => 'Administração';

  @override
  String get settingsAdminReports => 'Denúncias';

  @override
  String get settingsAdminPhotos => 'Fotos';

  @override
  String get settingsDeleteAccountWarning =>
      'Esta ação é irreversível.\nEscreve o teu nome de utilizador para confirmar.';

  @override
  String get settingsBtnCancel => 'Cancelar';

  @override
  String get settingsBtnDeleteForever => 'Eliminar definitivamente';

  @override
  String get settingsErrorAllFieldsRequired =>
      'Todos os campos são obrigatórios';

  @override
  String get settingsErrorPasswordMismatch => 'As palavras-passe não coincidem';

  @override
  String get settingsErrorPasswordMin => 'Mínimo de 12 carateres';

  @override
  String get settingsLabelCurrentPassword => 'Palavra-passe atual';

  @override
  String get settingsLabelNewPassword => 'Nova palavra-passe';

  @override
  String get settingsLabelConfirmNewPassword => 'Confirmar a nova';

  @override
  String get settingsBtnConfirm => 'Confirmar';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date às $time';
  }

  @override
  String get eventPageTitle => 'EVENTOS';

  @override
  String get eventLabelMaxDistance => 'Distância máxima';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Géneros';

  @override
  String get eventFilterAllGenres => 'Todos os géneros';

  @override
  String get eventFilterMyGenres => 'Os meus géneros';

  @override
  String get eventEmptyZone => 'Nenhum evento na tua zona';

  @override
  String get eventEmptyCategory => 'Nenhum evento nesta categoria';

  @override
  String get eventSubmittedForModeration => 'Evento enviado para moderação';

  @override
  String get eventLimitTitle => 'Limite de eventos atingido';

  @override
  String eventLimitBody(int count) {
    return 'Usaste as tuas $count inscrições em eventos este mês. Muda para o Nocturne para 4/mês ou o Abyssal para ilimitado.';
  }

  @override
  String get eventUnregisterConfirmed => 'Cancelamento confirmado';

  @override
  String get eventRegisterConfirmed => 'Inscrição confirmada!';

  @override
  String get eventSectionDescription => 'DESCRIÇÃO';

  @override
  String get eventSectionParticipants => 'PARTICIPANTES';

  @override
  String get eventBtnUnregisterLong => 'Inscrito ✓ — Cancelar inscrição';

  @override
  String get eventPriceFree => 'Grátis';

  @override
  String get eventBadgeRegistered => 'Inscrito ✓';

  @override
  String get eventBtnRegister => 'Inscrever-me';

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
    return '$name1 e $name2 participam';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: 'mais $extra pessoas',
      one: 'mais 1 pessoa',
    );
    return '$names e $_temp0 participam';
  }

  @override
  String get eventErrorTitleDescRequired => 'Título e descrição obrigatórios';

  @override
  String get eventStepCoverTitle => 'Apresenta o teu evento';

  @override
  String get eventStepCoverSubtitle => 'Foto, título e descrição';

  @override
  String get eventBtnAddCoverPhoto => 'Adicionar uma foto de capa';

  @override
  String get eventLabelTitleRequired => 'Título *';

  @override
  String get eventLabelDescriptionRequired => 'Descrição *';

  @override
  String get eventBtnContinue => 'Continuar';

  @override
  String get eventErrorDateRequired => 'Escolhe uma data e uma hora';

  @override
  String get eventStepDatetimeTitle => 'Quando é o evento?';

  @override
  String get eventStepDatetimeSubtitle => 'Data e hora de início';

  @override
  String get eventBtnPickDateTime => 'Escolher data e hora';

  @override
  String get eventErrorAddressRequired => 'Seleciona um endereço da lista';

  @override
  String get eventStepLocationTitle => 'Onde é que ele acontece?';

  @override
  String get eventStepLocationSubtitle => 'Procura o endereço do local';

  @override
  String get eventStepGenresTitle => 'Géneros musicais';

  @override
  String get eventStepGenresSubtitle => 'Seleciona os géneros do evento';

  @override
  String get eventErrorCapacityInvalid =>
      'Introduz uma capacidade válida (mín. 1)';

  @override
  String get eventErrorCapacityMaxMin =>
      'O máximo tem de ser maior do que o mínimo';

  @override
  String get eventStepCapacityTitle => 'Quantos lugares?';

  @override
  String get eventStepCapacitySubtitle => 'Capacidade máxima do evento';

  @override
  String get eventToggleExactNumber => 'Número exato';

  @override
  String get eventToggleRange => 'Intervalo';

  @override
  String get eventLabelExactPlaces => 'Número de lugares *';

  @override
  String get eventLabelMin => 'Mín. *';

  @override
  String get eventLabelMax => 'Máx. *';

  @override
  String get eventErrorPriceInvalid => 'Introduz um preço válido';

  @override
  String get eventStepPriceTitle => 'Qual é o preço?';

  @override
  String get eventStepPriceSubtitle => 'Último passo antes de submeter';

  @override
  String get eventTogglePaid => 'Pago';

  @override
  String get eventLabelPriceRequired => 'Preço *';

  @override
  String get eventBtnSubmit => 'Submeter o evento';

  @override
  String get eventFilterAll => 'Todos';

  @override
  String get eventFilterAttending => 'Inscritos';

  @override
  String get eventFilterMatches => 'Os meus matches';

  @override
  String get eventFilterFavorites => 'Favoritos';

  @override
  String get eventSheetUnregisterTitle => 'Cancelar a inscrição no evento';

  @override
  String get eventSheetRegisterTitle => 'Confirmar a inscrição';

  @override
  String get eventBtnConfirmUnregister => 'Confirmar o cancelamento';

  @override
  String get eventBtnConfirmRegister => 'Eu participo!';

  @override
  String get eventPaymentSheetTitle => 'Confirma o teu bilhete';

  @override
  String eventPaymentBtn(String amount) {
    return 'Pagar $amount €';
  }

  @override
  String get eventPaymentError => 'O pagamento falhou, tenta novamente.';

  @override
  String get eventBtnCancel => 'Cancelar';

  @override
  String get eventSectionInfo => 'INFO';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max lugares';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min lugares',
      one: '1 lugar',
    );
    return '$_temp0';
  }

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Géneros musicais';

  @override
  String get profileSectionVibe => 'Ambiente';

  @override
  String get profileSectionAesthetics => 'Estética e cultura';

  @override
  String get profileSectionSoundIntensity => 'Intensidade sonora';

  @override
  String get profileSectionEra => 'Época / cena';

  @override
  String get profileSectionDiscovery => 'Descoberta musical';

  @override
  String get profileSectionFavoriteBands => 'Artistas favoritos';

  @override
  String get profileSectionUpcomingEvents => 'Próximos eventos';

  @override
  String get profileSectionLinks => 'Links';

  @override
  String get profileSectionPhotos => 'FOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Desbloquear com o Premium';

  @override
  String get profileEditTitle => 'EDITAR O MEU PERFIL';

  @override
  String get profileEditTabIdentity => 'Identidade';

  @override
  String get profileEditTabPhotos => 'Fotos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Localização';

  @override
  String get profileEditTabPreferences => 'Preferências';

  @override
  String get profileMenuTitle => 'O MEU ESPAÇO';

  @override
  String get profileMenuLikesHistory => 'Histórico de likes';

  @override
  String get profileMenuVisitors => 'Visitantes do meu perfil';

  @override
  String get profileMenuMatches => 'Os meus matches';

  @override
  String get profileMenuSettings => 'Definições';

  @override
  String get profileSnackIdentityUpdated => 'Identidade atualizada!';

  @override
  String get profileLabelUsername => 'NOME DE UTILIZADOR';

  @override
  String get profileUsernameImmutableNote =>
      'O nome de utilizador não pode ser alterado aqui.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Fala sobre ti, a tua música...';

  @override
  String get profileLabelGender => 'Género';

  @override
  String get profileLabelPronouns => 'Pronomes';

  @override
  String get profileBtnSave => 'Guardar';

  @override
  String get profileSnackMaxPhotos => 'Máximo de 6 fotos';

  @override
  String get profileSnackPhotosUpdated => 'Fotos atualizadas!';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 fotos';
  }

  @override
  String get profileBadgeNew => 'Novo';

  @override
  String get profileBadgePending => 'Pendente';

  @override
  String get profileBtnAddPhoto => 'Adicionar';

  @override
  String get profileSnackTagsUpdated => 'Tags musicais atualizadas!';

  @override
  String get profileSubtitleMusicGenres => 'A tua identidade sonora principal';

  @override
  String get profileSectionMusicVibe => 'Ambiente musical';

  @override
  String get profileSubtitleMusicVibe => 'O que sentes ao ouvir';

  @override
  String get profileSubtitleAesthetics => 'A tua cena, o teu estilo de vida';

  @override
  String get profileSubtitleSoundIntensity => 'A energia da tua música';

  @override
  String get profileSubtitleEra => 'A tua nostalgia geracional';

  @override
  String get profileSubtitleDiscovery => 'Os teus hábitos de escuta';

  @override
  String get profileSectionFavoriteBandsCaps => 'ARTISTAS FAVORITOS';

  @override
  String get profileHintBands => 'Uma banda de cada vez, ex.: Bauhaus';

  @override
  String get profileSectionSocialLinksCaps => 'LINKS';

  @override
  String get profileHintSocialLink =>
      'Cola um link: Spotify, Instagram, Bandcamp, Discord...';

  @override
  String get profileLinkNotRecognized =>
      'Link não reconhecido. Aceites: Spotify, Instagram, Bandcamp, Discord, Last.fm, Tumblr.';

  @override
  String profileLinkWrongPlatform(String platform) {
    return 'Este link não corresponde a $platform.';
  }

  @override
  String get profileDiscordConnectPrompt =>
      'Ligar a tua conta do Discord? Vais ter de iniciar sessão e autorizar o acesso no teu navegador.';

  @override
  String profileDiscordConnectedAs(String username) {
    return 'Ligado como $username.';
  }

  @override
  String get profileDiscordBtnConnect => 'Ligar';

  @override
  String get profileDiscordConnectFailed =>
      'Não foi possível ligar ao Discord. Tenta novamente.';

  @override
  String get profileBandAlreadyAdded => 'Esta banda já está na tua lista.';

  @override
  String get profileBandNotAllowed => 'Este nome de banda não é permitido.';

  @override
  String get profileErrorSelectAddress => 'Seleciona um endereço';

  @override
  String get profileSnackLocationUpdated => 'Localização atualizada!';

  @override
  String get profileSectionLocation => 'LOCALIZAÇÃO';

  @override
  String get profileLocationDescription =>
      'Utilizada para encontrar perfis e eventos perto de ti.';

  @override
  String get profileSnackPreferencesUpdated => 'Preferências atualizadas!';

  @override
  String get profileLabelAgeRange => 'FAIXA ETÁRIA';

  @override
  String profileAgeYears(int age) {
    return '$age anos';
  }

  @override
  String get profileLabelMaxDistance => 'DISTÂNCIA MÁXIMA';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GÉNERO PROCURADO';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Nocturne';

  @override
  String get commonGenericError => 'Ocorreu um erro, tente novamente.';

  @override
  String get commonLoadErrorSubtitle =>
      'Verifique sua conexão e tente novamente.';

  @override
  String get commonBtnRetry => 'Tentar novamente';

  @override
  String get commonOfflineBanner => 'Sem conexão';

  @override
  String commonStepProgress(int current, int total) {
    return 'Etapa $current de $total';
  }

  @override
  String get commonAddressLabel => 'Endereço *';

  @override
  String get commonTotal => 'Total';

  @override
  String commonPageNotFound(String name) {
    return 'Página não encontrada: $name';
  }

  @override
  String commonAgoMinutes(int count) {
    return 'há ${count}min';
  }

  @override
  String commonAgoHours(int count) {
    return 'há ${count}h';
  }

  @override
  String commonAgoDays(int count) {
    return 'há ${count}d';
  }

  @override
  String get commonUnknownError => 'Erro desconhecido';

  @override
  String get commonConnectionRequiredTitle => 'Conexão necessária';

  @override
  String get commonConnectionRequiredBody =>
      'Conecte-se à internet para continuar.';

  @override
  String get subscriptionOfflineBody =>
      'Conecte-se à internet para ver e gerenciar as assinaturas.';

  @override
  String get eventLoadErrorTitle => 'Não foi possível carregar os eventos';

  @override
  String get profileLoadErrorTitle => 'Não foi possível carregar seu perfil';

  @override
  String get discoveryFiltersTitle => 'FILTROS DE BUSCA';

  @override
  String get discoveryFiltersApply => 'Aplicar';

  @override
  String get discoveryFiltersConfirmTitle => 'Aplicar estes filtros?';

  @override
  String get discoveryFiltersConfirmMessage =>
      'Seu feed de descoberta será recarregado com a nova distância e faixa de idade.';

  @override
  String get discoveryFiltersConfirmCancel => 'Cancelar';

  @override
  String get commonComingSoon => 'Em breve';

  @override
  String get commonBtnOk => 'OK';

  @override
  String get commonBtnRemove => 'Remover';

  @override
  String get updateRequiredTitle => 'Atualização necessária';

  @override
  String get updateRequiredBody =>
      'Uma nova versão do Nocturne está disponível. Atualize o aplicativo para continuar.';

  @override
  String get updateRequiredBtn => 'Atualizar';

  @override
  String get eventPaidComingSoonBody =>
      'Eventos pagos chegarão em breve. Por enquanto, você pode criar e participar de eventos gratuitos.';

  @override
  String get visitorsTitle => 'VISITANTES';

  @override
  String get visitorsEmptyState => 'Ainda ninguém visitou seu perfil';

  @override
  String get visitorsPaywallTitle => 'Recurso Nocturne';

  @override
  String get visitorsPaywallDescription =>
      'Veja quem visitou seu perfil nos últimos 30 dias ao assinar Nocturne ou Abyssal.';

  @override
  String get visitorsPaywallSheetTitle => 'Visitantes do perfil';

  @override
  String get visitorsPaywallSheetDescription =>
      'Descubra todos os perfis que viram o seu.';

  @override
  String get visitorsBtnUpgrade => 'Assinar Nocturne';

  @override
  String get adminAuthErrorBiometricUnavailable =>
      'Biometria não disponível neste dispositivo';

  @override
  String get adminAuthLocalizedReason =>
      'Verifique sua identidade para aprovar o login de administrador';

  @override
  String get adminAuthErrorBiometricFailed => 'Falha na verificação biométrica';

  @override
  String get adminAuthErrorBiometricGeneric => 'Erro biométrico';

  @override
  String get adminAuthTitle => 'LOGIN ADMIN';

  @override
  String get adminAuthDescription =>
      'Uma solicitação de login ao painel admin foi iniciada em um navegador.';

  @override
  String get adminAuthBiometricRequired => 'Biometria necessária para aprovar';

  @override
  String get adminAuthBtnApprove => 'Aprovar';

  @override
  String get adminAuthBtnDeny => 'Negar';

  @override
  String get adminLockTitle => 'ACESSO BLOQUEADO';

  @override
  String get adminLockSubtitle =>
      'Autentique-se para acessar as ferramentas de administração.';

  @override
  String get adminLockLocalizedReason =>
      'Verifique sua identidade para acessar as ferramentas de administração';

  @override
  String get adminLockBtnRetry => 'Tentar novamente';

  @override
  String get adminLockBtnCancel => 'Cancelar';

  @override
  String get eventReviewTitle => 'EVENTOS PARA VALIDAR';

  @override
  String get eventReviewEmpty => 'Nenhum evento pendente';

  @override
  String get eventReviewFree => 'Grátis';

  @override
  String get eventReviewBtnApprove => 'Aprovar';

  @override
  String get eventReviewBtnReject => 'Rejeitar';

  @override
  String get eventReviewApproved => 'Evento aprovado';

  @override
  String get eventReviewRejected => 'Evento rejeitado';

  @override
  String get photoReviewTitle => 'FOTOS PARA VERIFICAR';

  @override
  String get photoReviewEmpty => 'Nenhuma foto pendente';

  @override
  String get photoReviewBtnApprove => 'Aprovar';

  @override
  String get photoReviewBtnReject => 'Rejeitar';

  @override
  String get photoReviewApproved => 'Foto aprovada';

  @override
  String get photoReviewRejected => 'Foto rejeitada';

  @override
  String get photoReviewDetailTitle => 'Detalhe da foto';

  @override
  String get photoReviewLabelsLabel => 'Elementos detectados';

  @override
  String get photoReviewDateLabel => 'Adicionada em';

  @override
  String profileSnackPhotosPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos em verificação',
      one: '1 foto em verificação',
    );
    return '$_temp0';
  }

  @override
  String profileSnackPhotosAutoRejected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos foram rejeitadas',
      one: '1 foto foi rejeitada',
    );
    return '$_temp0';
  }

  @override
  String get reportReviewTitle => 'DENÚNCIAS PARA TRATAR';

  @override
  String get reportReviewEmpty => 'Nenhuma denúncia pendente';

  @override
  String get reportReviewReporterLabel => 'Denunciado por';

  @override
  String get reportReviewReasonLabel => 'Motivo';

  @override
  String get reportReviewMessageLabel => 'Mensagem denunciada';

  @override
  String get reportReviewBannedBadge => 'Banido';

  @override
  String get reportReviewTestAccountBadge => 'Conta de teste';

  @override
  String get reportReviewBtnDismiss => 'Descartar';

  @override
  String get reportReviewBtnBan => 'Banir';

  @override
  String get reportReviewBtnUnban => 'Desbanir';

  @override
  String get reportReviewDismissed => 'Denúncia descartada';

  @override
  String get reportReviewBanned => 'Usuário banido';

  @override
  String get reportReviewUnbanned => 'Usuário desbanido';

  @override
  String get reportDetailTitle => 'Detalhe da denúncia';

  @override
  String get reportDetailDateLabel => 'Denunciado em';

  @override
  String get homeNavDiscover => 'Descobrir';

  @override
  String get homeNavEvents => 'Eventos';

  @override
  String get homeNavMessages => 'Mensagens';

  @override
  String get homeNavProfile => 'Perfil';

  @override
  String get homeMyProfileTitle => 'MEU PERFIL';

  @override
  String get onboardingTourSkip => 'Pular';

  @override
  String get onboardingTourNext => 'Próximo';

  @override
  String get onboardingTourGetStarted => 'Entrar no Nocturne';

  @override
  String get onboardingTourTitle1 => 'DESLIZE NA OBSCURIDADE';

  @override
  String get onboardingTourSubtitle1 =>
      'Deslize perfis que compartilham sua estética e seus gostos musicais.';

  @override
  String get onboardingTourTitle2 => 'REÚNAM-SE NA NOITE';

  @override
  String get onboardingTourSubtitle2 =>
      'Encontre shows e encontros perto de você, e junte-se a outros pássaros noturnos.';

  @override
  String get onboardingTourTitle3 => 'ENVIE UMA ELEGIA';

  @override
  String get onboardingTourSubtitle3 =>
      'Quebre o gelo com uma elegia sincera em vez de um simples olá.';

  @override
  String get onboardingTourTitle4 => 'MODELE SUA SOMBRA';

  @override
  String get onboardingTourSubtitle4 =>
      'Personalize suas fotos, bandas favoritas e links sociais.';

  @override
  String get homeExitConfirmTitle => 'Sair do Nocturne?';

  @override
  String get homeExitConfirmMessage =>
      'Você pode voltar quando quiser, suas conversas continuarão intactas.';

  @override
  String get homeExitConfirmCancel => 'Cancelar';

  @override
  String get homeExitConfirmQuit => 'Sair';

  @override
  String get homeNoProfileTitle => 'Perfil não configurado';

  @override
  String get homeNoProfileDescription =>
      'Crie seu perfil para aparecer no swipe';

  @override
  String get homeBtnCreateProfile => 'Criar meu perfil';

  @override
  String get homePremiumBanner => 'NOCTURNE PREMIUM';

  @override
  String elegieSnackSent(String username) {
    return 'Elegia enviada a $username';
  }

  @override
  String get elegieLimitReachedTitle => 'Limite de elegias atingido';

  @override
  String elegieLimitReachedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Você usou suas $count elegias do dia. Assine Nocturne para enviar mais.',
      one: 'Você usou sua elegia do dia. Assine Nocturne para enviar mais.',
    );
    return '$_temp0';
  }

  @override
  String elegieSheetTitle(String username) {
    return 'Elegia para $username';
  }

  @override
  String get elegieSheetSubtitle =>
      'Uma mensagem curta antes que as trevas decidam';

  @override
  String get elegieHintMessage => 'Escreva sua mensagem...';

  @override
  String get elegieBtnSend => 'Enviar a elegia';

  @override
  String get elegieBannerDescription =>
      'Assine Nocturne para enviar mais elegias.';

  @override
  String get elegieBtnUpgrade => 'Assinar Nocturne';

  @override
  String get periodWeek => 'semana';

  @override
  String get periodMonth => 'mês';

  @override
  String get periodYear => 'ano';

  @override
  String get subscriptionRestoreCta => 'Restaurar minhas compras';

  @override
  String get subscriptionRestoreSuccess => 'Compras restauradas!';

  @override
  String get subscriptionRestoreEmpty => 'Nenhuma compra para restaurar.';

  @override
  String get subscriptionBtnSwitchToFree => 'Mudar para o plano gratuito';

  @override
  String get subscriptionBtnCurrentPlan => '✓ Plano atual';

  @override
  String get subscriptionBtnChangePeriod => 'Mudar o período';

  @override
  String subscriptionBtnChoosePlan(String planName) {
    return 'Escolher $planName';
  }

  @override
  String subscriptionSnackSubscribed(String planName) {
    return '✓ Assinatura $planName ativada!';
  }

  @override
  String get subscriptionSnackError => 'Erro, tente novamente.';

  @override
  String get subscriptionSnackCancelled => 'Assinatura cancelada.';

  @override
  String get subscriptionCancelSubscription => 'Cancelar a assinatura';

  @override
  String get subscriptionCancelAnytimeNote =>
      'Cancelamento possível em qualquer momento';

  @override
  String subscriptionDialogSubscribeTitle(String planName) {
    return 'Assinar $planName';
  }

  @override
  String get subscriptionBtnDialogCancel => 'Cancelar';

  @override
  String get subscriptionBtnDialogConfirm => 'Confirmar';

  @override
  String get subscriptionDialogCancelBody =>
      'Você perderá o acesso aos recursos premium.';

  @override
  String get subscriptionBtnKeep => 'Manter';

  @override
  String get subscriptionBtnConfirmCancel => 'Cancelar';

  @override
  String get subscriptionPageTitle => 'NOCTURNE PREMIUM';

  @override
  String get subscriptionPageSubtitle => 'Junte-se às trevas sem limites';

  @override
  String get subscriptionPaywallBtnViewPlans => 'Ver as assinaturas';

  @override
  String get subscriptionPaywallBtnNotNow => 'Agora não';

  @override
  String subscriptionPaywallAvailableFrom(String planName) {
    return 'Disponível a partir de $planName';
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
  String get subscriptionPriceFree => 'Grátis';

  @override
  String get subscriptionPriceUnavailable => 'Preço não disponível';

  @override
  String get subscriptionBtnRetry => 'Tentar novamente';

  @override
  String get featureOmbreSwipes => '30 swipes por dia';

  @override
  String get featureOmbreElegies => '3 elegias por mês';

  @override
  String get featureOmbreEvents => '2 eventos por mês';

  @override
  String get featureOmbrePhotos => '2 fotos por perfil';

  @override
  String get featureWhoLikedMe => 'Ver quem te deu like';

  @override
  String get featureWhoVisited => 'Quem visitou seu perfil';

  @override
  String get featureRewind => 'Rewind (desfazer um swipe)';

  @override
  String get featureBoostGeneric => 'Boost de perfil';

  @override
  String get featureUnlimitedSwipe => 'Swipe ilimitado';

  @override
  String get featureNocturneElegies => '15 elegias por mês';

  @override
  String get featureNocturneEvents => '4 eventos por mês';

  @override
  String get featurePhotos6 => '6 fotos por perfil';

  @override
  String get featureBoostMonthly => '1 boost por mês';

  @override
  String get featureUnlimitedElegies => 'Elegias ilimitadas';

  @override
  String get featureUnlimitedEvents => 'Eventos ilimitados';

  @override
  String get featureBoostWeekly => '1 boost por semana';

  @override
  String get socialBtnReport => 'Denunciar';

  @override
  String get socialBtnBlock => 'Bloquear';

  @override
  String socialDialogBlockBody(String username) {
    return 'Bloquear $username? Seu match será excluído.';
  }

  @override
  String get socialBtnCancel => 'Cancelar';

  @override
  String get reportCategoryHarassment => 'Assédio';

  @override
  String get reportSubHarassmentTargeted => 'Isso me atinge pessoalmente';

  @override
  String get reportSubHarassmentThreatening => 'Comportamento ameaçador';

  @override
  String get reportSubHarassmentRepeated => 'Mensagens indesejadas repetidas';

  @override
  String get reportCategoryFakeProfile => 'Perfil falso';

  @override
  String get reportSubFakeStolenPhotos => 'Fotos roubadas';

  @override
  String get reportSubFakeImpersonation => 'Falsidade de identidade';

  @override
  String get reportSubFakeGhost => 'Conta fantasma';

  @override
  String get reportCategoryNonConsensualSexual =>
      'Conteúdo sexual não consentido';

  @override
  String get reportCategorySpam => 'Spam ou golpe';

  @override
  String get reportCategoryMinor => 'Menor de idade';

  @override
  String get reportCategoryHateSpeech => 'Discurso de ódio ou discriminatório';

  @override
  String get reportCategoryOther => 'Outro';

  @override
  String socialReportHeaderTitle(String username) {
    return 'Denunciar $username';
  }

  @override
  String get socialReportRootQuestion =>
      'Por que você está denunciando este perfil?';

  @override
  String get socialReportRootQuestionMessage =>
      'Por que você está denunciando esta mensagem?';

  @override
  String get socialReportHint => 'Descreva o problema...';

  @override
  String get socialBtnSendReport => 'Enviar a denúncia';

  @override
  String get socialReportSentTitle => 'Denúncia enviada';

  @override
  String get socialReportSentBody =>
      'Obrigado. Nossa equipe vai analisar esta denúncia.';

  @override
  String get socialBtnClose => 'Fechar';

  @override
  String get chatReplyPhoto => 'Foto';

  @override
  String get chatMessageDeleted => 'Mensagem excluída';

  @override
  String get chatMessageUnderReview => 'Denúncia em processo de verificação';

  @override
  String get chatStatusRead => 'Lida';

  @override
  String get chatStatusSent => 'Enviada';

  @override
  String get chatListTitle => 'MENSAGENS';

  @override
  String get chatTabChats => 'CONVERSAS';

  @override
  String get chatTabElegiesReceived => 'ELEGIAS RECEBIDAS';

  @override
  String get chatTabElegiesSent => 'ELEGIAS ENVIADAS';

  @override
  String get chatEmptyMatchesTitle => 'Nenhum match por enquanto...';

  @override
  String get chatEmptyMatchesSub => 'Continue explorando as trevas';

  @override
  String get giftRevealHint => 'Toque no selo para abri-lo';

  @override
  String get giftRevealTitle => 'DOIS MESES DE NOCTURNE';

  @override
  String get giftRevealSubtitle =>
      'Um presente para as cinquenta primeiras almas que ousaram entrar 🌙';

  @override
  String get giftRevealClose => 'Continuar';

  @override
  String get giftRevealErrorTitle => 'A cera não quis ceder';

  @override
  String get giftRevealErrorSubtitle => 'Ocorreu um erro. Tente novamente.';

  @override
  String get giftRevealRetry => 'Tentar novamente';

  @override
  String get matchTitleBond => 'UM VÍNCULO OBSCURO';

  @override
  String get matchTitleBorn => 'NASCEU';

  @override
  String get matchTitleElegie => 'SUA ELEGIA FOI OUVIDA';

  @override
  String get matchSubtitleElegie => 'As trevas atenderam sua súplica';

  @override
  String matchSubtitleBond(String username) {
    return 'Você & $username estão ligados pelas trevas';
  }

  @override
  String get matchBtnMessage => 'ENVIAR UMA MENSAGEM';

  @override
  String get matchBtnKeepExploring => 'Continuar explorando';

  @override
  String get matchAvatarYou => 'Você';

  @override
  String get matchesTileSubtitle => 'Ligados pelas trevas';

  @override
  String get matchesBtnMessage => 'Mensagem';

  @override
  String get chatOpenErrorTitle => 'Não foi possível abrir a conversa';

  @override
  String get commonBtnCancel => 'Cancelar';

  @override
  String get commonBtnSend => 'Enviar';

  @override
  String get starterCardTitle => 'Para quebrar o gelo';

  @override
  String get starterConfirmTitle => 'Enviar esta mensagem?';

  @override
  String get starterNoCommonDialog =>
      'Seus perfis não têm nenhuma tag em comum, mas vocês se curtiram do mesmo jeito. Aqui estão algumas ideias para começar a conversa.';

  @override
  String get starterToggleClassic => 'Ideias clássicas';

  @override
  String get starterToggleShared => 'Com base nos pontos em comum';

  @override
  String starterHookShared(String tag) {
    return 'Vocês têm $tag em comum.';
  }

  @override
  String starterHookRare(String tag) {
    return 'Poucos perfis têm $tag, e vocês dois fazem parte deles.';
  }

  @override
  String starterHookCombo(String tag1, String tag2) {
    return 'Vocês têm $tag1 e $tag2 em comum.';
  }

  @override
  String starterHookBand(String band) {
    return 'Vocês dois gostam de $band.';
  }

  @override
  String starterHookEvent(String event) {
    return 'Vocês dois estão participando do evento $event.';
  }

  @override
  String get starterHookMood =>
      'Vocês se identificam com o mesmo clima musical.';

  @override
  String starterHookOtherBand(String band) {
    return 'Essa pessoa gosta de $band.';
  }

  @override
  String starterMsgGenre1(String tag) {
    return 'Estou em plena fase $tag agora. E você, qual música está no repeat?';
  }

  @override
  String starterMsgGenre2(String tag) {
    return 'Qual foi a primeira banda de $tag que te fez entrar de cabeça nisso?';
  }

  @override
  String starterMsgGenre3(String tag) {
    return 'Se eu só pudesse ouvir um álbum de $tag essa semana, qual você recomendaria?';
  }

  @override
  String starterMsgVibe1(String tag) {
    return 'Se sua playlist $tag virasse a trilha sonora de um filme, qual seria?';
  }

  @override
  String starterMsgVibe2(String tag) {
    return 'Qual música te põe direto no clima $tag?';
  }

  @override
  String get starterMsgVibeSensitive =>
      'Qual música te acompanha nesses momentos?';

  @override
  String starterMsgAesthetic1(String tag) {
    return 'Seu universo $tag, por onde começa: as roupas, o quarto, as capas dos discos?';
  }

  @override
  String starterMsgIntensity1(String tag) {
    return 'Em termos de intensidade $tag, qual música te representa melhor?';
  }

  @override
  String starterMsgEra1(String tag) {
    return 'Qual disco da época $tag você levaria para uma ilha deserta?';
  }

  @override
  String get starterMsgFormatConcerts =>
      'O último show que te marcou, e o pior também?';

  @override
  String get starterMsgFormatVinyl =>
      'A peça da sua coleção que mais significa para você?';

  @override
  String get starterMsgFormatBandcamp =>
      'Sua última descoberta no Bandcamp? Estou procurando algo para minha próxima sessão de escuta.';

  @override
  String get starterMsgFormatPlaylist =>
      'Uma playlist que você escuta sem parar? Me manda o link.';

  @override
  String get starterMsgFormatUnderground =>
      'Algum lugar pequeno ou cena local que merece ser mais conhecida, onde você vive?';

  @override
  String starterMsgBand1(String band) {
    return 'Seu álbum favorito de $band, e aquele que você defende mesmo dividindo opiniões?';
  }

  @override
  String get starterMsgEvent1 => 'O que você mais espera desse evento?';

  @override
  String starterMsgOtherBand1(String band) {
    return 'Vi que você gosta de $band. Qual é seu álbum favorito?';
  }

  @override
  String starterMsgCombo1(String tag1, String tag2) {
    return '$tag1 e $tag2, parece a noite perfeita. Com qual música você começaria?';
  }

  @override
  String get starterFallback1 =>
      'O último álbum que você ouviu do início ao fim?';

  @override
  String get starterFallback2 =>
      'Se sua playlist do momento fosse um filme, qual seria o nome?';

  @override
  String get starterFallback3 =>
      'Uma banda que você defende mesmo que ninguém entenda?';

  @override
  String get starterFallback4 =>
      'Uma música que sempre te emociona, mesmo depois de cem escutas?';

  @override
  String get starterFallback5 =>
      'Um show dos sonhos, e sua pior lembrança de show?';

  @override
  String get starterFallback6 =>
      'Desafio: cada um manda uma música que o outro provavelmente não conhece. Trato?';

  @override
  String get chatEmptyElegiesReceivedTitle => 'Nenhuma elegia recebida';

  @override
  String get chatEmptyElegiesReceivedSub =>
      'Alguém vai pensar em você em breve...';

  @override
  String get chatEmptyElegiesSentTitle => 'Nenhuma elegia enviada';

  @override
  String get chatEmptyElegiesSentSub => 'Ouse quebrar o silêncio...';

  @override
  String get chatMessageBlockedContactInfo =>
      'Para sua segurança, links e números de telefone não são permitidos até que a outra pessoa responda.';

  @override
  String get chatNewMatch => 'Novo match';

  @override
  String get chatElegiePending => 'Pendente';

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
  String get chatTyping => 'digitando...';

  @override
  String get chatInputHint => 'Mensagem...';

  @override
  String get chatEmojiHint => 'Escolha um emoji...';

  @override
  String get chatBtnReportMessage => 'Denunciar esta mensagem';

  @override
  String get chatBtnDeleteForMe => 'Excluir para mim';

  @override
  String get chatBtnDeleteForAll => 'Excluir para todos';

  @override
  String get chatLastSeenJustNow => 'visto agora';

  @override
  String chatLastSeenMinutesAgo(int count) {
    return 'visto há $count min';
  }

  @override
  String chatLastSeenHoursAgo(int count) {
    return 'visto há $count h';
  }

  @override
  String chatLastSeenDaysAgo(int count) {
    return 'visto há $count d';
  }

  @override
  String get discoverySwipePageTitle => 'NOCTURNE';

  @override
  String get discoveryEmptyProfiles => 'Nenhum perfil por aqui...';

  @override
  String get discoveryEmptySubtitle =>
      'Você já viu todos os perfis disponíveis por enquanto.';

  @override
  String get discoveryEmptyResetLikes => 'Reiniciar seus likes';

  @override
  String get discoveryEmptyEditFilters => 'Editar seus filtros de busca';

  @override
  String get discoveryEmptyWaitMoon => 'Esperar uma lua nova';

  @override
  String get discoveryEmptyResetSuccess =>
      'Seus likes foram reiniciados, os perfis voltam a aparecer no feed.';

  @override
  String get discoveryEmptyWaitMoonMessage =>
      'Novos perfis chegam com a lua nova. Volte em breve.';

  @override
  String get discoveryLoadErrorTitle => 'Não foi possível carregar os perfis';

  @override
  String get discoveryLoadErrorSubtitle =>
      'Verifique sua conexão e tente novamente.';

  @override
  String get discoveryBtnRetry => 'Tentar novamente';

  @override
  String get discoveryBoostActivated =>
      'Boost ativado! Seu perfil fica em destaque por 30 minutos.';

  @override
  String get discoveryRewindTitle => 'Rewind não disponível';

  @override
  String get discoveryRewindBody =>
      'O rewind está disponível a partir do plano Nocturne.';

  @override
  String get discoveryBoostTitle => 'Boost não disponível';

  @override
  String get discoveryBoostBody =>
      'O boost está disponível a partir do plano Nocturne (1/mês) ou Abyssal (1/semana).';

  @override
  String get discoverySwipeLimitTitle => 'Limite de swipes atingido';

  @override
  String discoverySwipeLimitBody(int count) {
    return 'Você usou seus $count swipes do dia. Assine Nocturne para swipear sem limite.';
  }

  @override
  String discoverySwipeCounter(int remaining, int limit) {
    return '$remaining / $limit swipes hoje';
  }

  @override
  String get discoveryBtnElegie => 'Elegia';

  @override
  String get discoveryLikesTitle => 'LIKES';

  @override
  String get discoveryTabMyLikes => 'Meus likes';

  @override
  String get discoveryTabWhoLikedMe => 'Quem me deu like';

  @override
  String get discoveryEmptyMyLikes => 'Nenhum like por enquanto';

  @override
  String get discoveryEmptyWhoLikedMe => 'Ainda ninguém deu like no seu perfil';

  @override
  String get discoveryPaywallTitle => 'Recurso Nocturne';

  @override
  String get discoveryPaywallDescription =>
      'Descubra quem deu like no seu perfil ao assinar Nocturne ou Abyssal.';

  @override
  String get discoveryPaywallSheetTitle => 'Quem me deu like';

  @override
  String get discoveryPaywallSheetDescription =>
      'Descubra todos os perfis que deram like no seu.';

  @override
  String get discoveryBtnUpgrade => 'Assinar Nocturne';

  @override
  String get discoveryOverlayLike => 'LIKE';

  @override
  String get discoveryOverlayNope => 'NOPE';

  @override
  String get discoveryBadgeMatch => 'MATCH';

  @override
  String get authLoginTitle => 'NOCTURNE';

  @override
  String get authLoginError => 'Email ou senha incorretos.';

  @override
  String get authLabelEmail => 'Email';

  @override
  String get authLabelPassword => 'Senha';

  @override
  String get authBtnLogin => 'Entrar';

  @override
  String get authBtnGoToRegister => 'Ainda não tem conta? Criar uma conta';

  @override
  String get authBtnForgotPassword => 'Esqueceu a senha?';

  @override
  String get authForgotTitle => 'Senha esquecida';

  @override
  String get authForgotSubtitle =>
      'Digite seu email, enviaremos um código de 6 dígitos.';

  @override
  String get authBtnSendCode => 'Enviar o código';

  @override
  String get authForgotSentMessage =>
      'Se existir uma conta com este email, um código foi enviado.';

  @override
  String get authVerifyCodeTitle => 'Verificar o código';

  @override
  String get authVerifyCodeSubtitle =>
      'Digite o código de 6 dígitos recebido por email.';

  @override
  String get authBtnVerifyCode => 'Verificar';

  @override
  String get authResetTitle => 'Redefinir a senha';

  @override
  String get authResetSubtitle => 'Escolha sua nova senha.';

  @override
  String get authLabelResetCode => 'Código de 6 dígitos';

  @override
  String get authLabelNewPassword => 'Nova senha';

  @override
  String get authBtnResetPassword => 'Redefinir';

  @override
  String get authResetSuccessMessage =>
      'Senha redefinida. Entre com sua nova senha.';

  @override
  String get authWelcomeTitle => 'BEM-VINDO/A';

  @override
  String get authWelcomeSubtitle => 'às trevas';

  @override
  String get authLabelUsername => 'Nome de usuário';

  @override
  String get authErrorFillAllFields => 'Preencha todos os campos.';

  @override
  String get authErrorInvalidEmail => 'Email inválido.';

  @override
  String get authErrorPasswordTooShort => 'Senha: mínimo de 12 caracteres.';

  @override
  String get authErrorPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get authStepCredentialsTitle => 'Bem-vindo/a às \ntrevas 🌙';

  @override
  String get authStepCredentialsSubtitle =>
      'Crie sua conta para entrar no Nocturne.';

  @override
  String get authHelperPasswordMin => 'Mínimo de 12 caracteres';

  @override
  String get authLabelConfirmPassword => 'Confirmar a senha';

  @override
  String get authBtnContinue => 'Continuar';

  @override
  String get authLabelBirthDate => 'Data de nascimento';

  @override
  String get authErrorUsernameInvalid =>
      'Escolha um nome de usuário válido e disponível.';

  @override
  String get authStepIdentityTitle => 'Quem é você?';

  @override
  String get authStepIdentitySubtitle =>
      'Essas informações não poderão ser facilmente alteradas.';

  @override
  String get authLabelGender => 'Gênero';

  @override
  String get authLabelPronouns => 'Pronomes';

  @override
  String get authLabelBio => 'BIO';

  @override
  String get authHintBio => 'Fale sobre você, sua música, seu universo...';

  @override
  String get authOther => 'Outro';

  @override
  String get authGenderMale => 'Homem';

  @override
  String get authGenderFemale => 'Mulher';

  @override
  String get authGenderNonBinary => 'Não binário';

  @override
  String get authGenderGenderfluid => 'Genderfluid';

  @override
  String get authGenderAgender => 'Agênero';

  @override
  String get authGenderTransmasculine => 'Transmasculino';

  @override
  String get authGenderTransfeminine => 'Transfeminino';

  @override
  String get authGenderAll => 'Todos';

  @override
  String get authPronounHeHim => 'Ele/ele';

  @override
  String get authPronounSheHer => 'Ela/ela';

  @override
  String get authPronounTheyThem => 'Elu/elu';

  @override
  String get authPronounPluralNeutral => 'Elus/elus';

  @override
  String get authLabelSpecify => 'Especifique...';

  @override
  String get authErrorSelectPreference =>
      'Selecione pelo menos uma preferência.';

  @override
  String get authStepPreferencesTitle => 'Suas preferências';

  @override
  String get authStepPreferencesSubtitle => 'Quem você quer conhecer?';

  @override
  String authAgeRangeLabel(int min, int max) {
    return 'Faixa de idade: $min - $max anos';
  }

  @override
  String authMaxDistanceLabel(int km) {
    return 'Distância máxima: $km km';
  }

  @override
  String get authLabelGenderPreferences => 'Gênero(s) procurado(s)';

  @override
  String get authBtnCreateAccount => 'Criar minha conta';

  @override
  String get authStepVerifyEmailTitle => 'Verifique seu email';

  @override
  String authStepVerifyEmailSubtitle(String email) {
    return 'Digite o código de 6 dígitos enviado para $email';
  }

  @override
  String get authLabelVerificationCode => 'Código de 6 dígitos';

  @override
  String get authBtnVerifyEmail => 'Verificar';

  @override
  String get authBtnResendVerificationCode => 'Reenviar o código';

  @override
  String get authVerifyEmailResentMessage => 'Um novo código foi enviado.';

  @override
  String get authErrorSelectGenreAesthetic =>
      'Selecione pelo menos um gênero e uma estética.';

  @override
  String get authStepTagsTitle => 'Seu universo musical';

  @override
  String get authStepTagsSubtitle =>
      'Essas tags servem para te combinar com perfis compatíveis.';

  @override
  String get authSectionMusicGenres => 'Gêneros musicais';

  @override
  String get authSectionMusicVibes => 'Clima musical';

  @override
  String get authSectionAesthetics => 'Estética';

  @override
  String get authSectionSoundIntensity => 'Intensidade sonora';

  @override
  String get authSectionMusicEras => 'Época';

  @override
  String get authSectionDiscoveryFormats => 'Descoberta musical';

  @override
  String get authSectionFavoriteBands =>
      'Bandas / Artistas favoritos (opcional)';

  @override
  String get authHintBands => 'Uma banda por vez, ex.: The Cure';

  @override
  String get bandSearchAttribution => 'Resultados via Spotify';

  @override
  String get authLocationPermissionDenied =>
      'Permissão negada. Você pode pular esta etapa';

  @override
  String get authLocationError =>
      'Não foi possível obter a localização. Você pode pular esta etapa.';

  @override
  String get authStepLocationTitle => 'Sua localização';

  @override
  String get authStepLocationSubtitle =>
      'Para te mostrar perfis perto de você. Você pode pular esta etapa.';

  @override
  String get authLocationSaved => 'Localização salva ✓';

  @override
  String get authBtnAllowLocation => 'Permitir a localização';

  @override
  String get authBtnSkipStep => 'Pular esta etapa';

  @override
  String get authErrorAddPhoto => 'Adicione pelo menos uma foto.';

  @override
  String get authStepPhotosTitle => 'Suas fotos';

  @override
  String get authStepPhotosSubtitle =>
      'Adicione até 6 fotos. A primeira será sua foto principal.';

  @override
  String get authBadgeMain => 'Principal';

  @override
  String get settingsTitle => 'CONFIGURAÇÕES';

  @override
  String get settingsSectionAccount => 'Conta';

  @override
  String get settingsBtnEditProfile => 'Editar meu perfil';

  @override
  String get settingsBtnChangePassword => 'Alterar a senha';

  @override
  String get settingsBtnLogout => 'Sair da conta';

  @override
  String get settingsBtnDeleteAccount => 'Excluir a conta';

  @override
  String get settingsLabelMaxDistance => 'Distância máxima';

  @override
  String settingsValueKm(int km) {
    return '$km km';
  }

  @override
  String get settingsLabelAgeRange => 'Faixa de idade';

  @override
  String settingsValueAgeRange(int min, int max) {
    return '$min – $max anos';
  }

  @override
  String get settingsSectionNotifications => 'Notificações';

  @override
  String get settingsNotifMatches => 'Novos matches';

  @override
  String get settingsNotifMessages => 'Novas mensagens';

  @override
  String get settingsNotifElegies => 'Elegias recebidas';

  @override
  String get settingsSectionPrivacy => 'Privacidade';

  @override
  String get settingsPrivacyVisible => 'Perfil visível no swipe';

  @override
  String get settingsSectionAbout => 'Sobre';

  @override
  String get settingsVersionLabel => 'Versão';

  @override
  String get settingsTermsOfService => 'Termos de uso';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidade';

  @override
  String get settingsRateApp => 'Avaliar o aplicativo';

  @override
  String get settingsSectionAdmin => 'Administração';

  @override
  String get settingsAdminReports => 'Denúncias';

  @override
  String get settingsAdminPhotos => 'Fotos';

  @override
  String get settingsDeleteAccountWarning =>
      'Esta ação é irreversível.\nDigite seu nome de usuário para confirmar.';

  @override
  String get settingsBtnCancel => 'Cancelar';

  @override
  String get settingsBtnDeleteForever => 'Excluir definitivamente';

  @override
  String get settingsErrorAllFieldsRequired =>
      'Todos os campos são obrigatórios';

  @override
  String get settingsErrorPasswordMismatch => 'As senhas não coincidem';

  @override
  String get settingsErrorPasswordMin => 'Mínimo de 12 caracteres';

  @override
  String get settingsLabelCurrentPassword => 'Senha atual';

  @override
  String get settingsLabelNewPassword => 'Nova senha';

  @override
  String get settingsLabelConfirmNewPassword => 'Confirmar a nova';

  @override
  String get settingsBtnConfirm => 'Confirmar';

  @override
  String eventDateAtTime(String date, String time) {
    return '$date às $time';
  }

  @override
  String get eventPageTitle => 'EVENTOS';

  @override
  String get eventLabelMaxDistance => 'Distância máxima';

  @override
  String eventValueKm(int km) {
    return '$km km';
  }

  @override
  String get eventLabelGenres => 'Gêneros';

  @override
  String get eventFilterAllGenres => 'Todos os gêneros';

  @override
  String get eventFilterMyGenres => 'Meus gêneros';

  @override
  String get eventEmptyZone => 'Nenhum evento na sua área';

  @override
  String get eventEmptyCategory => 'Nenhum evento nesta categoria';

  @override
  String get eventSubmittedForModeration => 'Evento enviado para moderação';

  @override
  String get eventLimitTitle => 'Limite de eventos atingido';

  @override
  String eventLimitBody(int count) {
    return 'Você usou suas $count inscrições em eventos este mês. Assine Nocturne para 4/mês ou Abyssal para ilimitado.';
  }

  @override
  String get eventUnregisterConfirmed => 'Cancelamento confirmado';

  @override
  String get eventRegisterConfirmed => 'Inscrição confirmada!';

  @override
  String get eventSectionDescription => 'DESCRIÇÃO';

  @override
  String get eventSectionParticipants => 'PARTICIPANTES';

  @override
  String get eventBtnUnregisterLong => 'Inscrito ✓ — Cancelar inscrição';

  @override
  String get eventPriceFree => 'Grátis';

  @override
  String get eventBadgeRegistered => 'Inscrito ✓';

  @override
  String get eventBtnRegister => 'Inscrever-se';

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
    return '$name1 e $name2 participam';
  }

  @override
  String eventMutualWithExtra(String names, int extra) {
    String _temp0 = intl.Intl.pluralLogic(
      extra,
      locale: localeName,
      other: 'mais $extra',
      one: 'mais 1',
    );
    return '$names e $_temp0 participam';
  }

  @override
  String get eventErrorTitleDescRequired => 'Título e descrição obrigatórios';

  @override
  String get eventStepCoverTitle => 'Apresente seu evento';

  @override
  String get eventStepCoverSubtitle => 'Foto, título e descrição';

  @override
  String get eventBtnAddCoverPhoto => 'Adicionar uma foto de capa';

  @override
  String get eventLabelTitleRequired => 'Título *';

  @override
  String get eventLabelDescriptionRequired => 'Descrição *';

  @override
  String get eventBtnContinue => 'Continuar';

  @override
  String get eventErrorDateRequired => 'Escolha uma data e horário';

  @override
  String get eventStepDatetimeTitle => 'Quando é o evento?';

  @override
  String get eventStepDatetimeSubtitle => 'Data e horário de início';

  @override
  String get eventBtnPickDateTime => 'Escolher data e horário';

  @override
  String get eventErrorAddressRequired => 'Selecione um endereço na lista';

  @override
  String get eventStepLocationTitle => 'Onde ele acontece?';

  @override
  String get eventStepLocationSubtitle => 'Busque o endereço do local';

  @override
  String get eventStepGenresTitle => 'Gêneros musicais';

  @override
  String get eventStepGenresSubtitle => 'Selecione os gêneros do evento';

  @override
  String get eventErrorCapacityInvalid =>
      'Insira uma capacidade válida (mín. 1)';

  @override
  String get eventErrorCapacityMaxMin => 'O máximo deve ser maior que o mínimo';

  @override
  String get eventStepCapacityTitle => 'Quantas vagas?';

  @override
  String get eventStepCapacitySubtitle => 'Capacidade máxima do evento';

  @override
  String get eventToggleExactNumber => 'Número exato';

  @override
  String get eventToggleRange => 'Faixa';

  @override
  String get eventLabelExactPlaces => 'Número de vagas *';

  @override
  String get eventLabelMin => 'Mín *';

  @override
  String get eventLabelMax => 'Máx *';

  @override
  String get eventErrorPriceInvalid => 'Insira um preço válido';

  @override
  String get eventStepPriceTitle => 'Qual é o preço?';

  @override
  String get eventStepPriceSubtitle => 'Última etapa antes de enviar';

  @override
  String get eventTogglePaid => 'Pago';

  @override
  String get eventLabelPriceRequired => 'Preço *';

  @override
  String get eventBtnSubmit => 'Enviar o evento';

  @override
  String get eventFilterAll => 'Todos';

  @override
  String get eventFilterAttending => 'Inscritos';

  @override
  String get eventFilterMatches => 'Meus matches';

  @override
  String get eventFilterFavorites => 'Favoritos';

  @override
  String get eventSheetUnregisterTitle => 'Cancelar inscrição no evento';

  @override
  String get eventSheetRegisterTitle => 'Confirmar a inscrição';

  @override
  String get eventBtnConfirmUnregister => 'Confirmar o cancelamento';

  @override
  String get eventBtnConfirmRegister => 'Eu vou participar!';

  @override
  String get eventPaymentSheetTitle => 'Confirme seu ingresso';

  @override
  String eventPaymentBtn(String amount) {
    return 'Pagar $amount €';
  }

  @override
  String get eventPaymentError => 'Pagamento falhou, tente novamente.';

  @override
  String get eventBtnCancel => 'Cancelar';

  @override
  String get eventSectionInfo => 'INFO';

  @override
  String eventCapacityRange(int min, int max) {
    return '$min–$max vagas';
  }

  @override
  String eventCapacityMin(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min vagas',
      one: '1 vaga',
    );
    return '$_temp0';
  }

  @override
  String get profileSectionBio => 'Bio';

  @override
  String get profileSectionMusicGenres => 'Gêneros musicais';

  @override
  String get profileSectionVibe => 'Clima';

  @override
  String get profileSectionAesthetics => 'Estética e cultura';

  @override
  String get profileSectionSoundIntensity => 'Intensidade sonora';

  @override
  String get profileSectionEra => 'Época / cena';

  @override
  String get profileSectionDiscovery => 'Descoberta musical';

  @override
  String get profileSectionFavoriteBands => 'Artistas favoritos';

  @override
  String get profileSectionUpcomingEvents => 'Próximos eventos';

  @override
  String get profileSectionLinks => 'Links';

  @override
  String get profileSectionPhotos => 'FOTOS';

  @override
  String get profileBadgePremium => 'PREMIUM';

  @override
  String get profileBtnUnlockPremium => 'Desbloquear com Premium';

  @override
  String get profileEditTitle => 'EDITAR MEU PERFIL';

  @override
  String get profileEditTabIdentity => 'Identidade';

  @override
  String get profileEditTabPhotos => 'Fotos';

  @override
  String get profileEditTabTags => 'Tags';

  @override
  String get profileEditTabLocation => 'Local';

  @override
  String get profileEditTabPreferences => 'Preferências';

  @override
  String get profileMenuTitle => 'MEU ESPAÇO';

  @override
  String get profileMenuLikesHistory => 'Histórico de likes';

  @override
  String get profileMenuVisitors => 'Visitantes do meu perfil';

  @override
  String get profileMenuMatches => 'Meus matches';

  @override
  String get profileMenuSettings => 'Configurações';

  @override
  String get profileSnackIdentityUpdated => 'Identidade atualizada!';

  @override
  String get profileLabelUsername => 'NOME DE USUÁRIO';

  @override
  String get profileUsernameImmutableNote =>
      'O nome de usuário não pode ser alterado aqui.';

  @override
  String get profileLabelBio => 'BIO';

  @override
  String get profileHintBio => 'Fale sobre você, sua música...';

  @override
  String get profileLabelGender => 'Gênero';

  @override
  String get profileLabelPronouns => 'Pronomes';

  @override
  String get profileBtnSave => 'Salvar';

  @override
  String get profileSnackMaxPhotos => 'Máximo de 6 fotos';

  @override
  String get profileSnackPhotosUpdated => 'Fotos atualizadas!';

  @override
  String profilePhotoCount(int total) {
    return '$total / 6 fotos';
  }

  @override
  String get profileBadgeNew => 'Novo';

  @override
  String get profileBadgePending => 'Pendente';

  @override
  String get profileBtnAddPhoto => 'Adicionar';

  @override
  String get profileSnackTagsUpdated => 'Tags musicais atualizadas!';

  @override
  String get profileSubtitleMusicGenres => 'Sua identidade sonora principal';

  @override
  String get profileSectionMusicVibe => 'Clima musical';

  @override
  String get profileSubtitleMusicVibe => 'O que você sente ao ouvir';

  @override
  String get profileSubtitleAesthetics => 'Sua cena, seu estilo de vida';

  @override
  String get profileSubtitleSoundIntensity => 'A energia da sua música';

  @override
  String get profileSubtitleEra => 'Sua nostalgia geracional';

  @override
  String get profileSubtitleDiscovery => 'Seus hábitos de escuta';

  @override
  String get profileSectionFavoriteBandsCaps => 'ARTISTAS FAVORITOS';

  @override
  String get profileHintBands => 'Uma banda por vez, ex.: Bauhaus';

  @override
  String get profileSectionSocialLinksCaps => 'LINKS';

  @override
  String get profileHintSocialLink =>
      'Cole um link: Spotify, Instagram, Bandcamp, Discord...';

  @override
  String get profileLinkNotRecognized =>
      'Link não reconhecido. Aceitos: Spotify, Instagram, Bandcamp, Discord, Last.fm, Tumblr.';

  @override
  String profileLinkWrongPlatform(String platform) {
    return 'Este link não corresponde a $platform.';
  }

  @override
  String get profileDiscordConnectPrompt =>
      'Conectar sua conta do Discord? Você precisará entrar e autorizar o acesso no seu navegador.';

  @override
  String profileDiscordConnectedAs(String username) {
    return 'Conectado como $username.';
  }

  @override
  String get profileDiscordBtnConnect => 'Conectar';

  @override
  String get profileDiscordConnectFailed =>
      'Não foi possível conectar o Discord. Tente novamente.';

  @override
  String get profileBandAlreadyAdded => 'Esta banda já está na sua lista.';

  @override
  String get profileBandNotAllowed => 'Este nome de banda não é permitido.';

  @override
  String get profileErrorSelectAddress => 'Selecione um endereço';

  @override
  String get profileSnackLocationUpdated => 'Localização atualizada!';

  @override
  String get profileSectionLocation => 'LOCALIZAÇÃO';

  @override
  String get profileLocationDescription =>
      'Usada para encontrar perfis e eventos perto de você.';

  @override
  String get profileSnackPreferencesUpdated => 'Preferências atualizadas!';

  @override
  String get profileLabelAgeRange => 'FAIXA DE IDADE';

  @override
  String profileAgeYears(int age) {
    return '$age anos';
  }

  @override
  String get profileLabelMaxDistance => 'DISTÂNCIA MÁXIMA';

  @override
  String profileValueKm(int km) {
    return '$km km';
  }

  @override
  String get profileLabelGenderSought => 'GÊNERO PROCURADO';
}
