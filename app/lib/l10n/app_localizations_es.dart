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
}
