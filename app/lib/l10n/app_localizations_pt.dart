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
  String myId(String id) {
    return 'O meu identificador: $id';
  }

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
  String get viewTeam => 'Equipa';

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
  String get notifMessages => 'Novas mensagens';

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
}
