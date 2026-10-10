// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get validate => 'Confirmar';

  @override
  String get add => 'Añadir';

  @override
  String get rename => 'Renombrar';

  @override
  String get delete => 'Eliminar';

  @override
  String get accept => 'Aceptar';

  @override
  String get decline => 'Rechazar';

  @override
  String get close => 'Cerrar';

  @override
  String get retry => 'Reintentar';

  @override
  String get name => 'Nombre';

  @override
  String get serverUnreachable => 'No se puede conectar con el servidor.';

  @override
  String errorStatus(int status) {
    return 'Error $status';
  }

  @override
  String get roleOwner => 'Propietario';

  @override
  String get roleManager => 'Responsable';

  @override
  String get roleEmployee => 'Empleado';

  @override
  String get roleExtra => 'Temporal';

  @override
  String get taglineStart => 'Los horarios de tu equipo, ';

  @override
  String get taglineEnd => 'en todas partes.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Inicio de sesión con Google no disponible: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'No se pudo iniciar sesión con Google: $detail';
  }

  @override
  String get newCompany => 'Nueva empresa';

  @override
  String get timezone => 'Zona horaria';

  @override
  String get create => 'Crear';

  @override
  String get noCompanyTitle => 'Todavía no formas parte de ninguna empresa.';

  @override
  String get noCompanyHint =>
      'Para unirte a la de tu empleador, genera un código y dáselo a tu responsable.';

  @override
  String get joinCompany => 'Unirse a una empresa';

  @override
  String get createCompany => 'Crear una empresa';

  @override
  String transferOffer(String company) {
    return 'Te proponen ser propietario de «$company».';
  }

  @override
  String get someCompany => 'una empresa';

  @override
  String get becameOwner => 'Ahora eres el propietario.';

  @override
  String get myAccount => 'Mi cuenta';

  @override
  String get idCopied => 'Identificador copiado.';

  @override
  String myId(String id) {
    return 'Mi identificador: $id';
  }

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String joinInvite(String company, String role) {
    return '«$company» te invita como $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Te has unido a $company.';
  }

  @override
  String get viewPlanning => 'Horario';

  @override
  String get viewTeam => 'Equipo';

  @override
  String get viewPositions => 'Puestos';

  @override
  String get readOnlyCompany => 'Empresa en modo de solo lectura.';

  @override
  String get team => 'Equipo';

  @override
  String get leaveCompany => 'Salir de esta empresa';

  @override
  String meSuffix(String name) {
    return '$name (tú)';
  }

  @override
  String transferConfirmTitle(String name) {
    return '¿Transferir la empresa a $name?';
  }

  @override
  String get transferConfirmBody =>
      'Cuando lo acepte, será propietario (suscripción, facturas, responsables) y tú pasarás a ser responsable.';

  @override
  String transferSent(String name) {
    return 'Propuesta enviada a $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '¿Quitar a $name?';
  }

  @override
  String get removeConfirmBody => 'Su historial se conserva.';

  @override
  String get addPersonTitle => 'Añadir una persona';

  @override
  String get addPersonHint =>
      'Pídele que abra Staff Flow, el menú de su cuenta, «Unirse a una empresa», e introduce el código que aparece.';

  @override
  String get sixDigitCode => 'Código de 6 cifras';

  @override
  String invitationSent(String name) {
    return 'Invitación enviada a $name: debe aceptarla.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '¿Salir de $company?';
  }

  @override
  String get leaveConfirmBody => 'Ya no verás su horario.';

  @override
  String get renameCompany => 'Renombrar la empresa';

  @override
  String get actionMakeManager => 'Nombrar responsable';

  @override
  String get actionMakeEmployee => 'Volver a empleado';

  @override
  String get actionToEmployee => 'Pasar a empleado';

  @override
  String get actionToExtra => 'Pasar a temporal';

  @override
  String get actionTransfer => 'Transferir la propiedad';

  @override
  String get actionRemove => 'Quitar de la empresa';

  @override
  String get positions => 'Puestos';

  @override
  String get sites => 'Centros';

  @override
  String get positionsHint =>
      'Lo que hace la persona: caja, cocina, recepción…';

  @override
  String get sitesHint =>
      'Dónde se realiza el turno, si la empresa tiene varios lugares.';

  @override
  String get archived => 'Archivado';

  @override
  String get archive => 'Archivar';

  @override
  String get reactivate => 'Reactivar';

  @override
  String weekOf(String date) {
    return 'Semana del $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cambios publicados.',
      one: '1 cambio publicado.',
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
  String get month => 'Mes';

  @override
  String get today => 'Hoy';

  @override
  String get onlyMine => 'Solo mis turnos';

  @override
  String get replacePersonMenu => 'Sustituir a una persona…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cambios sin publicar',
      one: '1 cambio sin publicar',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Los empleados todavía no los ven.';

  @override
  String get publish => 'Publicar';

  @override
  String yourHours(String duration) {
    return 'Tus horas en el periodo: $duration';
  }

  @override
  String get addShiftThisDay => 'Añadir un turno este día';

  @override
  String get noShift => 'Sin turnos';

  @override
  String get unassigned => 'Sin asignar';

  @override
  String get formerMember => 'Antiguo miembro';

  @override
  String get statusDraft => 'Borrador';

  @override
  String get statusModified => 'Modificado';

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
  String get editShift => 'Editar el turno';

  @override
  String get newShift => 'Nuevo turno';

  @override
  String get thisShift => 'Este turno';

  @override
  String get thisAndFollowing => 'Este y los siguientes';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Días',
      one: 'Día',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Otro día';

  @override
  String get start => 'Inicio';

  @override
  String get end => 'Fin';

  @override
  String get endsNextDay => 'Termina al día siguiente.';

  @override
  String get person => 'Persona';

  @override
  String get position => 'Puesto';

  @override
  String get site => 'Centro';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get repetition => 'Repetición';

  @override
  String get repeatNone => 'Ninguna';

  @override
  String get repeatDaily => 'Cada día';

  @override
  String get repeatWeekly => 'Cada semana';

  @override
  String get repeatForPrefix => 'Durante ';

  @override
  String get repeatDaysSuffix => ' días';

  @override
  String get repeatWeeksSuffix => ' semanas';

  @override
  String get repeatUntilPrefix => 'Hasta el ';

  @override
  String get replacePersonTitle => 'Sustituir a una persona';

  @override
  String get replaceFrom => 'Sustituir a';

  @override
  String get replaceBy => 'Por';

  @override
  String dateRange(String from, String to) {
    return 'Del $from al $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count turnos modificados.',
      one: '1 turno modificado.',
      zero: 'Ningún turno modificado.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Sustituir';

  @override
  String get joinHint =>
      'Da este código a tu responsable. Lo introduce en su aplicación y recibirás una invitación para aceptar.';

  @override
  String get codeExpired => 'Código caducado.';

  @override
  String codeValidFor(String time) {
    return 'Válido durante $time';
  }

  @override
  String get newCode => 'Nuevo código';

  @override
  String get language => 'Idioma';

  @override
  String get languageAuto => 'Automático (idioma del dispositivo)';

  @override
  String get syncUpToDate => 'Al día';

  @override
  String get syncOffline => 'Sin conexión';

  @override
  String syncPending(int count) {
    return 'Cambios pendientes: $count';
  }

  @override
  String get syncNow => 'Sincronizar';

  @override
  String syncRejected(String reason) {
    return 'Cambio rechazado por el servidor: $reason';
  }

  @override
  String get pendingBadge => 'Pendiente';

  @override
  String get offlineUnavailable => 'No disponible sin conexión.';

  @override
  String get offlineCached => 'Sin conexión: últimos datos guardados.';

  @override
  String get savedOffline =>
      'Guardado en el dispositivo, se enviará cuando vuelva la red.';

  @override
  String get notices => 'Avisos';

  @override
  String get noNotices => 'Ningún aviso.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name ha sustituido tu cambio en el turno del $date.';
  }

  @override
  String get history => 'Historial';

  @override
  String get recentChanges => 'Últimos cambios';

  @override
  String get undoChange => 'Deshacer este cambio';

  @override
  String get undoDone => 'Cambio deshecho.';

  @override
  String get historyCreate => 'Creación';

  @override
  String get historyUpdate => 'Modificación';

  @override
  String get historyDelete => 'Eliminación';

  @override
  String get historyUndo => 'Deshecho';

  @override
  String get noHistory => 'Ningún cambio.';

  @override
  String get pendingNotEditable =>
      'Este turno aún no está sincronizado: inténtalo de nuevo con conexión.';

  @override
  String get myQrCode => 'Mi código QR';

  @override
  String get myQrCodeHint =>
      'Un responsable escanea este código para añadirte a su empresa; luego tú confirmas. Nunca cambia.';

  @override
  String get changeMyName => 'Cambiar mi nombre';

  @override
  String get nameShownToTeam =>
      'Este nombre se muestra a tus compañeros en lugar de tu nombre de Google.';

  @override
  String googleName(String name) {
    return 'Nombre de Google: $name';
  }

  @override
  String get useGoogleName => 'Usar mi nombre de Google';

  @override
  String renameMemberTitle(String name) {
    return 'Cambiar el nombre de $name';
  }

  @override
  String get renameMemberHint => 'Este nombre solo se usa en esta empresa.';

  @override
  String get useOwnName => 'Usar su propio nombre';

  @override
  String get scanQrCode => 'Escanear un código QR';

  @override
  String get scanQrHint =>
      'Apunta la cámara al código QR que aparece en su aplicación (menú de la cuenta, «Mi código QR»).';

  @override
  String get orEnterCode => 'O introduce su código de 6 cifras';

  @override
  String get qrInvalid => 'Este no es un código QR de Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Cámara no disponible ($error).';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notifChooseHint =>
      'Elige de qué quieres recibir avisos. Todo sigue visible en la campana.';

  @override
  String get notifPlanning => 'Horario publicado o modificado';

  @override
  String get notifRequests => 'Solicitudes: cambios, vacaciones, invitaciones';

  @override
  String get notifMessages => 'Mensajes nuevos';

  @override
  String get notifOverlap => 'Turnos que se solapan entre empresas';

  @override
  String get notifConflicts => 'Tus cambios sustituidos por otro responsable';

  @override
  String get notifBilling => 'Recordatorios de suscripción';

  @override
  String get pushEnabled =>
      'Las notificaciones están activadas en este dispositivo.';

  @override
  String get pushOff =>
      'Las notificaciones están desactivadas en este dispositivo.';

  @override
  String get pushBlocked =>
      'Las notificaciones están bloqueadas: permítelas en los ajustes del teléfono o del navegador.';

  @override
  String get pushUnavailable =>
      'Las notificaciones no están disponibles en este dispositivo.';

  @override
  String get enablePush => 'Activar';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: tu horario se ha publicado o modificado.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company quiere añadirte a su equipo.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name te propone ser el propietario de $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name se ha unido a $company.';
  }

  @override
  String get messagesTab => 'Mensajes';

  @override
  String get wholeTeam => 'Todo el equipo';

  @override
  String get newConversation => 'Nueva conversación';

  @override
  String get noMessages => 'Aún no hay mensajes.';

  @override
  String get messageHint => 'Escribe un mensaje';

  @override
  String get earlierMessages => 'Mensajes anteriores';

  @override
  String get personLeftCompany =>
      'Esta persona ya no forma parte de la empresa.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nuevo grupo';

  @override
  String get editGroup => 'Editar grupo';

  @override
  String get groupName => 'Nombre del grupo';

  @override
  String get groupMembersHint =>
      'Elige a las personas de este grupo. Solo ellas verán sus mensajes.';

  @override
  String get chooseAtLeastOne => 'Elige al menos una persona.';

  @override
  String get replyAction => 'Responder';

  @override
  String get translateAction => 'Traducir';

  @override
  String replyingTo(String name) {
    return 'Respuesta a $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Últimos mensajes de $name';
  }

  @override
  String get deleteAllNotices => 'Borrar todo';

  @override
  String get deleteAllNoticesConfirm => '¿Borrar todos los avisos?';

  @override
  String get noticeRetention => 'Borrar los avisos leídos después de';

  @override
  String get retentionDay => '1 día';

  @override
  String get retentionWeek => '1 semana';

  @override
  String get retentionMonth => '1 mes';

  @override
  String get billingOwnersOnly =>
      'Solo activo si eres propietario de una empresa.';

  @override
  String get readOnlyPastDays =>
      'Los días de hace más de un mes son de solo lectura.';

  @override
  String get wholeCompany => 'Toda la empresa';

  @override
  String get sitesLabel => 'Centros';

  @override
  String get actionSites => 'Centros…';

  @override
  String managerOf(String name) {
    return '$name es responsable de';
  }

  @override
  String teamSitesOf(String name) {
    return 'Equipo de $name';
  }

  @override
  String get notYourSite => 'Este centro no está bajo tu responsabilidad.';

  @override
  String get chooseYourSite => 'Elige al menos un centro.';

  @override
  String get viewRequests => 'Solicitudes';

  @override
  String get newRequest => 'Nueva solicitud';

  @override
  String get requestLeave => 'Vacaciones';

  @override
  String get requestUnavailability => 'Indisponibilidad';

  @override
  String get requestSwap => 'Cambio de turno';

  @override
  String get swapHint =>
      'Para proponer un cambio, toca uno de tus próximos turnos en el planning.';

  @override
  String get noRequests => 'Aún no hay solicitudes.';

  @override
  String get requestsToHandle => 'Por atender';

  @override
  String get myRequests => 'Mis solicitudes';

  @override
  String get otherRequests => 'Solicitudes del equipo';

  @override
  String get statusPendingPeer => 'Esperando al compañero';

  @override
  String get statusPendingManager => 'Esperando al responsable';

  @override
  String get statusApproved => 'Aceptada';

  @override
  String get statusRefused => 'Rechazada';

  @override
  String get statusCancelled => 'Cancelada';

  @override
  String get cancelRequest => 'Cancelar la solicitud';

  @override
  String get acceptSwap => 'Tomar este turno';

  @override
  String get approve => 'Validar';

  @override
  String periodLabel(String from, String to) {
    return 'Del $from al $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Ofrecido a $name';
  }

  @override
  String get swapToTeam => 'Todo el equipo';

  @override
  String everyWeekdays(String days) {
    return 'Cada semana: $days';
  }

  @override
  String get unavailableEveryWeek => 'Días en que nunca estás disponible:';

  @override
  String get choosePeriod => 'Elegir fechas';

  @override
  String get choosePeriodOptional => 'Limitar a un periodo (opcional)';

  @override
  String get clearPeriod => 'Sin periodo';

  @override
  String get sendRequest => 'Enviar la solicitud';

  @override
  String get proposeSwap => 'Proponer un cambio';

  @override
  String get swapWith => 'Proponer a';

  @override
  String get swapSteps =>
      'El compañero acepta y luego un responsable valida. El planning solo cambia después.';

  @override
  String get absentThatDay => 'Ausencia validada ese día';

  @override
  String get requestSent => 'Solicitud enviada.';

  @override
  String noticeSwapOffer(String name) {
    return '$name te ofrece uno de sus turnos.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ha rechazado tu propuesta de cambio.';
  }

  @override
  String get noticeSwapToApprove => 'Un cambio de turno espera tu validación.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name pide vacaciones.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name indica que no está disponible.';
  }

  @override
  String get noticeRequestApproved => 'Tu solicitud ha sido aceptada.';

  @override
  String get noticeRequestRefused => 'Tu solicitud ha sido rechazada.';

  @override
  String get choosePeer => '¿Quién toma este turno?';

  @override
  String get discardAll => 'Anular todo';

  @override
  String get notifySitesHint =>
      'Elige los sitios de los que recibes notificaciones de solicitudes. Todas las solicitudes siguen visibles en la lista.';

  @override
  String get notifySitesTitle => 'Notificaciones por sitio';

  @override
  String get pendingRequestTooltip => 'Solicitud pendiente: toca para abrirla';

  @override
  String get requestsHistory => 'Todas las solicitudes';

  @override
  String get revertChange => 'Anular este cambio';

  @override
  String get statusExpired => 'Sin efecto';

  @override
  String get swapWithHint => 'Toca para elegir un compañero concreto';

  @override
  String changesDiscarded(String count) {
    return 'Cambios anulados: $count';
  }

  @override
  String discardConfirm(String count) {
    return '¿Anular los $count cambios no publicados?';
  }

  @override
  String get allSchedules => 'Todos mis plannings';

  @override
  String get busyElsewhere => 'Ya trabaja en otra empresa en este horario';

  @override
  String get overlapTooltip => 'Se solapa con un turno de otra empresa';

  @override
  String get overlapWarning =>
      'Algunos de tus turnos en dos empresas se solapan.';

  @override
  String noticeOverlap(String date) {
    return 'Dos de tus turnos en empresas distintas se solapan el $date.';
  }

  @override
  String get allMyCompanies => 'Todas mis empresas';

  @override
  String get deleteGroup => 'Eliminar el grupo';

  @override
  String get openRequest => 'Ver la solicitud';

  @override
  String get thisCompany => 'Esta empresa';

  @override
  String get withExtras => 'Con los extras';

  @override
  String deleteGroupConfirm(String name) {
    return '¿Eliminar «$name» y todos sus mensajes para todos?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Viene de $company: se añadirá como refuerzo y será avisado.';
  }

  @override
  String get addToGoogle => 'Añadir a Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizar mis turnos';

  @override
  String get calendarHint =>
      'Añade tus turnos de todas tus empresas a Google Calendar. Se actualizan solos y puedes desactivarlo cuando quieras.';

  @override
  String get changeSettings => 'Modificar';

  @override
  String get copyCalendarLink => 'Copiar el enlace del calendario';

  @override
  String get countryBelgium => 'Bélgica';

  @override
  String get countryCanada => 'Canadá';

  @override
  String get countryFrance => 'Francia';

  @override
  String get countrySwitzerland => 'Suiza';

  @override
  String get employeesSection => 'Empleados';

  @override
  String get emptyNoAlert => 'Vacío: sin alerta';

  @override
  String get extrasSection => 'Extras';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'Totales de horas';

  @override
  String get legalAlerts => 'Alertas legales';

  @override
  String get legalAlertsHint =>
      'Avisos, nunca bloqueos. Elige las reglas que se aplican en tu caso, o ninguna.';

  @override
  String get legalPreset => 'Modelo por país';

  @override
  String get linkCopied => 'Enlace copiado.';

  @override
  String get maxConsecutiveLabel => 'Máximo de días trabajados seguidos';

  @override
  String get maxDayLabel => 'Duración máxima por día (horas)';

  @override
  String get maxWeekLabel => 'Duración máxima por semana (horas)';

  @override
  String get minRestLabel => 'Descanso mínimo entre turnos (horas)';

  @override
  String get noLegalRules => 'No se ha elegido ninguna alerta.';

  @override
  String get presetNone => 'Ninguna';

  @override
  String get presetsCheck =>
      'Los modelos son un punto de partida: compruébalos según tu país y tu convenio colectivo.';

  @override
  String get printMine => 'Mi planning';

  @override
  String get printOwn => 'Solo su propio planning';

  @override
  String get printPdf => 'Imprimir / PDF';

  @override
  String get printRights => 'Lo que pueden imprimir los empleados';

  @override
  String get printTeam => 'El planning de todo el equipo';

  @override
  String get printTeamOption => 'El planning del equipo';

  @override
  String get totalsHint =>
      'Borradores incluidos. Las exportaciones Excel y CSV usan el planning publicado.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value días seguidos (máximo $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value en el día (máximo $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: solo $value de descanso (mínimo $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value en la semana (máximo $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Alertas legales: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Turnos: $count';
  }

  @override
  String get actionMakeDeputy => 'Nombrar subresponsable';

  @override
  String get actionRemoveDeputy => 'Quitar el rol de subresponsable';

  @override
  String get busyHere => 'Ya trabaja en la empresa en este horario';

  @override
  String get calendarByLink => 'Por enlace (Google Calendar en un ordenador)';

  @override
  String get calendarDenied =>
      'Acceso al calendario denegado. Permítelo en los ajustes del teléfono.';

  @override
  String get calendarLinkHint =>
      'Añádelo desde Google Calendar en un ordenador; Google lo actualiza en unas horas.';

  @override
  String get calendarNone =>
      'No hay ningún calendario editable en este teléfono.';

  @override
  String get calendarOnPhone => 'Añadir mis turnos al calendario del teléfono';

  @override
  String get calendarOnPhoneHint =>
      'En tu calendario de Google: visible al instante, en el teléfono y en Google Calendar.';

  @override
  String get chooseCalendar => 'Elegir el calendario';

  @override
  String get otherSiteHint =>
      'Empleado de otro sitio: se avisará a sus responsables.';

  @override
  String get subManager => 'Subresponsable';

  @override
  String calendarSynced(String count) {
    return 'Turnos en el calendario: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Subresponsable: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by ha asignado a $name al sitio $site el $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company te ha añadido como refuerzo.';
  }

  @override
  String get companyNotificationsHint =>
      'Desactivadas: no suena nada en este teléfono, pero todo queda en la campana.';

  @override
  String get companyNotificationsOn =>
      'Recibir las notificaciones de esta empresa';

  @override
  String get companyTimezone => 'Zona horaria de la empresa';

  @override
  String get companyTimezoneHint =>
      'Todos los horarios de esta empresa están en esta zona (horario de verano incluido). Los calendarios los convierten automáticamente.';

  @override
  String get iosInstallHint =>
      'En iPhone: toca Compartir y luego «Añadir a pantalla de inicio» para instalar Staff Flow.';

  @override
  String get searchCity => 'Buscar una ciudad';

  @override
  String get thisPhone => 'Este dispositivo';

  @override
  String companyNotifications(String name) {
    return 'Notificaciones: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Horarios en la hora de $zone ($company). Tu dispositivo: $here.';
  }

  @override
  String get addPreset => 'Añadir el preajuste';

  @override
  String get addPresets => 'Crear preajustes';

  @override
  String get appearance => 'Apariencia';

  @override
  String get chooseLogo => 'Elegir una imagen PNG';

  @override
  String get conversationMuted =>
      'Notificaciones silenciadas para esta conversación.';

  @override
  String get conversationUnmuted =>
      'Notificaciones reactivadas para esta conversación.';

  @override
  String get customization => 'Personalización';

  @override
  String get disableGroup => 'Desactivar el grupo';

  @override
  String get disableGroupConfirm =>
      'El grupo de toda la empresa quedará oculto para todos. Podrás reactivarlo en Mensajes.';

  @override
  String get editPresets => 'Preajustes';

  @override
  String get enable => 'Reactivar';

  @override
  String get groupDisabled => 'Grupo desactivado (solo tú lo ves)';

  @override
  String get logoHint =>
      'Una pequeña imagen PNG (tu logo) que aparece en la pestaña de la empresa, para todos sus miembros.';

  @override
  String get logoPngOnly => 'Elige una imagen PNG de 1 MB como máximo.';

  @override
  String get muteConversation => 'Silenciar esta conversación';

  @override
  String get myIdentifier => 'Mi identificador';

  @override
  String get myProfile => 'Mi perfil';

  @override
  String get presetName => 'Nombre (p. ej. Mañana)';

  @override
  String get removeLogo => 'Quitar la imagen';

  @override
  String get resetGroup => 'Reiniciar el grupo';

  @override
  String get resetGroupConfirm =>
      'Se borrarán todos los mensajes del grupo de la empresa para todos.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get shiftPresets => 'Preajustes de horarios';

  @override
  String get shiftPresetsHint =>
      'Horarios ya listos (mañana, tarde, noche…): un toque en un turno rellena el inicio y el fin.';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get unmuteConversation =>
      'Reactivar las notificaciones de esta conversación';

  @override
  String get awaitingApproval => 'Por validar';

  @override
  String get placementNeedsApproval =>
      '! Esta persona no es de tus centros: el turno esperará la validación de tu superior o del dueño antes de poder publicarse. Si no, elige a otra persona.';

  @override
  String get placementAwaiting =>
      'Pendiente de validación por un superior o el dueño.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by quiere programar a $name, de otro centro, el $date: requiere validación.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by validó la programación de $name el $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by rechazó la programación de $name el $date.';
  }

  @override
  String get addSubSite => 'Añadir un subcentro';

  @override
  String get moveSite => 'Mover';

  @override
  String get topLevel => 'Primer nivel';

  @override
  String moveSiteTitle(String name) {
    return 'Mover «$name» debajo de…';
  }

  @override
  String subSiteOf(String name) {
    return 'Subcentro de $name';
  }

  @override
  String get siteTreeHint =>
      'Hasta 3 niveles, p. ej. Región › Ciudad › Tienda. El responsable de un centro gestiona también todo lo que hay debajo.';

  @override
  String get subSitesOnlyHint =>
      'Aquí añades subcentros bajo tus propios centros.';

  @override
  String get messagingSetting => 'Mensajería de la empresa';

  @override
  String get messagingSettingHint =>
      'Activada: el equipo tiene una pestaña Mensajes. Desactivada: nadie la ve ni puede escribir (los mensajes antiguos se conservan).';
}
