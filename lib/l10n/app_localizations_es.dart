// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Money Nest';

  @override
  String get appTagline => 'Calcula tu futuro';

  @override
  String get home => 'Inicio';

  @override
  String get saved => 'Guardado';

  @override
  String get history => 'Historial';

  @override
  String get settings => 'Ajustes';

  @override
  String get compare => 'Comparar';

  @override
  String get simulate => 'Simular';

  @override
  String get mainTools => 'Herramientas principales';

  @override
  String categories(int count) {
    return '$count CATEGORÍAS';
  }

  @override
  String get loanCalc => 'Préstamo';

  @override
  String get loanCalcSubtitle => 'Pagos mensuales';

  @override
  String get interestCalc => 'Interés';

  @override
  String get interestCalcSubtitle => 'Simple y compuesto';

  @override
  String get vault => 'Bóveda';

  @override
  String get vaultSubtitle => 'Planifica tu futuro';

  @override
  String get historySubtitle => 'Cálculos anteriores';

  @override
  String get proAccess => 'ACCESO PRO';

  @override
  String get upgradeToPremium => 'Actualizar a Premium';

  @override
  String get premiumBannerDesc =>
      'Desbloquea gráficos avanzados\ny experiencia sin anuncios.';

  @override
  String get marketPulse => 'PULSO DEL MERCADO';

  @override
  String get currentRates => 'Tasas actuales';

  @override
  String get homeLoan => 'Préstamo hipotecario';

  @override
  String get savingsApy => 'APY de ahorro';

  @override
  String get calculatorSimpleInterest => 'Interés Simple';

  @override
  String get calculatorCompoundInterest => 'Interés Compuesto';

  @override
  String get calculatorLoan => 'Calculadora de Préstamos';

  @override
  String get calculatorSavings => 'Calculadora de Ahorros';

  @override
  String get principal => 'Capital';

  @override
  String get interestRate => 'Tasa de Interés';

  @override
  String get annualInterestRate => 'Tasa de Interés (Anual)';

  @override
  String get term => 'Plazo';

  @override
  String get termMonths => 'Plazo (meses)';

  @override
  String get termYears => 'Plazo (años)';

  @override
  String get monthlyPayment => 'Pago Mensual';

  @override
  String get firstMonthPayment => 'Pago del primer mes';

  @override
  String get lastMonthPayment => 'Pago del último mes';

  @override
  String get totalInterest => 'Interés Total';

  @override
  String get totalPayment => 'Pago Total';

  @override
  String get interest => 'Interés';

  @override
  String get totalAmount => 'Monto Total';

  @override
  String get interestPrincipalRatio => 'Relación Interés/Capital';

  @override
  String get loanAmount => 'Monto del préstamo';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get loanTypeFixed => 'Cuota Fija';

  @override
  String get loanTypeReducing => 'Saldo Reducido';

  @override
  String get savingsTypeReinvest => 'Reinvertir';

  @override
  String get savingsTypeWithdraw => 'Retirar';

  @override
  String get results => 'Resultados';

  @override
  String get paymentStructure => 'Estructura de pagos';

  @override
  String get amortizationSchedule => 'Tabla de Amortización';

  @override
  String get month => 'Mes';

  @override
  String get year => 'Año';

  @override
  String get years => 'años';

  @override
  String get payment => 'Pago';

  @override
  String get principalPaid => 'Capital';

  @override
  String get interestPaid => 'Interés';

  @override
  String get balance => 'Saldo';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get share => 'Compartir';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get calculate => 'Calcular';

  @override
  String get reset => 'Reiniciar';

  @override
  String get close => 'Cerrar';

  @override
  String get add => 'Agregar';

  @override
  String get storageLimitTitle => 'Límite de almacenamiento';

  @override
  String storageLimitLoans(int count) {
    return 'Has guardado el máximo de $count préstamos. ¡Actualiza a Premium para guardar sin límites!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Has guardado el máximo de $count ahorros. ¡Actualiza a Premium para guardar sin límites!';
  }

  @override
  String get saveLoan => 'Guardar préstamo';

  @override
  String get loanNameHint => 'Nombre del préstamo (opcional)';

  @override
  String get amount => 'Monto';

  @override
  String get rate => 'Tasa';

  @override
  String get loanSaved => 'Préstamo guardado';

  @override
  String get saveSavings => 'Guardar ahorro';

  @override
  String get savingsNameHint => 'Nombre del ahorro (opcional)';

  @override
  String get savingsSaved => 'Ahorro guardado';

  @override
  String get savedLoans => 'Préstamos Guardados';

  @override
  String get savedSavings => 'Ahorros Guardados';

  @override
  String loansCount(int count) {
    return 'Préstamos ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Ahorros ($count)';
  }

  @override
  String get noSavedItems => 'No hay elementos guardados';

  @override
  String get noSavedLoans => 'No hay préstamos guardados';

  @override
  String get noSavedLoansSubtitle =>
      'Calcula y guarda préstamos para verlos después';

  @override
  String get noSavedSavings => 'No hay ahorros guardados';

  @override
  String get noSavedSavingsSubtitle =>
      'Calcula y guarda ahorros para verlos después';

  @override
  String errorLoading(String error) {
    return 'Error: $error';
  }

  @override
  String get compoundingFrequency => 'Frecuencia de capitalización';

  @override
  String get daily => 'Diario';

  @override
  String get monthly => 'Mensual';

  @override
  String get quarterly => 'Trimestral';

  @override
  String get yearly => 'Anual';

  @override
  String get calculationResults => 'Resultados del cálculo';

  @override
  String get totalReceived => 'Total recibido';

  @override
  String get interestEarned => 'Intereses ganados';

  @override
  String get effectiveAnnualRate => 'Tasa efectiva anual';

  @override
  String get compoundingPeriods => 'Períodos de capitalización';

  @override
  String get compareWithSimple => 'Comparar con interés simple';

  @override
  String get simpleInterest => 'Interés simple';

  @override
  String get compoundInterest => 'Interés compuesto';

  @override
  String compoundBenefit(String amount) {
    return 'El interés compuesto te genera $amount más';
  }

  @override
  String get savingsType => 'Tipo de ahorro';

  @override
  String get initialDeposit => 'Depósito inicial';

  @override
  String get monthlyDeposit => 'Depósito mensual';

  @override
  String get annualRate => 'Tasa anual';

  @override
  String get finalBalance => 'Saldo final';

  @override
  String get totalDeposited => 'Total depositado';

  @override
  String get returnRate => 'Tasa de retorno';

  @override
  String get avgMonthlyInterest => 'Interés mensual promedio';

  @override
  String get detailedAnalysis => 'Análisis detallado';

  @override
  String get deposits => 'Depósitos';

  @override
  String get reinvestInfo => 'Los intereses se capitalizan mensualmente';

  @override
  String get withdrawInfo =>
      'Los intereses se pagan mensualmente, sin capitalizar';

  @override
  String get averageMonthlyInterest => 'Interés promedio/mes';

  @override
  String get totalStructure => 'Estructura total';

  @override
  String get premium => 'Actualizar a Premium';

  @override
  String get premiumActivated => '¡Eres Premium!';

  @override
  String get premiumMember => 'Miembro Premium';

  @override
  String get premiumThanks => '¡Gracias por tu apoyo!';

  @override
  String get premiumDescription => 'Desbloquea todas las funciones';

  @override
  String get premiumFeature1 => 'Guardados ilimitados';

  @override
  String get premiumFeature1Desc => 'Guarda todos tus préstamos y ahorros';

  @override
  String get premiumFeature2 => 'Gráficos completos';

  @override
  String get premiumFeature2Desc =>
      'Ver detalles con todos los tipos de gráficos';

  @override
  String get premiumFeature3 => 'Comparación de escenarios';

  @override
  String get premiumFeature3Desc => 'Compara múltiples opciones lado a lado';

  @override
  String get premiumFeature4 => 'Exportar PDF';

  @override
  String get premiumFeature4Desc =>
      'Crea informes detallados para imprimir o compartir';

  @override
  String get premiumFeature5 => 'Apoyar el desarrollo';

  @override
  String get premiumFeature5Desc => 'Ayúdanos a mejorar la aplicación';

  @override
  String get premiumFeatures => 'Funciones Premium';

  @override
  String get lifetime => 'De por vida';

  @override
  String get oneTimePurchase => 'Paga una vez, usa para siempre';

  @override
  String get upgradeNow => 'Actualizar ahora';

  @override
  String get restorePurchase => 'Restaurar Compra';

  @override
  String purchaseDate(String date) {
    return 'Fecha de compra: $date';
  }

  @override
  String get premiumRequired => 'Premium requerido';

  @override
  String upgradeTo(String feature) {
    return 'Actualizar a $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Activado';

  @override
  String get unlockAllFeatures => 'Desbloquear todas las funciones';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get language => 'Idioma';

  @override
  String get about => 'Acerca de';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get error => 'Error';

  @override
  String get errorGeneric => 'Algo salió mal';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Actualizar';

  @override
  String get compareScenarios => 'Comparar escenarios';

  @override
  String get upgradeToCompare => 'Actualiza para comparar escenarios';

  @override
  String get loanSettings => 'Configuración de préstamo';

  @override
  String get scenarioA => 'Escenario A';

  @override
  String get scenarioB => 'Escenario B';

  @override
  String get comparison => 'Comparación';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Escenario $scenario ahorra $amount';
  }

  @override
  String get simulation => 'Simulación';

  @override
  String get noScenariosYet => 'Aún no hay escenarios';

  @override
  String get addScenariosSubtitle =>
      'Agrega préstamos o ahorros para\nsimular tus finanzas';

  @override
  String get addLoan => 'Agregar préstamo';

  @override
  String get addSavings => 'Agregar ahorro';

  @override
  String get loans => 'Préstamos';

  @override
  String get savings => 'Ahorros';

  @override
  String get timeline => 'Línea de tiempo';

  @override
  String monthNumber(int number) {
    return 'Mes $number';
  }

  @override
  String get netWorth => 'Patrimonio neto';

  @override
  String get positive => 'Positivo';

  @override
  String get negativeDebt => 'Negativo (deuda)';

  @override
  String get now => 'Ahora';

  @override
  String yearsCount(int count) {
    return '$count años';
  }

  @override
  String get debt => 'Deuda';

  @override
  String get remaining => 'Restante';

  @override
  String get clearAll => '¿Borrar todo?';

  @override
  String get allScenariosDeleted => 'Se eliminarán todos los escenarios.';

  @override
  String get loanNameHintExample => 'Nombre del préstamo (ej. Hipoteca)';

  @override
  String get savingsNameHintExample => 'Nombre (ej. Jubilación)';

  @override
  String get deposit => 'Depósito';

  @override
  String get loan => 'Préstamo';

  @override
  String get selectThemeDescription => 'Elige un tema para tu aplicación';

  @override
  String get selectLanguageDescription => 'Elige tu idioma preferido';

  @override
  String get apply => 'Aplicar';

  @override
  String get financialTools => 'Herramientas financieras';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get paymentRemindersSubtitle => 'Seguimiento de vencimientos';

  @override
  String get savingsGoalsSubtitle => 'Alcanza tus metas';

  @override
  String get calendar => 'Calendario';

  @override
  String get calendarSubtitle => 'Ver todos los eventos';

  @override
  String get achievementsSubtitle => 'Tu progreso';

  @override
  String get reportsSubtitle => 'Ver estadísticas';

  @override
  String get rateAlertsSubtitle => 'Monitorear tasas';

  @override
  String get paymentReminders => 'Recordatorios de pago';

  @override
  String get noRemindersYet => 'Aún no hay recordatorios';

  @override
  String get addRemindersSubtitle => 'Agrega recordatorios de pago';

  @override
  String get addReminder => 'Agregar recordatorio';

  @override
  String get editReminder => 'Editar recordatorio';

  @override
  String get reminderNameHint =>
      'Nombre del recordatorio (ej. Tarjeta de crédito)';

  @override
  String get dueDate => 'Fecha de vencimiento';

  @override
  String get remindBefore => 'Recordar antes';

  @override
  String get days => 'días';

  @override
  String get recurring => 'Recurrente';

  @override
  String get totalDue => 'Total adeudado';

  @override
  String get overdue => 'Vencido';

  @override
  String get upcoming => 'Próximo';

  @override
  String get completed => 'Completado';

  @override
  String get markAsPaid => 'Marcar como pagado';

  @override
  String get markAsPaidConfirm => '¿Estás seguro de marcar esto como pagado?';

  @override
  String get pending => 'Pendiente';

  @override
  String get paid => 'Pagado';

  @override
  String get skipped => 'Omitido';

  @override
  String get markPaid => 'Marcar pagado';

  @override
  String get weekly => 'Semanal';

  @override
  String get biWeekly => 'Quincenal';

  @override
  String get dueToday => 'Vence hoy';

  @override
  String get dueTomorrow => 'Vence mañana';

  @override
  String dueInDays(int days) {
    return 'Vence en $days días';
  }

  @override
  String get pleaseEnterName => 'Por favor ingresa un nombre';

  @override
  String get savingsGoals => 'Metas de ahorro';

  @override
  String get noGoalsYet => 'Aún no hay metas';

  @override
  String get addGoalsSubtitle =>
      'Establece metas de ahorro y sigue tu progreso';

  @override
  String get addGoal => 'Agregar meta';

  @override
  String get editGoal => 'Editar meta';

  @override
  String get goalNameHint => 'Nombre de la meta (ej. Vacaciones)';

  @override
  String get targetAmount => 'Monto objetivo';

  @override
  String get initialAmount => 'Monto inicial';

  @override
  String get deadline => 'Fecha límite';

  @override
  String get suggestedMonthly => 'Sugerido mensual';

  @override
  String get activeGoals => 'Metas activas';

  @override
  String get completedGoals => 'Metas completadas';

  @override
  String get totalSaved => 'Total ahorrado';

  @override
  String get totalTarget => 'Meta total';

  @override
  String get ofTotalTarget => 'de la meta total';

  @override
  String get milestones => 'Hitos';

  @override
  String get addMoney => 'Agregar dinero';

  @override
  String get withdraw => 'Retirar';

  @override
  String get addContribution => 'Agregar contribución';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get withdrawReason => 'Razón del retiro';

  @override
  String get noContributionsYet => 'Aún no hay contribuciones';

  @override
  String get pauseGoal => 'Pausar meta';

  @override
  String get deleteGoal => 'Eliminar meta';

  @override
  String get deleteGoalConfirm => '¿Estás seguro de eliminar esta meta?';

  @override
  String get target => 'Meta';

  @override
  String get goals => 'Metas';

  @override
  String savePerMonth(String amount) {
    return 'Ahorra $amount/mes para alcanzar la meta';
  }

  @override
  String get pleaseEnterGoalName => 'Por favor ingresa un nombre para la meta';

  @override
  String get withdrawal => 'Retiro';

  @override
  String get start => 'Inicio';

  @override
  String get goalReached => '¡Meta alcanzada!';

  @override
  String get progress => 'Progreso';

  @override
  String get achievements => 'Logros';

  @override
  String get financialHealthScore => 'Puntuación de salud financiera';

  @override
  String get financialHealth => 'Salud financiera';

  @override
  String get points => 'puntos';

  @override
  String get healthExcellent => '¡Excelente! ¡Sigue así!';

  @override
  String get healthGood => '¡Buen progreso! Vas por buen camino.';

  @override
  String get healthFair => 'Regular. Hay margen de mejora.';

  @override
  String get healthNeedsWork => 'Necesita atención. ¡Mejoremos juntos!';

  @override
  String get paymentStreak => 'Racha de pagos';

  @override
  String get dayStreak => 'días de racha';

  @override
  String get keepItUp => '¡Sigue así!';

  @override
  String get longest => 'Más larga';

  @override
  String get unlocked => 'Desbloqueado';

  @override
  String get locked => 'Bloqueado';

  @override
  String get financialCalendar => 'Calendario financiero';

  @override
  String get monthView => 'Vista mensual';

  @override
  String get weekView => 'Vista semanal';

  @override
  String get today => 'Hoy';

  @override
  String get noEventsForDay => 'No hay eventos para este día';

  @override
  String get goalDeadline => 'Fecha límite de meta';

  @override
  String get contribution => 'Contribución';

  @override
  String get reports => 'Reportes';

  @override
  String get week => 'Semana';

  @override
  String get quarter => 'Trimestre';

  @override
  String get allTime => 'Todo el tiempo';

  @override
  String get totalPaid => 'Total pagado';

  @override
  String get totalDebt => 'Deuda total';

  @override
  String get debtVsPaid => 'Deuda vs Pagado';

  @override
  String get outstanding => 'Pendiente';

  @override
  String get noDataYet => 'Aún no hay datos';

  @override
  String get monthlyOverview => 'Resumen mensual';

  @override
  String get due => 'Vence';

  @override
  String get paymentPerformance => 'Rendimiento de pagos';

  @override
  String get onTime => 'A tiempo';

  @override
  String get late => 'Tarde';

  @override
  String get onTimeRate => 'Tasa de puntualidad';

  @override
  String get rateAlerts => 'Alertas de tasas';

  @override
  String get currentMarketRates => 'Tasas de mercado actuales';

  @override
  String get edit => 'Editar';

  @override
  String get triggeredAlerts => 'Alertas activadas';

  @override
  String get activeAlerts => 'Alertas activas';

  @override
  String get inactiveAlerts => 'Alertas inactivas';

  @override
  String get noAlertsYet => 'Aún no hay alertas';

  @override
  String get addAlertsSubtitle => 'Agrega alertas para seguir cambios de tasas';

  @override
  String get addAlert => 'Agregar alerta';

  @override
  String get alertNameHint => 'Nombre de alerta (ej. Tasa hipotecaria)';

  @override
  String get loanType => 'Tipo de préstamo';

  @override
  String get alertWhen => 'Alertar cuando';

  @override
  String get rateDrops => 'La tasa baja';

  @override
  String get rateRises => 'La tasa sube';

  @override
  String get targetRate => 'Tasa objetivo';

  @override
  String get when => 'Cuándo';

  @override
  String get current => 'Actual';

  @override
  String get triggered => 'Activada';

  @override
  String get editMarketRates => 'Editar tasas de mercado';

  @override
  String get personalLoan => 'Préstamo personal';

  @override
  String get carLoan => 'Préstamo de auto';

  @override
  String get savingsRate => 'Tasa de ahorro';

  @override
  String get homeShort => 'Hipoteca';

  @override
  String get personalShort => 'Personal';

  @override
  String get carShort => 'Auto';

  @override
  String get savingsShort => 'Ahorro';

  @override
  String get rateDropAlert => '¡Alerta de baja de tasa!';

  @override
  String get rateIncreaseAlert => '¡Alerta de subida de tasa!';

  @override
  String get updated => 'Actualizado';

  @override
  String get newUpdateAvailable => 'Actualización disponible';

  @override
  String get updateAppMessage =>
      'Hay una nueva versión disponible. Actualiza para obtener las últimas funciones y mejoras.';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get later => 'Más tarde';

  @override
  String get qrTools => 'Herramientas QR';

  @override
  String get createQRCode => 'Crear código QR';

  @override
  String get createQRSubtitle => 'Generar códigos QR';

  @override
  String get scanQRCode => 'Escanear código QR';

  @override
  String get scanQRSubtitle => 'Escanear cualquier código QR';

  @override
  String get selectQRType => 'Seleccionar tipo de QR';

  @override
  String get qrLink => 'Enlace';

  @override
  String get qrText => 'Texto';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'Contacto';

  @override
  String get qrCode => 'Código QR';

  @override
  String get websiteAddress => 'Dirección del sitio web';

  @override
  String get textContent => 'Contenido de texto';

  @override
  String get enterContent => 'Ingresa tu contenido aquí';

  @override
  String get networkNameSSID => 'Nombre de red (SSID)';

  @override
  String get wifiPasswordLabel => 'Contraseña';

  @override
  String get encryptionType => 'Tipo de cifrado';

  @override
  String get noEncryption => 'Sin cifrado';

  @override
  String get contactName => 'Nombre del contacto';

  @override
  String get contactNameHint => 'Juan Pérez';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get generateQRButton => 'Generar código QR';

  @override
  String get qrGeneratedOnDevice => 'El código QR se genera en tu dispositivo';

  @override
  String get qrLinkInfo =>
      'Ingresa una URL para crear un código QR que abre el enlace al escanearlo.';

  @override
  String get qrWifiInfo =>
      'Crea un código QR que permite conectarse rápidamente a tu red WiFi.';

  @override
  String get pleaseEnterWebsite => 'Por favor ingresa una dirección web';

  @override
  String get pleaseEnterTextContent => 'Por favor ingresa contenido de texto';

  @override
  String get pleaseEnterWifiName =>
      'Por favor ingresa el nombre de la red WiFi';

  @override
  String get pleaseEnterContactName =>
      'Por favor ingresa el nombre del contacto';

  @override
  String get copy => 'Copiar';

  @override
  String get copyData => 'Copiar datos';

  @override
  String get dataCopied => 'Datos copiados al portapapeles';

  @override
  String get saveToGallery => 'Guardar en galería';

  @override
  String get qrPrivacyNote =>
      'Este código QR se genera localmente en tu dispositivo y no se envía a ningún servidor.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Contacto: $name';
  }

  @override
  String get cannotCreateQRImage => 'No se puede crear imagen QR';

  @override
  String get cannotSaveQR => 'No se puede guardar código QR';

  @override
  String get qrSavedToGallerySuccess => 'Código QR guardado en galería';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get scanAgain => 'Escanear de nuevo';

  @override
  String get openLink => 'Abrir enlace';

  @override
  String get copyPassword => 'Copiar contraseña';

  @override
  String get passwordCopied => 'Contraseña copiada al portapapeles';

  @override
  String get noQRCodeFound => 'No se encontró código QR en la imagen';

  @override
  String get pointCameraAtQR => 'Apunta la cámara al código QR';

  @override
  String get scanFromGallery => 'Escanear desde galería';

  @override
  String get websiteLink => 'Enlace web';

  @override
  String get wifiNetworkLabel => 'Red WiFi';

  @override
  String get openInBrowser => 'Abrir en navegador';

  @override
  String get wifiCredentials => 'Credenciales WiFi';

  @override
  String get contactInformation => 'Información de contacto';

  @override
  String get plainTextContent => 'Contenido de texto plano';

  @override
  String get reportIssue => 'Reportar problema';

  @override
  String get reportIssueSubtitle => 'Envíanos comentarios';
}
