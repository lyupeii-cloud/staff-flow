// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class L10nPt extends L10n {
  L10nPt([String locale = 'pt']) : super(locale);

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get validate => 'Confirmar';

  @override
  String get add => 'Adicionar';

  @override
  String get rename => 'Mudar o nome';

  @override
  String get delete => 'Eliminar';

  @override
  String get accept => 'Aceitar';

  @override
  String get decline => 'Recusar';

  @override
  String get close => 'Fechar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get name => 'Nome';

  @override
  String get serverUnreachable => 'Não foi possível contactar o servidor.';

  @override
  String errorStatus(int status) {
    return 'Erro $status';
  }

  @override
  String get roleOwner => 'Proprietário';

  @override
  String get roleManager => 'Responsável';

  @override
  String get roleEmployee => 'Funcionário';

  @override
  String get roleExtra => 'Temporário';

  @override
  String get taglineStart => 'Os horários da sua equipa, ';

  @override
  String get taglineEnd => 'em todo o lado.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Iniciar sessão com o Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Início de sessão com o Google indisponível: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Não foi possível iniciar sessão com o Google: $detail';
  }

  @override
  String get newCompany => 'Nova empresa';

  @override
  String get timezone => 'Fuso horário';

  @override
  String get create => 'Criar';

  @override
  String get noCompanyTitle => 'Ainda não faz parte de nenhuma empresa.';

  @override
  String get noCompanyHint =>
      'Para se juntar à do seu empregador, gere um código e dê-o ao seu responsável.';

  @override
  String get joinCompany => 'Juntar-se a uma empresa';

  @override
  String get createCompany => 'Criar uma empresa';

  @override
  String transferOffer(String company) {
    return 'Propõem-lhe tornar-se proprietário de «$company».';
  }

  @override
  String get someCompany => 'uma empresa';

  @override
  String get becameOwner => 'Agora é o proprietário.';

  @override
  String get myAccount => 'A minha conta';

  @override
  String get idCopied => 'Identificador copiado.';

  @override
  String get signOut => 'Terminar sessão';

  @override
  String joinInvite(String company, String role) {
    return '«$company» convida-o como $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Juntou-se a $company.';
  }

  @override
  String get viewPlanning => 'Horário';

  @override
  String get viewTeam => 'Gestão';

  @override
  String get viewPositions => 'Funções';

  @override
  String get readOnlyCompany => 'Empresa apenas de leitura.';

  @override
  String get team => 'Equipa';

  @override
  String get leaveCompany => 'Sair desta empresa';

  @override
  String meSuffix(String name) {
    return '$name (você)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Transferir a empresa para $name?';
  }

  @override
  String get transferConfirmBody =>
      'Depois de aceitar, essa pessoa passa a ser proprietária (subscrição, faturas, responsáveis) e você passa a ser responsável.';

  @override
  String transferSent(String name) {
    return 'Proposta enviada a $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Remover $name?';
  }

  @override
  String get removeConfirmBody => 'O histórico é conservado.';

  @override
  String get addPersonTitle => 'Adicionar uma pessoa';

  @override
  String get addPersonHint =>
      'Peça-lhe para abrir o Staff Flow, o menu da conta, «Juntar-se a uma empresa», e introduza o código apresentado.';

  @override
  String get sixDigitCode => 'Código de 6 dígitos';

  @override
  String invitationSent(String name) {
    return 'Convite enviado a $name: tem de o aceitar.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Sair de $company?';
  }

  @override
  String get leaveConfirmBody => 'Deixará de ver o horário desta empresa.';

  @override
  String get renameCompany => 'Mudar o nome da empresa';

  @override
  String get actionMakeManager => 'Tornar responsável';

  @override
  String get actionMakeEmployee => 'Voltar a funcionário';

  @override
  String get actionToEmployee => 'Passar a funcionário';

  @override
  String get actionToExtra => 'Passar a temporário';

  @override
  String get actionTransfer => 'Transferir a propriedade';

  @override
  String get actionRemove => 'Remover da empresa';

  @override
  String get positions => 'Funções';

  @override
  String get sites => 'Locais';

  @override
  String get positionsHint => 'O que a pessoa faz: caixa, cozinha, receção…';

  @override
  String get sitesHint =>
      'Onde decorre o turno, se a empresa tiver vários locais.';

  @override
  String get archived => 'Arquivado';

  @override
  String get archive => 'Arquivar';

  @override
  String get reactivate => 'Reativar';

  @override
  String weekOf(String date) {
    return 'Semana de $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alterações publicadas.',
      one: '1 alteração publicada.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Turno';

  @override
  String get display => 'Vista';

  @override
  String get week => 'Semana';

  @override
  String get month => 'Mês';

  @override
  String get today => 'Hoje';

  @override
  String get onlyMine => 'Só os meus turnos';

  @override
  String get replacePersonMenu => 'Substituir uma pessoa…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alterações por publicar',
      one: '1 alteração por publicar',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Os funcionários ainda não as veem.';

  @override
  String get publish => 'Publicar';

  @override
  String yourHours(String duration) {
    return 'As suas horas no período: $duration';
  }

  @override
  String get addShiftThisDay => 'Adicionar um turno neste dia';

  @override
  String get noShift => 'Sem turnos';

  @override
  String get unassigned => 'Não atribuído';

  @override
  String get formerMember => 'Antigo membro';

  @override
  String get statusDraft => 'Rascunho';

  @override
  String get statusModified => 'Alterado';

  @override
  String get statusDeleted => 'Eliminado';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes';
  }

  @override
  String get editShift => 'Editar o turno';

  @override
  String get newShift => 'Novo turno';

  @override
  String get thisShift => 'Este turno';

  @override
  String get thisAndFollowing => 'Este e os seguintes';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dias',
      one: 'Dia',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Outro dia';

  @override
  String get start => 'Início';

  @override
  String get end => 'Fim';

  @override
  String get endsNextDay => 'Termina no dia seguinte.';

  @override
  String get person => 'Pessoa';

  @override
  String get position => 'Função';

  @override
  String get site => 'Local';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get repetition => 'Repetição';

  @override
  String get repeatNone => 'Nenhuma';

  @override
  String get repeatDaily => 'Todos os dias';

  @override
  String get repeatWeekly => 'Todas as semanas';

  @override
  String get repeatForPrefix => 'Durante ';

  @override
  String get repeatDaysSuffix => ' dias';

  @override
  String get repeatWeeksSuffix => ' semanas';

  @override
  String get repeatUntilPrefix => 'Até ';

  @override
  String get replacePersonTitle => 'Substituir uma pessoa';

  @override
  String get replaceFrom => 'Substituir';

  @override
  String get replaceBy => 'Por';

  @override
  String dateRange(String from, String to) {
    return 'De $from a $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count turnos alterados.',
      one: '1 turno alterado.',
      zero: 'Nenhum turno alterado.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Substituir';

  @override
  String get joinHint =>
      'Dê este código ao seu responsável. Ele introduz-o na aplicação e você recebe um convite para aceitar.';

  @override
  String get codeExpired => 'Código expirado.';

  @override
  String codeValidFor(String time) {
    return 'Válido durante mais $time';
  }

  @override
  String get newCode => 'Novo código';

  @override
  String get language => 'Idioma';

  @override
  String get languageAuto => 'Automático (idioma do dispositivo)';

  @override
  String get syncUpToDate => 'Atualizado';

  @override
  String get syncOffline => 'Sem ligação';

  @override
  String syncPending(int count) {
    return 'Alterações pendentes: $count';
  }

  @override
  String get syncNow => 'Sincronizar';

  @override
  String syncRejected(String reason) {
    return 'Alteração recusada pelo servidor: $reason';
  }

  @override
  String get pendingBadge => 'Pendente';

  @override
  String get offlineUnavailable => 'Indisponível sem ligação.';

  @override
  String get offlineCached => 'Sem ligação: últimos dados guardados.';

  @override
  String get savedOffline =>
      'Guardado no dispositivo, será enviado quando a rede voltar.';

  @override
  String get notices => 'Avisos';

  @override
  String get noNotices => 'Nenhum aviso.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name substituiu a sua alteração ao turno de $date.';
  }

  @override
  String get history => 'Histórico';

  @override
  String get recentChanges => 'Últimas alterações';

  @override
  String get undoChange => 'Anular esta alteração';

  @override
  String get undoDone => 'Alteração anulada.';

  @override
  String get historyCreate => 'Criação';

  @override
  String get historyUpdate => 'Alteração';

  @override
  String get historyDelete => 'Eliminação';

  @override
  String get historyUndo => 'Anulação';

  @override
  String get noHistory => 'Nenhuma alteração.';

  @override
  String get pendingNotEditable =>
      'Este turno ainda não está sincronizado: tente de novo com ligação.';

  @override
  String get myQrCode => 'O meu código QR';

  @override
  String get myQrCodeHint =>
      'Um responsável lê este código para o adicionar à empresa; depois confirma. Nunca muda.';

  @override
  String get changeMyName => 'Alterar o meu nome';

  @override
  String get nameShownToTeam =>
      'Este nome é mostrado aos colegas em vez do seu nome Google.';

  @override
  String googleName(String name) {
    return 'Nome Google: $name';
  }

  @override
  String get useGoogleName => 'Usar o meu nome Google';

  @override
  String renameMemberTitle(String name) {
    return 'Mudar o nome de $name';
  }

  @override
  String get renameMemberHint => 'Este nome só é usado nesta empresa.';

  @override
  String get useOwnName => 'Usar o próprio nome';

  @override
  String get scanQrCode => 'Ler um código QR';

  @override
  String get scanQrHint =>
      'Aponte a câmara para o código QR mostrado na aplicação da pessoa (menu da conta, «O meu código QR»).';

  @override
  String get orEnterCode => 'Ou introduza o código de 6 dígitos';

  @override
  String get qrInvalid => 'Este não é um código QR do Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Câmara indisponível ($error).';
  }

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get notifChooseHint =>
      'Escolha sobre o que quer ser notificado. Tudo continua visível no sino.';

  @override
  String get notifPlanning => 'Horário publicado ou alterado';

  @override
  String get notifRequests => 'Pedidos: trocas, férias, convites';

  @override
  String get notifMessages => 'Novos avisos';

  @override
  String get notifOverlap => 'Turnos sobrepostos entre empresas';

  @override
  String get notifConflicts =>
      'As suas alterações substituídas por outro responsável';

  @override
  String get notifBilling => 'Lembretes de subscrição';

  @override
  String get pushEnabled => 'As notificações estão ativas neste dispositivo.';

  @override
  String get pushOff => 'As notificações estão desativadas neste dispositivo.';

  @override
  String get pushBlocked =>
      'As notificações estão bloqueadas: permita-as nas definições do telemóvel ou do navegador.';

  @override
  String get pushUnavailable =>
      'As notificações não estão disponíveis neste dispositivo.';

  @override
  String get enablePush => 'Ativar';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: o seu horário foi publicado ou alterado.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company quer adicioná-lo à equipa.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name propõe que se torne proprietário de $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name juntou-se a $company.';
  }

  @override
  String get translateAction => 'Traduzir';

  @override
  String get deleteAllNotices => 'Eliminar tudo';

  @override
  String get deleteAllNoticesConfirm => 'Eliminar todos os avisos?';

  @override
  String get noticeRetention => 'Eliminar avisos lidos após';

  @override
  String get retentionDay => '1 dia';

  @override
  String get retentionWeek => '1 semana';

  @override
  String get retentionMonth => '1 mês';

  @override
  String get billingOwnersOnly =>
      'Só ativo se for proprietário de uma empresa.';

  @override
  String get readOnlyPastDays =>
      'Os dias com mais de um mês são só de leitura.';

  @override
  String get wholeCompany => 'Toda a empresa';

  @override
  String get sitesLabel => 'Locais';

  @override
  String get actionSites => 'Locais…';

  @override
  String managerOf(String name) {
    return '$name é responsável por';
  }

  @override
  String teamSitesOf(String name) {
    return 'Equipa de $name';
  }

  @override
  String get notYourSite => 'Este local não está sob a sua responsabilidade.';

  @override
  String get chooseYourSite => 'Escolha pelo menos um local.';

  @override
  String get viewRequests => 'Pedidos';

  @override
  String get newRequest => 'Novo pedido';

  @override
  String get requestLeave => 'Férias';

  @override
  String get requestUnavailability => 'Indisponibilidade';

  @override
  String get requestSwap => 'Troca de turno';

  @override
  String get swapHint =>
      'Para propor uma troca, toque num dos seus próximos turnos no planeamento.';

  @override
  String get noRequests => 'Ainda não há pedidos.';

  @override
  String get requestsToHandle => 'A tratar';

  @override
  String get statusPendingPeer => 'À espera do colega';

  @override
  String get statusPendingManager => 'À espera do responsável';

  @override
  String get statusApproved => 'Aceite';

  @override
  String get statusRefused => 'Recusado';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get cancelRequest => 'Cancelar o pedido';

  @override
  String get acceptSwap => 'Ficar com este turno';

  @override
  String get approve => 'Validar';

  @override
  String periodLabel(String from, String to) {
    return 'De $from a $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Proposto a $name';
  }

  @override
  String get swapToTeam => 'Toda a equipa';

  @override
  String everyWeekdays(String days) {
    return 'Todas as semanas: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dias em que nunca está disponível:';

  @override
  String get choosePeriod => 'Escolher datas';

  @override
  String get choosePeriodOptional => 'Limitar a um período (opcional)';

  @override
  String get clearPeriod => 'Sem período';

  @override
  String get sendRequest => 'Enviar o pedido';

  @override
  String get proposeSwap => 'Propor uma troca';

  @override
  String get swapWith => 'Propor a';

  @override
  String get swapSteps =>
      'O colega aceita e depois um responsável valida. O planeamento só muda depois.';

  @override
  String get absentThatDay => 'Ausência validada nesse dia';

  @override
  String get requestSent => 'Pedido enviado.';

  @override
  String noticeSwapOffer(String name) {
    return '$name propõe-lhe um dos seus turnos.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name recusou a sua proposta de troca.';
  }

  @override
  String get noticeSwapToApprove =>
      'Uma troca de turno aguarda a sua validação.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name pede férias.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name indica que está indisponível.';
  }

  @override
  String get noticeRequestApproved => 'O seu pedido foi aceite.';

  @override
  String get noticeRequestRefused => 'O seu pedido foi recusado.';

  @override
  String get choosePeer => 'Quem fica com este turno?';

  @override
  String get discardAll => 'Anular tudo';

  @override
  String get notifySitesHint =>
      'Escolha os locais dos quais recebe notificações de pedidos. Todos os pedidos continuam visíveis na lista.';

  @override
  String get pendingRequestTooltip => 'Pedido pendente: toque para abrir';

  @override
  String get requestsHistory => 'Todos os pedidos';

  @override
  String get revertChange => 'Anular esta alteração';

  @override
  String get statusExpired => 'Sem efeito';

  @override
  String get swapWithHint => 'Toque para escolher um colega específico';

  @override
  String changesDiscarded(String count) {
    return 'Alterações anuladas: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Anular as $count alterações não publicadas?';
  }

  @override
  String get allSchedules => 'Todos os meus planeamentos';

  @override
  String get busyElsewhere => 'Já está de serviço noutra empresa neste horário';

  @override
  String get overlapTooltip => 'Sobrepõe-se a um turno de outra empresa';

  @override
  String get overlapWarning =>
      'Alguns dos seus turnos em duas empresas sobrepõem-se.';

  @override
  String noticeOverlap(String date) {
    return 'Dois dos seus turnos em empresas diferentes sobrepõem-se a $date.';
  }

  @override
  String get allMyCompanies => 'Todas as minhas empresas';

  @override
  String get openRequest => 'Ver o pedido';

  @override
  String get thisCompany => 'Esta empresa';

  @override
  String get withExtras => 'Com os extras';

  @override
  String reinforcementHint(String company) {
    return 'Vem de $company: será adicionado como reforço e avisado.';
  }

  @override
  String get addToGoogle => 'Adicionar ao Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizar os meus turnos';

  @override
  String get changeSettings => 'Modificar';

  @override
  String get countryBelgium => 'Bélgica';

  @override
  String get countryCanada => 'Canadá';

  @override
  String get countryFrance => 'França';

  @override
  String get countrySwitzerland => 'Suíça';

  @override
  String get employeesSection => 'Funcionários';

  @override
  String get emptyNoAlert => 'Vazio: sem alerta';

  @override
  String get extrasSection => 'Extras';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'Totais de horas';

  @override
  String get legalAlerts => 'Alertas legais';

  @override
  String get legalAlertsHint =>
      'Avisos, nunca bloqueios. Escolha as regras que se aplicam a si, ou nenhuma.';

  @override
  String get legalPreset => 'Modelo por país';

  @override
  String get maxConsecutiveLabel => 'Máximo de dias de trabalho seguidos';

  @override
  String get maxDayLabel => 'Duração máxima por dia (horas)';

  @override
  String get maxWeekLabel => 'Duração máxima por semana (horas)';

  @override
  String get minRestLabel => 'Descanso mínimo entre turnos (horas)';

  @override
  String get noLegalRules => 'Nenhum alerta escolhido.';

  @override
  String get presetNone => 'Nenhum';

  @override
  String get presetsCheck =>
      'Os modelos são um ponto de partida: verifique-os segundo o seu país e a sua convenção coletiva.';

  @override
  String get printMine => 'O meu planeamento';

  @override
  String get printOwn => 'Apenas o próprio planeamento';

  @override
  String get printPdf => 'Imprimir / PDF';

  @override
  String get printRights => 'O que os funcionários podem imprimir';

  @override
  String get printTeam => 'O planeamento de toda a equipa';

  @override
  String get printTeamOption => 'O planeamento da equipa';

  @override
  String get totalsHint =>
      'Rascunhos incluídos. As exportações Excel e CSV usam o planeamento publicado.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dias seguidos (máximo $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value no dia (máximo $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: apenas $value de descanso (mínimo $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value na semana (máximo $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Alertas legais: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Turnos: $count';
  }

  @override
  String get actionMakeDeputy => 'Nomear sub-responsável';

  @override
  String get actionRemoveDeputy => 'Retirar o papel de sub-responsável';

  @override
  String get busyHere => 'Já está de serviço na empresa neste horário';

  @override
  String get calendarDenied =>
      'Acesso ao calendário recusado. Permita-o nas definições do telefone.';

  @override
  String get calendarLinkHint =>
      'Adicione a partir do Google Calendar num computador; o Google atualiza-o em algumas horas.';

  @override
  String get calendarNone => 'Nenhum calendário editável neste telefone.';

  @override
  String get calendarOnPhoneHint =>
      'No seu calendário Google: visível de imediato, no telefone e no Google Calendar.';

  @override
  String get chooseCalendar => 'Escolher o calendário';

  @override
  String get otherSiteHint =>
      'Funcionário de outro local: os responsáveis dele serão avisados.';

  @override
  String get subManager => 'Sub-responsável';

  @override
  String calendarSynced(String count) {
    return 'Turnos no calendário: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Sub-responsável: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by colocou $name no local $site a $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company adicionou-o como reforço.';
  }

  @override
  String get companyNotificationsHint =>
      'Desativadas: nada toca neste telefone, mas tudo fica no sino.';

  @override
  String get companyNotificationsOn => 'Receber as notificações desta empresa';

  @override
  String get companyTimezone => 'Fuso horário da empresa';

  @override
  String get companyTimezoneHint =>
      'Todos os horários desta empresa estão neste fuso (hora de verão incluída). Os calendários convertem-nos automaticamente.';

  @override
  String get iosInstallHint =>
      'No iPhone: toque em Partilhar e depois em «Adicionar ao ecrã principal» para instalar o Staff Flow.';

  @override
  String get searchCity => 'Procurar uma cidade';

  @override
  String get thisPhone => 'Este dispositivo';

  @override
  String companyNotifications(String name) {
    return 'Notificações: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Horários na hora de $zone ($company). O seu dispositivo: $here.';
  }

  @override
  String get addPreset => 'Adicionar a predefinição';

  @override
  String get addPresets => 'Criar predefinições';

  @override
  String get appearance => 'Aparência';

  @override
  String get chooseLogo => 'Escolher uma imagem PNG';

  @override
  String get customization => 'Personalização';

  @override
  String get editPresets => 'Predefinições';

  @override
  String get enable => 'Reativar';

  @override
  String get logoHint =>
      'Uma pequena imagem PNG (o seu logótipo) mostrada no separador da empresa, para todos os membros.';

  @override
  String get logoPngOnly => 'Escolha uma imagem PNG de 1 MB no máximo.';

  @override
  String get myIdentifier => 'O meu identificador';

  @override
  String get myProfile => 'O meu perfil';

  @override
  String get presetName => 'Nome (ex. Manhã)';

  @override
  String get removeLogo => 'Retirar a imagem';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get shiftPresets => 'Predefinições de horários';

  @override
  String get shiftPresetsHint =>
      'Horários prontos (manhã, tarde, noite…): um toque num turno preenche o início e o fim.';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get awaitingApproval => 'Por aprovar';

  @override
  String get placementNeedsApproval =>
      '! Esta pessoa não é dos seus locais: o turno aguardará a aprovação do seu superior ou do dono antes de poder ser publicado. Caso contrário, escolha outra pessoa.';

  @override
  String get placementAwaiting =>
      'Aguardando aprovação de um superior ou do dono.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by quer escalar $name, de outro local, em $date: requer aprovação.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by aprovou a escala de $name em $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by recusou a escala de $name em $date.';
  }

  @override
  String get addSubSite => 'Adicionar um sublocal';

  @override
  String get moveSite => 'Mover';

  @override
  String get topLevel => 'Primeiro nível';

  @override
  String moveSiteTitle(String name) {
    return 'Mover “$name” para baixo de…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sublocal de $name';
  }

  @override
  String get siteTreeHint =>
      'Até 10 níveis, por exemplo Região › Cidade › Loja. Os 3 primeiros estão incluídos na assinatura; além disso, é preciso a opção «Locais em cascata». O responsável de um local gere também tudo o que está abaixo.';

  @override
  String get subSitesOnlyHint =>
      'Aqui adiciona sublocais abaixo dos seus próprios locais.';

  @override
  String get messagingSetting => 'Mural de notícias';

  @override
  String get messagingSettingHint =>
      'Ativado: o proprietário e os responsáveis publicam avisos (para todos, um cargo, um local ou pessoas escolhidas); todos os leem e podem traduzi-los. Desativado: a aba desaparece para todos.';

  @override
  String get billingTitle => 'Subscrição';

  @override
  String billingStatusTrial(String date) {
    return 'Teste gratuito até $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Pago até $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Só de leitura: sem pagamento, a empresa será eliminada a $date.';
  }

  @override
  String get billingStatusComped => 'Oferecida';

  @override
  String billingStaff(String count) {
    return '$count funcionários e responsáveis (sem o proprietário nem os extras)';
  }

  @override
  String get billingMonthly => 'Mensal';

  @override
  String billingYearly(String months) {
    return 'Anual ($months meses faturados)';
  }

  @override
  String get billingCascade => 'Opção «Locais em cascata» (níveis 4 a 10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Incluída a partir de $count funcionários';
  }

  @override
  String billingPay(String amount) {
    return 'Pagar $amount';
  }

  @override
  String get billingTestNotice => 'Pagamento de teste: nada é cobrado.';

  @override
  String get billingSoon => 'O pagamento online chega em breve.';

  @override
  String get billingPaidOk => 'Pagamento registado.';

  @override
  String get billingInvoices => 'Faturas';

  @override
  String get billingNoInvoices => 'Ainda não há faturas.';

  @override
  String get billingManage => 'Gerir a subscrição';

  @override
  String get billingReadOnlyStaff =>
      'Esta empresa está só de leitura até o proprietário renovar a subscrição.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / mês';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / ano';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: o teste gratuito termina em menos de 24 horas.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company está só de leitura por falta de pagamento; eliminação a $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Lembrete: sem pagamento, $company será eliminada a $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company foi eliminada por falta de pagamento.';
  }

  @override
  String billingCompanyId(String id) {
    return 'ID da empresa: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Hoje: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Inclui o resto do mês em curso ($days dias, proporcional) e depois meses completos a partir do dia 1.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Ainda não vinculado. Serve para verificar sua identidade, por exemplo para trocar de conta Google.';

  @override
  String telegramLinked(String name) {
    return 'Vinculado: $name';
  }

  @override
  String get telegramNoUsername => 'sem nome de usuário';

  @override
  String get telegramLink => 'Vincular meu Telegram';

  @override
  String get telegramLinkHint =>
      'O Telegram abre: toque em “Iniciar” e volte aqui.';

  @override
  String get telegramUnlink => 'Desvincular';

  @override
  String get telegramUnavailable => 'O Telegram ainda não está disponível.';

  @override
  String get telegramShowIn => 'Mostrar meu Telegram em:';

  @override
  String get newQrCode => 'Trocar QR code';

  @override
  String get newQrCodeConfirm =>
      'Seu QR code antigo e seu identificador antigo deixarão de funcionar. Seu lugar nas empresas não muda.';

  @override
  String get newQrCodeDone => 'Novo QR code criado.';

  @override
  String get changeGoogle => 'Trocar de conta Google';

  @override
  String get changeGoogleSub => 'Mesma conta, mesmo número, mesmas empresas';

  @override
  String changeGoogleSteps(String id) {
    return '1. Vincule seu Telegram neste perfil (obrigatório).\n2. Saia e entre com a nova conta Google.\n3. Escolha “Já tenho uma conta Staff Flow” e digite seu identificador $id.\n4. Digite o código recebido no Telegram.\nSua conta, seu número e suas empresas continuam os mesmos.';
  }

  @override
  String get recoverAccount => 'Já tenho uma conta Staff Flow';

  @override
  String get recoverHint =>
      'Digite o identificador da sua conta antiga (SF-…). Um código será enviado ao Telegram vinculado a essa conta.';

  @override
  String get recoverIdLabel => 'Identificador (SF-…)';

  @override
  String get recoverSend => 'Enviar o código';

  @override
  String get recoverCodeSent => 'Código enviado pelo Telegram.';

  @override
  String get recoverCodeLabel => 'Código recebido (6 dígitos)';

  @override
  String get recoverConfirm => 'Recuperar minha conta';

  @override
  String get recoverDone => 'Pronto: você voltou à sua conta.';

  @override
  String get exportData => 'Exportar meus dados';

  @override
  String get exportDataSub => 'Um arquivo com todos os seus dados pessoais';

  @override
  String get deleteAccount => 'Excluir minha conta';

  @override
  String get deleteGhost => 'Excluir mantendo um fantasma';

  @override
  String get deleteGhostHint =>
      'Você sai de todas as empresas. Entre mais tarde com a mesma conta Google para recuperar sua conta e seu número.';

  @override
  String get deleteErase => 'Apagar tudo definitivamente';

  @override
  String get deleteEraseHint =>
      'Nome, e-mail, foto, Telegram, mensagens e notificações são apagados. Não é possível desfazer.';

  @override
  String get deleteGhostNote =>
      'Em ambos os casos, o histórico das empresas mantém um “Ghost” anônimo no seu lugar (pedidos de folga, turnos passados…) para que o proprietário e os responsáveis possam rastrear os eventos.';

  @override
  String get deleteOwnerNote =>
      'É proprietário de uma empresa? Transfira-a primeiro ou deixe a assinatura terminar.';

  @override
  String get deleteConfirmButton => 'Excluir';

  @override
  String get accountRestored => 'Bem-vindo de volta! Sua conta foi reativada.';

  @override
  String get closedInvoices => 'Faturas de empresas encerradas';

  @override
  String get downloadAllInvoices => 'Baixar todas as faturas (ZIP)';

  @override
  String get legalTerms => 'Termos de uso e de venda';

  @override
  String get legalPrivacy => 'Política de privacidade';

  @override
  String get billingDetailTitle => 'Detalhes do pagamento';

  @override
  String billingLineProrata(String days, String total) {
    return 'Resto do mês atual ($days dias de $total): assinatura';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Resto do mês atual ($days dias de $total): opção “locais aninhados”';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Assinatura, $staff lugares: 1 mês';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Assinatura, $staff lugares: 12 meses pelo preço de $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Opção “locais aninhados”: $months meses, sem desconto';
  }

  @override
  String get billingTotal => 'Total';

  @override
  String billingCovers(String from, String to) {
    return 'Período coberto: de $from a $to';
  }

  @override
  String get billingGraceInvoices =>
      'Esta empresa não será renovada: baixe já todas as faturas.';

  @override
  String get billingYearLabel => 'Ano';

  @override
  String get sitesNoneChosen => 'Nenhum local escolhido';

  @override
  String get avatarTitle => 'Meu avatar';

  @override
  String get avatarSub => 'Uma imagem no lugar da sua foto';

  @override
  String get avatarUseGoogle => 'Usar minha foto do Google';

  @override
  String get avatarColor => 'Cor';

  @override
  String get hidePhotosTitle => 'Ocultar as fotos do Google';

  @override
  String get hidePhotosSub =>
      'Nesta empresa, cada pessoa aparece com seu avatar ou sua inicial.';

  @override
  String get billingApi => 'Opção “acesso API”';

  @override
  String billingLineApi(String months) {
    return 'Opção “acesso API”: $months meses, sem desconto';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Resto do mês atual ($days dias de $total): opção “acesso API”';
  }

  @override
  String get apiTitle => 'Acesso API (contabilidade, CRM)';

  @override
  String get apiSub =>
      'Os seus programas (salários, contabilidade, CRM, planeamento) leem o horário publicado, as horas e as ausências; com «API Pro» também enviam horários, funcionários e avisos.';

  @override
  String get apiNeedsOption =>
      'Opção paga: adicione «Acesso API» ou «API Pro» em «Gerir a assinatura».';

  @override
  String get apiNewKey => 'Nova chave';

  @override
  String get apiKeyName => 'Nome da chave (ex.: programa de folha)';

  @override
  String get apiKeyCreated =>
      'Copie esta chave agora e guarde-a em segurança: ela não será mostrada novamente.';

  @override
  String get apiKeyCopy => 'Copiar';

  @override
  String get apiKeyCopied => 'Chave copiada.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Último uso: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Nunca usada';

  @override
  String get apiRevoke => 'Revogar';

  @override
  String get apiRevokeConfirm =>
      'Os programas que usam esta chave perderão o acesso.';

  @override
  String get apiDocs => 'Documentação da API';

  @override
  String get memberGoogleLink => 'Reconexão Google do funcionário';

  @override
  String googleLinkHint(String name) {
    return 'Envie este link para $name. Ele abre em um navegador (não no aplicativo Android), uma única vez, durante 24 horas: $name entra com a nova conta Google e recupera a conta. Todos os outros dispositivos são então desconectados.';
  }

  @override
  String get googleLinkCopied => 'Link copiado.';

  @override
  String get switchBanner =>
      'Link de troca de conta Google: entre com sua nova conta Google para recuperar sua conta Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Este link vincula uma conta Staff Flow a uma nova conta Google. Saia primeiro e depois entre com a nova conta Google.';

  @override
  String get switchDone =>
      'Pronto: sua conta Staff Flow está vinculada a esta conta Google. Seus outros dispositivos foram desconectados.';

  @override
  String changeGoogleBot(String bot) {
    return 'O mais simples: no Telegram, envie /changegoogle ao bot $bot e siga as instruções; depois entre com a nova conta Google em até 10 minutos.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Sem Telegram: peça ao proprietário ou a um responsável um link de troca de conta Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name criou um link para vincular sua conta a uma nova conta Google. Se você não pediu isso, avise seu responsável.';
  }

  @override
  String get sessionRevoked =>
      'Você foi desconectado: sua conta agora está vinculada a outra conta Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Dica: envie /connexion ao bot $bot para receber um link e abrir o Staff Flow num navegador, sem o aplicativo nem conta Google.';
  }

  @override
  String get timeFormat => 'Formato da hora';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Pessoas';

  @override
  String get sortNatural => 'Ordem habitual';

  @override
  String get sortName => 'Nome';

  @override
  String get employeeNumber => 'Número de funcionário';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Pesquisar';

  @override
  String get pickSearchPeople =>
      'Pesquisar: nome, número de funcionário, ID SF';

  @override
  String get pickSortTitle => 'Ordenar e mostrar por';

  @override
  String pickSelected(String count) {
    return 'Marcados: $count';
  }

  @override
  String get pickCheckAll => 'Marcar todos';

  @override
  String get pickClear => 'Desmarcar todos';

  @override
  String get pickNoResult => 'Nenhum resultado';

  @override
  String get pickMultiHint =>
      'Marque várias pessoas: será criado um turno para cada uma, tudo de uma vez.';

  @override
  String get filterAll => 'Todos';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Sem cargo';

  @override
  String get noSiteGroup => 'Sem local';

  @override
  String get groupByTitle => 'Agrupar por';

  @override
  String get groupRole => 'Função';

  @override
  String get groupNone => 'Sem agrupamento';

  @override
  String showMore(String count, String left) {
    return 'Mostrar mais $count (faltam $left)';
  }

  @override
  String get findByQr => 'Encontrar um membro pelo QR code';

  @override
  String get qrNotMember =>
      'Este QR code não corresponde a ninguém nesta empresa.';

  @override
  String get memberProfile => 'Número de funcionário e cargo';

  @override
  String get employeeNumberHint =>
      'Número próprio da sua empresa (opcional). O ID Staff Flow continua atribuído.';

  @override
  String get usualPosition => 'Cargo habitual';

  @override
  String get inviteCodeTitle => 'Código de convite';

  @override
  String get inviteCodeHint =>
      'Digite o código recebido do seu empregador ou escaneie o QR code do seu convite.';

  @override
  String inviteJoined(String company) {
    return 'Você entrou em $company.';
  }

  @override
  String get importTitle => 'Importar funcionários';

  @override
  String get importIntro =>
      'Importe a sua lista de funcionários de um ficheiro Excel ou CSV. Cada um recebe um código e um QR code pessoais: ativa a conta com uma aplicação 2FA (ou com o Google). Ninguém é adicionado sem consentimento.';

  @override
  String get importTemplate => 'Baixar o modelo Excel';

  @override
  String get importTemplateHint =>
      'Colunas: nome, número de funcionário, cargo, local. Só o nome é obrigatório.';

  @override
  String get importChooseFile => 'Escolher um arquivo (.xlsx ou .csv)';

  @override
  String importNew(String count) {
    return 'Novos: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Atualizados: $count';
  }

  @override
  String importSkip(String count) {
    return 'Já convidados: $count';
  }

  @override
  String importErrors(String count) {
    return 'Erros: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importar ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'As linhas com erro serão ignoradas: corrija-as no arquivo e importe-o novamente.';

  @override
  String get importCreated => 'novo';

  @override
  String importDone(String count) {
    return 'Convites criados: $count';
  }

  @override
  String get invitesTitle => 'Convites pendentes';

  @override
  String get invitesPrint => 'Imprimir os códigos';

  @override
  String get inviteShowHint =>
      'A pessoa escolhe «Ativar a minha conta» no ecrã de entrada (ou «Tenho um código de convite» se já tiver conta) e depois lê este QR code ou digita este código. Válido 90 dias, uma única vez.';

  @override
  String invitesHint(String count) {
    return 'Convites pendentes: $count. Toque numa pessoa para mostrar o código e o QR code, ou imprima todos.';
  }

  @override
  String get inviteSeenByEmail => 'convite visto (e-mail)';

  @override
  String get invitesNone => 'Nenhum convite pendente.';

  @override
  String get haveInviteCode => 'Tenho um código de convite';

  @override
  String get newsTab => 'Notícias';

  @override
  String get newsNew => 'Novo aviso';

  @override
  String get newsEmpty => 'Ainda não há avisos.';

  @override
  String get newsEmptyManager =>
      'Ainda não há avisos. Publique o primeiro: para toda a empresa, um cargo, um local ou pessoas escolhidas.';

  @override
  String get newsOlder => 'Avisos anteriores';

  @override
  String get newsEdited => 'editado';

  @override
  String get newsEdit => 'Editar o aviso';

  @override
  String get newsDeleteTitle => 'Remover este aviso?';

  @override
  String get newsForEveryone => 'Para todos';

  @override
  String get newsEveryoneMySites => 'Todos nos meus locais';

  @override
  String newsFor(String names) {
    return 'Para: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Lido por $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Lido por $count de $total';
  }

  @override
  String get newsTranslated => 'Traduzido automaticamente';

  @override
  String get newsTitleField => 'Título (opcional)';

  @override
  String get newsBodyField => 'Texto do aviso';

  @override
  String get newsRecipients => 'Destinatários';

  @override
  String get newsTargetHint =>
      'Marque um ou mais grupos: o aviso vai para cada pessoa que corresponda a algum deles.';

  @override
  String get newsPublish => 'Publicar';

  @override
  String newsSent(String count) {
    return 'Aviso enviado a $count pessoa(s).';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Opção «Acesso API», adicionada durante a assinatura, de $from a $to: $months meses, sem desconto';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Opção «Locais em cascata», adicionada durante a assinatura, de $from a $to: $months meses, sem desconto';
  }

  @override
  String get billingRenewalOptions =>
      'As opções marcadas serão incluídas nas suas próximas renovações. Uma opção desmarcada continua ativa até o fim do período já pago.';

  @override
  String billingAddonTitle(String option) {
    return 'Adicionar agora: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'O mês atual inteiro e depois cada mês até $date (fim do período pago), sem desconto. A opção fica ativa logo após o pagamento e é incluída nas renovações seguintes.';
  }

  @override
  String get billingAddonInvoice => 'opção';

  @override
  String billingAccessRemoved(String name) {
    return '$name já não gere a assinatura.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name agora pode gerir a assinatura e as faturas.';
  }

  @override
  String get actionBillingRemove => 'Retirar a gestão da assinatura';

  @override
  String get actionBillingGive => 'Permitir gerir a assinatura';

  @override
  String get billingAccessTag => 'Gere a assinatura';

  @override
  String get billingOptionRenewed => 'Renovação da opção retomada.';

  @override
  String get billingOptionStopped =>
      'Opção não renovada: continua ativa até o fim do período pago.';

  @override
  String billingOptionEnds(String date) {
    return 'Ativa até $date, não será renovada (marque para mantê-la)';
  }

  @override
  String get billingOptionActive =>
      'Ativa e renovada (desmarque para não renová-la)';

  @override
  String get statusCancelRequested => 'Cancelamento pedido';

  @override
  String get requestEndedEarly => 'Terminada mais cedo pela pessoa.';

  @override
  String get confirmCancelRequest =>
      'Cancelar este pedido? Os responsáveis deixarão de o ver.';

  @override
  String get endUnavailability => 'Terminar a minha indisponibilidade';

  @override
  String get confirmEndUnavailability =>
      'Terminar a sua indisponibilidade? Ficará disponível de novo a partir de hoje e os responsáveis serão avisados.';

  @override
  String get askLeaveCancel => 'Pedir o cancelamento destas férias';

  @override
  String get confirmAskLeaveCancel =>
      'Pedir o cancelamento destas férias? Um responsável terá de o aprovar; até lá, as férias continuam previstas.';

  @override
  String get refuseLeaveCancel => 'Recusar o cancelamento';

  @override
  String get acceptLeaveCancel => 'Aceitar o cancelamento';

  @override
  String get requestsSearchHint =>
      'Pesquisar: nome, número de funcionário, ID SF, nota';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterState => 'Estado';

  @override
  String get statePending => 'Pendentes';

  @override
  String get stateClosed => 'Recusados ou cancelados';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Lugares adicionados, de $from para $to, de $start a $end: $months meses, sem desconto';
  }

  @override
  String billingSeats(String used, String limit) {
    return '$used lugares pagos · até $limit pessoas com a margem de 5%';
  }

  @override
  String get billingSeatsTitle => 'Número de lugares';

  @override
  String get billingSeatsHint =>
      'Funcionários e responsáveis (sem o proprietário nem os extras), em blocos de 10. 10 lugares na criação; acima disso, margem de 5% e depois não é possível adicionar.';

  @override
  String get billingSeatsUnit => 'lugares';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Lugares: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'De $min a 5000, em blocos de 10.';
  }

  @override
  String get printWeek => 'Semana';

  @override
  String get printMonth => 'Mês';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Manter a sessão neste dispositivo';

  @override
  String get rememberMeHint =>
      'Ativado: como com o Google, sem código sempre que abre a aplicação. Evite num dispositivo partilhado.';

  @override
  String get totpLoginTitle => 'Entrada 2FA';

  @override
  String get totpLoginHint =>
      'Introduza o seu identificador Staff Flow (SF-…) ou o seu número de funcionário e depois o código de 6 dígitos da sua aplicação de autenticação.';

  @override
  String get totpLoginField => 'ID SF ou número de funcionário';

  @override
  String get totpCompanyCode => 'Código da empresa';

  @override
  String get totpCompanyCodeHint =>
      '6 caracteres dados pelo seu empregador (só com número de funcionário).';

  @override
  String get totpBackupCode => 'Código de recuperação';

  @override
  String get totpCode => 'Código da aplicação';

  @override
  String get totpUseApp => 'Usar a aplicação 2FA';

  @override
  String get totpUseBackup => 'Usar um código de recuperação';

  @override
  String get totpSignIn => 'Entrar';

  @override
  String get totpLostPhone =>
      'Perdeu o telefone ou apagou a aplicação? Peça ao seu responsável um novo código de ativação.';

  @override
  String get activateTitle => 'Ativar a minha conta';

  @override
  String get activateStep1 => 'Passo 1: o seu código de convite';

  @override
  String get activateStep1Hint =>
      'Leia o QR code dado pelo seu empregador ou digite o código escrito por baixo.';

  @override
  String get activateScan => 'Ler o QR code';

  @override
  String get activateCodeField => 'Código de convite';

  @override
  String get activateContinue => 'Continuar';

  @override
  String activateHello(String name, String company) {
    return 'Olá, $name · $company';
  }

  @override
  String get activateStep2 =>
      'Passo 2: ligue uma aplicação de autenticação (Google Authenticator, Microsoft Authenticator…). Ela dará um código de 6 dígitos sempre que entrar.';

  @override
  String get activateOpenApp => 'Adicionar à minha aplicação de autenticação';

  @override
  String get activateOrScan =>
      'Ou, noutro dispositivo, leia este QR code com a aplicação:';

  @override
  String get activateManualKey => 'Chave para digitar à mão:';

  @override
  String get activateFirstCode => 'Primeiro código mostrado pela aplicação';

  @override
  String get activateDone => 'Ativar';

  @override
  String get totpReadyTitle => 'A sua conta está pronta';

  @override
  String get totpYourId => 'O seu identificador Staff Flow:';

  @override
  String get totpBackupHint =>
      'Códigos de recuperação (cada um serve uma vez): anote-os ou guarde-os num local seguro. Servem se já não tiver a aplicação.';

  @override
  String get totpBackupSaved => 'Anotado';

  @override
  String get linkGoogleTitle => 'Ligar uma conta Google';

  @override
  String get linkGoogleHint =>
      'Para criar uma empresa, ligue uma conta Google à sua conta Staff Flow. Serve apenas para proteger o criador da empresa e a sua assinatura: o seu endereço Google nunca é mostrado aos seus funcionários nem a ninguém, fica no Staff Flow. Continuará a poder entrar com a sua aplicação 2FA.';

  @override
  String get linkGoogleButton => 'Ligar a minha conta Google';

  @override
  String get linkGoogleBanner =>
      'Entre com a conta Google a ligar à sua conta Staff Flow.';

  @override
  String get totpLoginButton => 'Entrar com uma aplicação 2FA';

  @override
  String get activateButton => 'Ativar a minha conta (código do empregador)';

  @override
  String get activationCodeAction => 'Novo código de ativação';

  @override
  String activationCodeTitle(String name) {
    return 'Novo código para $name?';
  }

  @override
  String get activationCodeConfirm =>
      'O telefone e a aplicação 2FA antigos deixarão de funcionar. A pessoa volta a ativar a conta com este código (válido 7 dias).';

  @override
  String get activationCodeHint =>
      'A pessoa escolhe «Ativar a minha conta» no ecrã de entrada e depois lê este QR code ou digita este código.';

  @override
  String get signupTitle => 'Criar uma conta';

  @override
  String get signupStep1 => 'Passo 1: o seu nome';

  @override
  String get signupStep1Hint =>
      'O nome que os seus colegas e empregadores verão. Sem Google nem e-mail: a sua conta é protegida por uma aplicação de autenticação.';

  @override
  String get signupName => 'Nome e apelido';

  @override
  String signupHello(String name) {
    return 'Olá, $name';
  }

  @override
  String get signupButton => 'Criar uma conta com uma aplicação 2FA';

  @override
  String get totpCardTitle => 'Entrada com uma aplicação 2FA';

  @override
  String totpCardLocal(String id) {
    return 'A sua conta entra com uma aplicação de autenticação. Identificador: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Ativa: também pode entrar com o seu identificador $id e o código da aplicação, sem Google.';
  }

  @override
  String get totpCardOff =>
      'Prepare uma aplicação de autenticação para poder entrar sem Google (ID SF + código de 6 dígitos).';

  @override
  String get totpEnable => 'Ativar';

  @override
  String get totpDisable => 'Remover';

  @override
  String get totpEnableTitle => 'Ativar a entrada 2FA';

  @override
  String get totpEnabledTitle => 'Entrada 2FA pronta';

  @override
  String get totpDisableConfirm =>
      'Remover a entrada com a aplicação 2FA? Só entrará com o Google.';

  @override
  String get googlePrivacyNote =>
      'A sua conta Google serve apenas para proteger a empresa e a sua assinatura: nunca é mostrada aos seus funcionários nem a ninguém.';

  @override
  String get scopeRead =>
      'Leitura: horário publicado, horas, ausências, funcionários';

  @override
  String get scopeShifts => 'Horário: criar, alterar, eliminar turnos';

  @override
  String get scopePublish => 'Publicar o horário';

  @override
  String get scopeMembers => 'Funcionários: importar, número e cargo';

  @override
  String get scopeCatalog => 'Cargos e locais';

  @override
  String get scopeNews => 'Avisos';

  @override
  String get scopeRequests => 'Pedidos: aprovar ou recusar';

  @override
  String get apiScopesTitle => 'Direitos da chave';

  @override
  String get apiProNeeded =>
      'Os direitos de escrita exigem a opção «API Pro» (assinatura paga).';

  @override
  String billingLinePro(String months) {
    return 'Opção «API Pro»: $months meses';
  }

  @override
  String billingLineProAddon(String start, String end, String months) {
    return 'Opção «API Pro», adicionada durante a assinatura, de $start a $end: $months meses, sem desconto';
  }

  @override
  String get billingApiPro => 'Opção «API Pro»';

  @override
  String billingApiProHint(String price) {
    return '«API Pro» ($price / mês, sem desconto): os seus programas escrevem no Staff Flow (horário, funcionários, avisos, pedidos). Disponível com assinatura paga: adicione-a abaixo.';
  }

  @override
  String get whTitle => 'Webhooks';

  @override
  String get whSub =>
      'O Staff Flow avisa os seus programas sozinho quando algo acontece: horário publicado, pedido, novo funcionário, aviso. Incluído na opção «API Pro».';

  @override
  String get whNew => 'Novo webhook';

  @override
  String get whUrl => 'Endereço (https://…)';

  @override
  String get whEvents => 'Eventos enviados';

  @override
  String get whCreated =>
      'Segredo de assinatura, mostrado uma só vez: o seu programa usa-o para verificar que cada envio vem mesmo do Staff Flow.';

  @override
  String get whTest => 'Experimentar';

  @override
  String whTestOk(String status) {
    return 'Recebido (código $status)';
  }

  @override
  String whTestFail(String error) {
    return 'Falha: $error';
  }

  @override
  String get whDisabled => 'Desativado após 10 envios falhados seguidos';

  @override
  String get whEnable => 'Reativar';

  @override
  String get whDelete => 'Eliminar';

  @override
  String get whDeleteConfirm =>
      'Este webhook deixará de receber o que quer que seja.';

  @override
  String get whNone => 'Ainda não há webhooks.';

  @override
  String whLast(String date, String status) {
    return 'Último envio: $date · $status';
  }

  @override
  String get whEvSchedulePublished => 'Horário publicado';

  @override
  String get whEvRequestCreated => 'Novo pedido';

  @override
  String get whEvRequestDecided => 'Pedido aprovado ou recusado';

  @override
  String get whEvRequestCancelled => 'Pedido cancelado';

  @override
  String get whEvRequestCancelAsked => 'Anulação de férias pedida';

  @override
  String get whEvRequestCancelDecided => 'Anulação de férias decidida';

  @override
  String get whEvRequestEnded => 'Indisponibilidade terminada';

  @override
  String get whEvMemberJoined => 'Novo funcionário';

  @override
  String get whEvAnnouncementPublished => 'Aviso publicado';

  @override
  String get whStDelivered => 'recebido';

  @override
  String get whStPending => 'pendente';

  @override
  String get whStFailed => 'falha';

  @override
  String get whStDropped => 'descartado';

  @override
  String get lgTitle => 'Registos';

  @override
  String get lgSub =>
      'Cada chamada das suas chaves API e do assistente MCP, e cada envio de webhook. Deslize para mudar de mês.';

  @override
  String get lgSearch => 'Pesquisar: pessoa, número, ação…';

  @override
  String get lgAllHistory =>
      'Pesquisar em todo o histórico (arquivos incluídos)';

  @override
  String get lgArchived => 'Mês arquivado';

  @override
  String get lgNone => 'Nada neste mês.';

  @override
  String get lgMore => 'Mostrar mais';

  @override
  String get lgExport => 'Transferir um ano (ZIP)';

  @override
  String get lgAllKeys => 'Todas as chaves';

  @override
  String get lgSourceApi => 'API';

  @override
  String get lgSourceMcp => 'Assistente MCP';

  @override
  String get lgSourceWebhook => 'Webhook';

  @override
  String get lgKindRead => 'Leitura';

  @override
  String get lgKindWrite => 'Escrita';

  @override
  String get lgOk => 'Com êxito';

  @override
  String get lgError => 'Falha';

  @override
  String get lgBefore => 'Antes';

  @override
  String get lgAfter => 'Depois';

  @override
  String lgStats(String today, String month) {
    return 'Hoje: $today · este mês: $month';
  }

  @override
  String lgLastFailure(String date) {
    return 'Última falha: $date';
  }

  @override
  String get lgActShiftsCreate => 'Turnos criados';

  @override
  String get lgActShiftUpdate => 'Turno alterado';

  @override
  String get lgActShiftDelete => 'Turno eliminado';

  @override
  String get lgActPublish => 'Horário publicado';

  @override
  String get lgActImport => 'Funcionários importados';

  @override
  String get lgActProfile => 'Número ou cargo alterado';

  @override
  String get lgActPosition => 'Cargo criado';

  @override
  String get lgActSite => 'Local criado';

  @override
  String get lgActNews => 'Aviso publicado';

  @override
  String get lgActApprove => 'Pedido aprovado';

  @override
  String get lgActRefuse => 'Pedido recusado';

  @override
  String get lgActRead => 'Leitura';

  @override
  String get lgActWebhook => 'Webhook enviado';

  @override
  String get lgFDay => 'Dia';

  @override
  String get lgFStart => 'Início';

  @override
  String get lgFEnd => 'Fim';

  @override
  String get lgFPerson => 'Pessoa';

  @override
  String get lgFSite => 'Local';

  @override
  String get lgFPosition => 'Cargo';

  @override
  String get lgFNote => 'Nota';

  @override
  String get lgFNumber => 'Número';

  @override
  String noticeApiFailing(String key, String count) {
    return 'A chave API «$key» falhou $count vezes numa hora: verifique o programa que a usa.';
  }

  @override
  String noticeApiNewIp(String key, String ip) {
    return 'A chave API «$key» foi usada a partir de um novo endereço ($ip). Se não foi você, revogue-a.';
  }

  @override
  String get lgYear => 'Ano';

  @override
  String get lgResults => 'Resultados em todo o histórico';

  @override
  String get lgAllSources => 'Todas as origens';

  @override
  String get lgAllKinds => 'Leitura e escrita';

  @override
  String get lgAllResults => 'Com êxito e falhas';

  @override
  String get lgFDate => 'Data';

  @override
  String get lgFKey => 'Chave';

  @override
  String get lgFSource => 'Origem';

  @override
  String get lgFStatus => 'Estado';
}
