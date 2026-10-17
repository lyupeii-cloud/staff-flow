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
  String get viewTeam => 'Configuración';

  @override
  String get viewPositions => 'Organigrama';

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
  String get notifMessages => 'Nuevos anuncios';

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
  String get translateAction => 'Traducir';

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
  String get openRequest => 'Ver la solicitud';

  @override
  String get thisCompany => 'Esta empresa';

  @override
  String get withExtras => 'Con los extras';

  @override
  String reinforcementHint(String company) {
    return 'Viene de $company: se añadirá como refuerzo y será avisado.';
  }

  @override
  String get addToGoogle => 'Añadir a Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizar mis turnos';

  @override
  String get changeSettings => 'Modificar';

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
  String get calendarDenied =>
      'Acceso al calendario denegado. Permítelo en los ajustes del teléfono.';

  @override
  String get calendarLinkHint =>
      'Añádelo desde Google Calendar en un ordenador; Google lo actualiza en unas horas.';

  @override
  String get calendarNone =>
      'No hay ningún calendario editable en este teléfono.';

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
  String get customization => 'Personalización';

  @override
  String get editPresets => 'Preajustes';

  @override
  String get enable => 'Reactivar';

  @override
  String get logoHint =>
      'Una pequeña imagen PNG (tu logo) que aparece en la pestaña de la empresa, para todos sus miembros.';

  @override
  String get logoPngOnly => 'Elige una imagen PNG de 1 MB como máximo.';

  @override
  String get myIdentifier => 'Mi identificador';

  @override
  String get myProfile => 'Mi perfil';

  @override
  String get presetName => 'Nombre (p. ej. Mañana)';

  @override
  String get removeLogo => 'Quitar la imagen';

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
      'Hasta 10 niveles, por ejemplo Región › Ciudad › Tienda. Los 3 primeros están incluidos en la suscripción; a partir de ahí se necesita la opción «Sitios en cascada». El responsable de un sitio gestiona también todo lo que está debajo.';

  @override
  String get subSitesOnlyHint =>
      'Aquí añades subcentros bajo tus propios centros.';

  @override
  String get messagingSetting => 'Tablón de noticias';

  @override
  String get messagingSettingHint =>
      'Activado: el propietario y los responsables publican anuncios (para todos, un puesto, un sitio o personas elegidas); todos los leen y pueden traducirlos. Desactivado: la pestaña desaparece para todos.';

  @override
  String get billingTitle => 'Suscripción';

  @override
  String billingStatusTrial(String date) {
    return 'Prueba gratuita hasta el $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Pagado hasta el $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Solo lectura: sin pago, la empresa se eliminará el $date.';
  }

  @override
  String get billingStatusComped => 'Gratuita';

  @override
  String billingStaff(String count) {
    return '$count empleados y responsables (sin el propietario ni los extras)';
  }

  @override
  String get billingMonthly => 'Mensual';

  @override
  String billingYearly(String months) {
    return 'Anual ($months meses facturados)';
  }

  @override
  String get billingCascade => 'Opción «Sitios en cascada» (niveles 4 a 10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Incluida a partir de $count empleados';
  }

  @override
  String billingPay(String amount) {
    return 'Pagar $amount';
  }

  @override
  String get billingTestNotice => 'Pago de prueba: no se cobra nada.';

  @override
  String get billingSoon => 'El pago en línea llega pronto.';

  @override
  String get billingPaidOk => 'Pago registrado.';

  @override
  String get billingInvoices => 'Facturas';

  @override
  String get billingNoInvoices => 'Aún no hay facturas.';

  @override
  String get billingManage => 'Gestionar la suscripción';

  @override
  String get billingReadOnlyStaff =>
      'Esta empresa está en solo lectura hasta que el propietario renueve la suscripción.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / mes';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / año';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: la prueba gratuita termina en menos de 24 horas.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company está en solo lectura por falta de pago; eliminación el $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Recordatorio: sin pago, $company se eliminará el $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company se eliminó por falta de pago.';
  }

  @override
  String billingCompanyId(String id) {
    return 'ID de la empresa: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Hoy: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Incluye el resto del mes en curso ($days días, a prorrata) y luego meses completos desde el día 1.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Aún no vinculado. Sirve para verificar tu identidad, por ejemplo para cambiar de cuenta de Google.';

  @override
  String telegramLinked(String name) {
    return 'Vinculado: $name';
  }

  @override
  String get telegramNoUsername => 'sin nombre de usuario';

  @override
  String get telegramLink => 'Vincular mi Telegram';

  @override
  String get telegramLinkHint =>
      'Se abre Telegram: toca «Iniciar» y vuelve aquí.';

  @override
  String get telegramUnlink => 'Desvincular';

  @override
  String get telegramUnavailable => 'Telegram aún no está disponible.';

  @override
  String get telegramShowIn => 'Mostrar mi Telegram en:';

  @override
  String get newQrCode => 'Cambiar código QR';

  @override
  String get newQrCodeConfirm =>
      'Tu antiguo código QR y tu antiguo identificador dejarán de funcionar. Tu lugar en tus empresas no cambia.';

  @override
  String get newQrCodeDone => 'Nuevo código QR creado.';

  @override
  String get changeGoogle => 'Cambiar de cuenta de Google';

  @override
  String get changeGoogleSub => 'Misma cuenta, mismo número, mismas empresas';

  @override
  String changeGoogleSteps(String id) {
    return '1. Vincula tu Telegram en este perfil (obligatorio).\n2. Cierra sesión e inicia sesión con la nueva cuenta de Google.\n3. Elige «Ya tengo una cuenta de Staff Flow» e introduce tu identificador $id.\n4. Introduce el código recibido en Telegram.\nTu cuenta, tu número y tus empresas siguen siendo los mismos.';
  }

  @override
  String get recoverAccount => 'Ya tengo una cuenta de Staff Flow';

  @override
  String get recoverHint =>
      'Introduce el identificador de tu antigua cuenta (SF-…). Se enviará un código al Telegram vinculado a esa cuenta.';

  @override
  String get recoverIdLabel => 'Identificador (SF-…)';

  @override
  String get recoverSend => 'Enviar el código';

  @override
  String get recoverCodeSent => 'Código enviado por Telegram.';

  @override
  String get recoverCodeLabel => 'Código recibido (6 cifras)';

  @override
  String get recoverConfirm => 'Recuperar mi cuenta';

  @override
  String get recoverDone => 'Listo: has recuperado tu cuenta.';

  @override
  String get exportData => 'Exportar mis datos';

  @override
  String get exportDataSub => 'Un archivo con todos tus datos personales';

  @override
  String get deleteAccount => 'Eliminar mi cuenta';

  @override
  String get deleteGhost => 'Eliminar dejando un fantasma';

  @override
  String get deleteGhostHint =>
      'Sales de todas tus empresas. Inicia sesión más tarde con la misma cuenta de Google para recuperar tu cuenta y tu número.';

  @override
  String get deleteErase => 'Borrar todo definitivamente';

  @override
  String get deleteEraseHint =>
      'Se borran nombre, correo, foto, Telegram, mensajes y notificaciones. No se puede deshacer.';

  @override
  String get deleteGhostNote =>
      'En ambos casos, el historial de las empresas conserva un «Ghost» anónimo en tu lugar (solicitudes de vacaciones, turnos pasados…) para que el propietario y los responsables puedan reconstruir lo ocurrido.';

  @override
  String get deleteOwnerNote =>
      '¿Eres propietario de una empresa? Transfiérela primero o deja que termine su suscripción.';

  @override
  String get deleteConfirmButton => 'Eliminar';

  @override
  String get accountRestored =>
      '¡Bienvenido de nuevo! Tu cuenta se ha reactivado.';

  @override
  String get closedInvoices => 'Facturas de empresas cerradas';

  @override
  String get downloadAllInvoices => 'Descargar todas las facturas (ZIP)';

  @override
  String get legalTerms => 'Condiciones de uso y de venta';

  @override
  String get legalPrivacy => 'Política de privacidad';

  @override
  String get billingDetailTitle => 'Detalle del pago';

  @override
  String billingLineProrata(String days, String total) {
    return 'Resto del mes en curso ($days días de $total): suscripción';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Resto del mes en curso ($days días de $total): opción «sedes anidadas»';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Suscripción, $staff plazas: 1 mes';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Suscripción, $staff plazas: 12 meses al precio de $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Opción «sedes anidadas»: $months meses, sin descuento';
  }

  @override
  String get billingTotal => 'Total';

  @override
  String billingCovers(String from, String to) {
    return 'Periodo cubierto: del $from al $to';
  }

  @override
  String get billingGraceInvoices =>
      'Esta empresa no se renueva: descarga ya todas sus facturas.';

  @override
  String get billingYearLabel => 'Año';

  @override
  String get sitesNoneChosen => 'Ninguna sede elegida';

  @override
  String get avatarTitle => 'Mi avatar';

  @override
  String get avatarSub => 'Una imagen en lugar de tu foto';

  @override
  String get avatarUseGoogle => 'Usar mi foto de Google';

  @override
  String get avatarColor => 'Color';

  @override
  String get hidePhotosTitle => 'Ocultar las fotos de Google';

  @override
  String get hidePhotosSub =>
      'En esta empresa, cada uno aparece con su avatar o su inicial.';

  @override
  String get billingApi => 'Opción «acceso API»';

  @override
  String billingLineApi(String months) {
    return 'Opción «acceso API»: $months meses, sin descuento';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Resto del mes en curso ($days días de $total): opción «acceso API»';
  }

  @override
  String billingLineProProrata(String days, String total) {
    return 'Resto del mes en curso ($days días de $total): opción «API Pro»';
  }

  @override
  String get apiTitle => 'Acceso API (contabilidad, CRM)';

  @override
  String get apiSub =>
      'Tus programas (nóminas, contabilidad, CRM, planificación) leen el horario publicado, las horas y las ausencias; con «API Pro» también envían horarios, empleados y anuncios.';

  @override
  String get apiNeedsOption =>
      'Opción de pago: añade «Acceso API» o «API Pro» en «Gestionar la suscripción».';

  @override
  String get apiNewKey => 'Nueva clave';

  @override
  String get apiKeyName => 'Nombre de la clave (p. ej.: programa de nóminas)';

  @override
  String get apiKeyCreated =>
      'Copia esta clave ahora y guárdala en un lugar seguro: no se volverá a mostrar.';

  @override
  String get apiKeyCopy => 'Copiar';

  @override
  String get apiKeyCopied => 'Clave copiada.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Último uso: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Nunca usada';

  @override
  String get apiRevoke => 'Revocar';

  @override
  String get apiRevokeConfirm =>
      'Los programas que usan esta clave perderán el acceso.';

  @override
  String get apiDocs => 'Documentación de la API';

  @override
  String get memberGoogleLink => 'Reconexión de Google del empleado';

  @override
  String googleLinkHint(String name) {
    return 'Envía este enlace a $name. Se abre en un navegador (no en la aplicación de Android), una sola vez, durante 24 horas: $name inicia sesión con su nueva cuenta de Google y recupera su cuenta. Se cierra entonces la sesión en todos sus demás dispositivos.';
  }

  @override
  String get googleLinkCopied => 'Enlace copiado.';

  @override
  String get switchBanner =>
      'Enlace de cambio de cuenta de Google: inicia sesión con tu nueva cuenta de Google para recuperar tu cuenta de Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Este enlace vincula una cuenta de Staff Flow a una nueva cuenta de Google. Cierra sesión primero y luego inicia sesión con la nueva cuenta de Google.';

  @override
  String get switchDone =>
      'Listo: tu cuenta de Staff Flow está vinculada a esta cuenta de Google. Se ha cerrado la sesión en tus demás dispositivos.';

  @override
  String changeGoogleBot(String bot) {
    return 'Lo más sencillo: en Telegram, envía /changegoogle al bot $bot y sigue sus instrucciones; luego inicia sesión con la nueva cuenta de Google en los próximos 10 minutos.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Sin Telegram: pide a tu propietario o a un responsable un enlace de cambio de cuenta de Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name ha creado un enlace para vincular tu cuenta a una nueva cuenta de Google. Si no lo has pedido, avisa a tu responsable.';
  }

  @override
  String get sessionRevoked =>
      'Se ha cerrado tu sesión: tu cuenta ahora está vinculada a otra cuenta de Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Consejo: envía /connexion al bot $bot para recibir un enlace y abrir Staff Flow en un navegador, sin la aplicación ni cuenta de Google.';
  }

  @override
  String get timeFormat => 'Formato de hora';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Personas';

  @override
  String get sortNatural => 'Orden habitual';

  @override
  String get sortName => 'Nombre';

  @override
  String get employeeNumber => 'Número de empleado';

  @override
  String get sfIdLabel => 'ID de Staff Flow';

  @override
  String get pickSearch => 'Buscar';

  @override
  String get pickSearchPeople => 'Buscar: nombre, número de empleado, ID SF';

  @override
  String get pickSortTitle => 'Ordenar y mostrar por';

  @override
  String pickSelected(String count) {
    return 'Marcados: $count';
  }

  @override
  String get pickCheckAll => 'Marcar todos';

  @override
  String get pickClear => 'Desmarcar todos';

  @override
  String get pickNoResult => 'Sin resultados';

  @override
  String get pickMultiHint =>
      'Marca varias personas: se creará un turno para cada una, todo de una vez.';

  @override
  String get filterAll => 'Todos';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Sin puesto';

  @override
  String get noSiteGroup => 'Sin sitio';

  @override
  String get groupByTitle => 'Agrupar por';

  @override
  String get groupRole => 'Rol';

  @override
  String get groupNone => 'Sin agrupar';

  @override
  String showMore(String count, String left) {
    return 'Mostrar $count más (quedan $left)';
  }

  @override
  String get findByQr => 'Buscar a un miembro con su código QR';

  @override
  String get qrNotMember =>
      'Este código QR no corresponde a nadie de esta empresa.';

  @override
  String get memberProfile => 'Número de empleado y puesto';

  @override
  String get employeeNumberHint =>
      'Número propio de tu empresa (opcional). El ID de Staff Flow se mantiene.';

  @override
  String get usualPosition => 'Puesto habitual';

  @override
  String get inviteCodeTitle => 'Código de invitación';

  @override
  String get inviteCodeHint =>
      'Introduce el código que te dio tu empleador o escanea el código QR de tu invitación.';

  @override
  String inviteJoined(String company) {
    return 'Te has unido a $company.';
  }

  @override
  String get importTitle => 'Importar empleados';

  @override
  String get importIntro =>
      'Importa tu lista de empleados desde un archivo Excel o CSV. Cada uno recibe un código y un código QR personales: activa su cuenta con una aplicación 2FA (o con Google). Nadie se añade sin su consentimiento.';

  @override
  String get importTemplate => 'Descargar la plantilla Excel';

  @override
  String get importTemplateHint =>
      'Columnas: nombre, número de empleado, puesto, sitio. Solo el nombre es obligatorio.';

  @override
  String get importChooseFile => 'Elegir un archivo (.xlsx o .csv)';

  @override
  String importNew(String count) {
    return 'Nuevos: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Actualizados: $count';
  }

  @override
  String importSkip(String count) {
    return 'Ya invitados: $count';
  }

  @override
  String importErrors(String count) {
    return 'Errores: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importar ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Las filas con errores se omitirán: corrígelas en el archivo y vuelve a importarlo.';

  @override
  String get importCreated => 'nuevo';

  @override
  String importDone(String count) {
    return 'Invitaciones creadas: $count';
  }

  @override
  String get invitesTitle => 'Invitaciones pendientes';

  @override
  String get invitesPrint => 'Imprimir los códigos';

  @override
  String get inviteShowHint =>
      'La persona elige «Activar mi cuenta» en la pantalla de inicio de sesión (o «Tengo un código de invitación» si ya tiene cuenta) y luego escanea este código QR o escribe este código. Válido 90 días, una sola vez.';

  @override
  String invitesHint(String count) {
    return 'Invitaciones pendientes: $count. Toca a una persona para mostrar su código y su código QR, o imprímelos todos.';
  }

  @override
  String get inviteSeenByEmail => 'invitación vista (correo)';

  @override
  String get invitesNone => 'No hay invitaciones pendientes.';

  @override
  String get haveInviteCode => 'Tengo un código de invitación';

  @override
  String get newsTab => 'Noticias';

  @override
  String get newsNew => 'Nuevo anuncio';

  @override
  String get newsEmpty => 'Todavía no hay anuncios.';

  @override
  String get newsEmptyManager =>
      'Todavía no hay anuncios. Publica el primero: para toda la empresa, un puesto, un sitio o personas elegidas.';

  @override
  String get newsOlder => 'Anuncios anteriores';

  @override
  String get newsEdited => 'editado';

  @override
  String get newsEdit => 'Editar el anuncio';

  @override
  String get newsDeleteTitle => '¿Retirar este anuncio?';

  @override
  String get newsForEveryone => 'Para todos';

  @override
  String get newsEveryoneMySites => 'Todos en mis sitios';

  @override
  String newsFor(String names) {
    return 'Para: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Leído por $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Leído por $count de $total';
  }

  @override
  String get newsTranslated => 'Traducido automáticamente';

  @override
  String get newsTitleField => 'Título (opcional)';

  @override
  String get newsBodyField => 'Texto del anuncio';

  @override
  String get newsRecipients => 'Destinatarios';

  @override
  String get newsTargetHint =>
      'Marca uno o varios grupos: el anuncio llega a cada persona que corresponda a alguno de ellos.';

  @override
  String get newsPublish => 'Publicar';

  @override
  String newsSent(String count) {
    return 'Anuncio enviado a $count persona(s).';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Opción «Acceso API», añadida durante la suscripción, del $from al $to: $months meses, sin descuento';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Opción «Sitios en cascada», añadida durante la suscripción, del $from al $to: $months meses, sin descuento';
  }

  @override
  String get billingRenewalOptions =>
      'Las opciones marcadas se incluirán en tus próximas renovaciones. Una opción desmarcada sigue activa hasta el final del periodo ya pagado.';

  @override
  String billingAddonTitle(String option) {
    return 'Añadir ahora: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'El mes en curso completo y luego cada mes hasta el $date (fin del periodo pagado), sin descuento. La opción se activa al pagar y se incluye en las siguientes renovaciones.';
  }

  @override
  String get billingAddonInvoice => 'opción';

  @override
  String billingAccessRemoved(String name) {
    return '$name ya no gestiona la suscripción.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name ahora puede gestionar la suscripción y las facturas.';
  }

  @override
  String get actionBillingRemove => 'Quitar la gestión de la suscripción';

  @override
  String get actionBillingGive => 'Permitir gestionar la suscripción';

  @override
  String get billingAccessTag => 'Gestiona la suscripción';

  @override
  String get billingOptionRenewed => 'Renovación de la opción reanudada.';

  @override
  String get billingOptionStopped =>
      'Opción no renovada: sigue activa hasta el final del periodo pagado.';

  @override
  String billingOptionEnds(String date) {
    return 'Activa hasta el $date, no se renovará (márcala para mantenerla)';
  }

  @override
  String get billingOptionActive =>
      'Activa y renovada (desmárcala para no renovarla)';

  @override
  String get statusCancelRequested => 'Anulación solicitada';

  @override
  String get requestEndedEarly => 'Terminada antes por la persona.';

  @override
  String get confirmCancelRequest =>
      '¿Anular esta solicitud? Los responsables ya no la verán.';

  @override
  String get endUnavailability => 'Terminar mi indisponibilidad';

  @override
  String get confirmEndUnavailability =>
      '¿Terminar tu indisponibilidad? Estarás disponible de nuevo desde hoy y se avisará a los responsables.';

  @override
  String get askLeaveCancel => 'Pedir la anulación de estas vacaciones';

  @override
  String get confirmAskLeaveCancel =>
      '¿Pedir la anulación de estas vacaciones? Un responsable tendrá que aprobarla; hasta entonces, las vacaciones siguen previstas.';

  @override
  String get refuseLeaveCancel => 'Rechazar la anulación';

  @override
  String get acceptLeaveCancel => 'Aceptar la anulación';

  @override
  String get requestsSearchHint =>
      'Buscar: nombre, número de empleado, ID SF, nota';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterState => 'Estado';

  @override
  String get statePending => 'Pendientes';

  @override
  String get stateClosed => 'Rechazadas o anuladas';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Plazas añadidas, de $from a $to, del $start al $end: $months meses, sin descuento';
  }

  @override
  String billingSeats(String used, String limit) {
    return '$used plazas pagadas · hasta $limit personas con el margen del 5 %';
  }

  @override
  String get billingSeatsTitle => 'Número de plazas';

  @override
  String get billingSeatsHint =>
      'Empleados y responsables (sin el propietario ni los extras), en tramos de 10. 10 plazas al crear la empresa; por encima, un margen del 5 % y luego no se puede añadir más.';

  @override
  String get billingSeatsUnit => 'plazas';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Plazas: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'De $min a 5000, en tramos de 10.';
  }

  @override
  String get printWeek => 'Semana';

  @override
  String get printMonth => 'Mes';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Mantener la sesión en este dispositivo';

  @override
  String get rememberMeHint =>
      'Activado: como con Google, sin código cada vez que abres la aplicación. Evítalo en un dispositivo compartido.';

  @override
  String get totpLoginTitle => 'Acceso 2FA';

  @override
  String get totpCompanyCode => 'Código de la empresa';

  @override
  String get totpCompanyCodeHint =>
      '6 caracteres que te da tu empleador (solo con número de empleado).';

  @override
  String get totpBackupCode => 'Código de respaldo';

  @override
  String get totpCode => 'Código de la aplicación';

  @override
  String get totpUseApp => 'Usar la aplicación 2FA';

  @override
  String get totpUseBackup => 'Usar un código de respaldo';

  @override
  String get totpSignIn => 'Iniciar sesión';

  @override
  String get totpLostPhone =>
      '¿Perdiste el teléfono o borraste la aplicación? Pide a tu responsable un nuevo código de activación.';

  @override
  String get activateTitle => 'Activar mi cuenta';

  @override
  String get activateStep1 => 'Paso 1: tu código de invitación';

  @override
  String get activateStep1Hint =>
      'Escanea el código QR que te dio tu empleador o escribe el código que aparece debajo.';

  @override
  String get activateScan => 'Escanear el código QR';

  @override
  String get activateCodeField => 'Código de invitación';

  @override
  String get activateContinue => 'Continuar';

  @override
  String activateHello(String name, String company) {
    return 'Hola, $name · $company';
  }

  @override
  String get activateStep2 =>
      'Paso 2: vincula una aplicación de autenticación (Google Authenticator, Microsoft Authenticator…). Te dará un código de 6 cifras cada vez que inicies sesión.';

  @override
  String get activateOpenApp => 'Añadir a mi aplicación de autenticación';

  @override
  String get activateOrScan =>
      'O, desde otro dispositivo, escanea este código QR con la aplicación:';

  @override
  String get activateManualKey => 'Clave para escribir a mano:';

  @override
  String get activateFirstCode => 'Primer código de la aplicación';

  @override
  String get activateDone => 'Activar';

  @override
  String get totpReadyTitle => 'Tu cuenta está lista';

  @override
  String get totpYourId => 'Tu identificador de Staff Flow:';

  @override
  String get totpBackupHint =>
      'Códigos de respaldo (cada uno sirve una vez): anótalos o guárdalos en un lugar seguro. Sirven si ya no tienes la aplicación.';

  @override
  String get totpBackupSaved => 'Anotado';

  @override
  String get linkGoogleTitle => 'Vincular una cuenta de Google';

  @override
  String get linkGoogleHint =>
      'Para crear una empresa, vincula una cuenta de Google a tu cuenta de Staff Flow. Solo sirve para proteger al creador de la empresa y su suscripción: tu dirección de Google nunca se muestra a tus empleados ni a nadie, se queda en Staff Flow. Podrás seguir iniciando sesión con tu aplicación 2FA.';

  @override
  String get linkGoogleButton => 'Vincular mi cuenta de Google';

  @override
  String get linkGoogleBanner =>
      'Inicia sesión con la cuenta de Google que quieres vincular a Staff Flow.';

  @override
  String get activationCodeAction => 'Nuevo código de activación';

  @override
  String activationCodeTitle(String name) {
    return '¿Nuevo código para $name?';
  }

  @override
  String get activationCodeConfirm =>
      'El teléfono y la aplicación 2FA anteriores dejarán de funcionar. La persona vuelve a activar su cuenta con este código (válido 7 días).';

  @override
  String get activationCodeHint =>
      'La persona elige «Activar mi cuenta» en la pantalla de inicio de sesión y luego escanea este código QR o escribe este código.';

  @override
  String get signupTitle => 'Crear una cuenta';

  @override
  String get signupStep1 => 'Paso 1: tu nombre';

  @override
  String get signupStep1Hint =>
      'El nombre que verán tus compañeros y empleadores. Sin Google ni e-mail: tu cuenta está protegida por una aplicación de autenticación.';

  @override
  String get signupName => 'Nombre y apellidos';

  @override
  String signupHello(String name) {
    return 'Hola, $name';
  }

  @override
  String get signupButton => 'Crear una cuenta con una aplicación 2FA';

  @override
  String get totpCardTitle => 'Acceso con una aplicación 2FA';

  @override
  String totpCardLocal(String id) {
    return 'Tu cuenta inicia sesión con una aplicación de autenticación. Identificador: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Activado: también puedes iniciar sesión con tu identificador $id y el código de la aplicación, sin Google.';
  }

  @override
  String get totpCardOff =>
      'Prepara una aplicación de autenticación para poder iniciar sesión sin Google (ID SF + código de 6 cifras).';

  @override
  String get totpEnable => 'Activar';

  @override
  String get totpDisable => 'Quitar';

  @override
  String get totpEnableTitle => 'Activar el acceso 2FA';

  @override
  String get totpEnabledTitle => 'Acceso 2FA listo';

  @override
  String get totpDisableConfirm =>
      '¿Quitar el acceso con la aplicación 2FA? Solo iniciarás sesión con Google.';

  @override
  String get googlePrivacyNote =>
      'Tu cuenta de Google solo sirve para proteger la empresa y su suscripción: nunca se muestra a tus empleados ni a nadie.';

  @override
  String get scopeRead =>
      'Lectura: horario publicado, horas, ausencias, empleados';

  @override
  String get scopeShifts => 'Horario: crear, modificar, eliminar turnos';

  @override
  String get scopePublish => 'Publicar el horario';

  @override
  String get scopeMembers => 'Empleados: importar, número de empleado y puesto';

  @override
  String get scopeCatalog => 'Puestos y sitios';

  @override
  String get scopeNews => 'Anuncios';

  @override
  String get scopeRequests => 'Solicitudes: aprobar o rechazar';

  @override
  String get apiScopesTitle => 'Permisos de la clave';

  @override
  String get apiProNeeded =>
      'Los permisos de escritura requieren la opción «API Pro» (suscripción pagada).';

  @override
  String billingLinePro(String months) {
    return 'Opción «API Pro»: $months meses';
  }

  @override
  String billingLineProAddon(String start, String end, String months) {
    return 'Opción «API Pro», añadida durante la suscripción, del $start al $end: $months meses, sin descuento';
  }

  @override
  String billingApiProHint(String price1, String price5) {
    return '«API Pro» (lectura y escritura, webhooks, registros): $price1 / mes por 1 clave, $price5 / mes por 10 claves, sin descuento. Con una suscripción pagada: añádela abajo.';
  }

  @override
  String get whTitle => 'Webhooks';

  @override
  String get whSub =>
      'Staff Flow avisa a tus programas por sí solo cuando ocurre algo: horario publicado, solicitud, nuevo empleado, anuncio. Incluido en la opción «API Pro».';

  @override
  String get whNew => 'Nuevo webhook';

  @override
  String get whUrl => 'Dirección (https://…)';

  @override
  String get whEvents => 'Eventos enviados';

  @override
  String get whCreated =>
      'Secreto de firma, mostrado una sola vez: tu programa lo usa para comprobar que cada envío viene de Staff Flow.';

  @override
  String get whTest => 'Probar';

  @override
  String whTestOk(String status) {
    return 'Recibido (código $status)';
  }

  @override
  String whTestFail(String error) {
    return 'Error: $error';
  }

  @override
  String get whDisabled => 'Desactivado tras 10 envíos fallidos seguidos';

  @override
  String get whEnable => 'Reactivar';

  @override
  String get whDelete => 'Eliminar';

  @override
  String get whDeleteConfirm => 'Este webhook ya no recibirá nada.';

  @override
  String get whNone => 'Aún no hay webhooks.';

  @override
  String whLast(String date, String status) {
    return 'Último envío: $date · $status';
  }

  @override
  String get whEvSchedulePublished => 'Horario publicado';

  @override
  String get whEvRequestCreated => 'Nueva solicitud';

  @override
  String get whEvRequestDecided => 'Solicitud aprobada o rechazada';

  @override
  String get whEvRequestCancelled => 'Solicitud cancelada';

  @override
  String get whEvRequestCancelAsked => 'Anulación de vacaciones solicitada';

  @override
  String get whEvRequestCancelDecided => 'Anulación de vacaciones decidida';

  @override
  String get whEvRequestEnded => 'Indisponibilidad terminada';

  @override
  String get whEvMemberJoined => 'Nuevo empleado';

  @override
  String get whEvAnnouncementPublished => 'Anuncio publicado';

  @override
  String get whStDelivered => 'recibido';

  @override
  String get whStPending => 'pendiente';

  @override
  String get whStFailed => 'error';

  @override
  String get whStDropped => 'descartado';

  @override
  String get lgTitle => 'Registros';

  @override
  String get lgSub =>
      'Cada llamada de tus claves API y del asistente MCP, y cada envío de webhook. Desliza para cambiar de mes.';

  @override
  String get lgSearch => 'Buscar: persona, número de empleado, acción…';

  @override
  String get lgAllHistory => 'Buscar en todo el historial (archivos incluidos)';

  @override
  String get lgArchived => 'Mes archivado';

  @override
  String get lgNone => 'Nada en este mes.';

  @override
  String get lgMore => 'Mostrar más';

  @override
  String get lgExport => 'Descargar un año (ZIP)';

  @override
  String get lgAllKeys => 'Todas las claves';

  @override
  String get lgSourceApi => 'API';

  @override
  String get lgSourceMcp => 'Asistente MCP';

  @override
  String get lgSourceWebhook => 'Webhook';

  @override
  String get lgKindRead => 'Lectura';

  @override
  String get lgKindWrite => 'Escritura';

  @override
  String get lgOk => 'Correcto';

  @override
  String get lgError => 'Error';

  @override
  String get lgBefore => 'Antes';

  @override
  String get lgAfter => 'Después';

  @override
  String lgStats(String today, String month) {
    return 'Hoy: $today · este mes: $month';
  }

  @override
  String lgLastFailure(String date) {
    return 'Último error: $date';
  }

  @override
  String get lgActShiftsCreate => 'Turnos creados';

  @override
  String get lgActShiftUpdate => 'Turno modificado';

  @override
  String get lgActShiftDelete => 'Turno eliminado';

  @override
  String get lgActPublish => 'Horario publicado';

  @override
  String get lgActImport => 'Empleados importados';

  @override
  String get lgActProfile => 'Número de empleado o puesto cambiado';

  @override
  String get lgActPosition => 'Puesto creado';

  @override
  String get lgActSite => 'Sitio creado';

  @override
  String get lgActNews => 'Anuncio publicado';

  @override
  String get lgActApprove => 'Solicitud aprobada';

  @override
  String get lgActRefuse => 'Solicitud rechazada';

  @override
  String get lgActRead => 'Lectura';

  @override
  String get lgActWebhook => 'Webhook enviado';

  @override
  String get lgFDay => 'Día';

  @override
  String get lgFStart => 'Inicio';

  @override
  String get lgFEnd => 'Fin';

  @override
  String get lgFPerson => 'Persona';

  @override
  String get lgFSite => 'Sitio';

  @override
  String get lgFPosition => 'Puesto';

  @override
  String get lgFNote => 'Nota';

  @override
  String get lgFNumber => 'Número de empleado';

  @override
  String noticeApiFailing(String key, String count) {
    return 'La clave API «$key» ha fallado $count veces en una hora: revisa el programa que la usa.';
  }

  @override
  String noticeApiNewIp(String key, String ip) {
    return 'La clave API «$key» se ha usado desde una dirección nueva ($ip). Si no has sido tú, revócala.';
  }

  @override
  String get lgResults => 'Resultados en todo el historial';

  @override
  String get lgAllSources => 'Todos los orígenes';

  @override
  String get lgAllKinds => 'Lectura y escritura';

  @override
  String get lgAllResults => 'Correctos y errores';

  @override
  String get lgFDate => 'Fecha';

  @override
  String get lgFKey => 'Clave';

  @override
  String get lgFSource => 'Origen';

  @override
  String get lgFStatus => 'Estado';

  @override
  String get totpContinueButton => 'Continuar con una app 2FA';

  @override
  String get totpIdentHint =>
      'Introduce tu identificador de Staff Flow (SF-…), tu número de empleado o el código de activación de tu empresa.';

  @override
  String get totpIdentField =>
      'Identificador, número de empleado o código de la empresa';

  @override
  String get totpContinue => 'Continuar';

  @override
  String get totpUnknown =>
      'Este identificador no existe. ¿Quieres crear una cuenta?';

  @override
  String get totpGoogleAccount =>
      'Esta cuenta inicia sesión con Google: vuelve atrás y toca «Iniciar sesión con Google».';

  @override
  String get totpNoAccount => '¿Aún no tienes cuenta? Crear una';

  @override
  String get totpChange => 'Otro identificador';

  @override
  String get billingNotInApp =>
      'Las compras no están disponibles en la app móvil.';

  @override
  String get billingActiveOptions => 'Opciones activas';

  @override
  String get billingNoOptions => 'Ninguna opción activa.';

  @override
  String get optionNotActive => 'Esta opción no está activa para esta empresa.';

  @override
  String get apiProNotActive =>
      'La opción «API Pro» no está activa para esta empresa.';

  @override
  String get apiKeySaved => 'Clave guardada.';

  @override
  String get apiKeyIncomplete =>
      'Pon un nombre a la clave y elige al menos un permiso.';

  @override
  String get billingApiPro1 => 'Opción «API Pro» (1 clave)';

  @override
  String get billingApiPro10 => 'Opción «API Pro» (10 claves)';

  @override
  String get billingApiPro10Upgrade => 'Pasar a 10 claves';

  @override
  String get billingProKeysNext => 'En la próxima renovación';

  @override
  String get billingProKeys1 => '1 clave';

  @override
  String get billingProKeys10 => '10 claves';

  @override
  String billingProKeysWarning(String count) {
    return '$count claves están activas: en la renovación, solo la más antigua seguirá activa. Elegirás cuál conservar en «Acceso API».';
  }

  @override
  String get billingApiIncluded => 'Lectura incluida en «API Pro».';

  @override
  String billingLinePro10Addon(String start, String end, String months) {
    return 'Opción «API Pro», 10 claves, añadida durante la suscripción, del $start al $end: $months meses, sin descuento';
  }

  @override
  String billingLinePro10Upgrade(String start, String end, String months) {
    return 'Paso de «API Pro» a 10 claves, del $start al $end: $months meses (diferencia de precio), sin descuento';
  }

  @override
  String apiKeysCount(String count, String limit) {
    return 'Claves activas: $count / $limit';
  }

  @override
  String get apiKeyDisabled => 'Desactivada: más allá de tu plan API';

  @override
  String get apiKeyEnable => 'Reactivar';

  @override
  String get apiKeyDisable => 'Apartar';

  @override
  String get apiKeyLimitReached =>
      'Tu plan no permite más claves: aparta una clave o pasa a un plan superior.';

  @override
  String noticeApiKeysDeletion(String company, String date) {
    return '$company: acceso API detenido, las claves se eliminarán el $date salvo que se vuelva a contratar la opción.';
  }
}
