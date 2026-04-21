// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'Calcule Seu Futuro';

  @override
  String get home => 'Início';

  @override
  String get saved => 'Salvos';

  @override
  String get history => 'Histórico';

  @override
  String get settings => 'Configurações';

  @override
  String get compare => 'Comparar';

  @override
  String get simulate => 'Simular';

  @override
  String get mainTools => 'Ferramentas Principais';

  @override
  String categories(int count) {
    return '$count CATEGORIAS';
  }

  @override
  String get loanCalc => 'Calc Empréstimo';

  @override
  String get loanCalcSubtitle => 'Parcelas mensais';

  @override
  String get interestCalc => 'Juros';

  @override
  String get interestCalcSubtitle => 'Simples e compostos';

  @override
  String get vault => 'Cofre';

  @override
  String get vaultSubtitle => 'Planeje seu futuro';

  @override
  String get historySubtitle => 'Cálculos anteriores';

  @override
  String get proAccess => 'ACESSO PRO';

  @override
  String get upgradeToPremium => 'Atualizar para Premium';

  @override
  String get premiumBannerDesc =>
      'Desbloqueie gráficos avançados\ne experiência sem anúncios.';

  @override
  String get marketPulse => 'PULSO DO MERCADO';

  @override
  String get currentRates => 'Taxas Atuais';

  @override
  String get homeLoan => 'Financiamento';

  @override
  String get savingsApy => 'Rendimento';

  @override
  String get calculatorSimpleInterest => 'Juros Simples';

  @override
  String get calculatorCompoundInterest => 'Juros Compostos';

  @override
  String get calculatorLoan => 'Calculadora de Empréstimo';

  @override
  String get calculatorSavings => 'Calculadora de Poupança';

  @override
  String get principal => 'Capital';

  @override
  String get interestRate => 'Taxa de Juros';

  @override
  String get annualInterestRate => 'Taxa de Juros (Anual)';

  @override
  String get term => 'Prazo';

  @override
  String get termMonths => 'Prazo (meses)';

  @override
  String get termYears => 'Prazo (anos)';

  @override
  String get monthlyPayment => 'Parcela Mensal';

  @override
  String get firstMonthPayment => 'Primeira Parcela';

  @override
  String get lastMonthPayment => 'Última Parcela';

  @override
  String get totalInterest => 'Juros Totais';

  @override
  String get totalPayment => 'Pagamento Total';

  @override
  String get interest => 'Juros';

  @override
  String get totalAmount => 'Valor Total';

  @override
  String get interestPrincipalRatio => 'Proporção Juros/Capital';

  @override
  String get loanAmount => 'Valor do Empréstimo';

  @override
  String get paymentMethod => 'Método de Pagamento';

  @override
  String get loanTypeFixed => 'Parcela Fixa';

  @override
  String get loanTypeReducing => 'Saldo Devedor';

  @override
  String get savingsTypeReinvest => 'Reinvestir';

  @override
  String get savingsTypeWithdraw => 'Sacar';

  @override
  String get results => 'Resultados';

  @override
  String get paymentStructure => 'Estrutura de Pagamento';

  @override
  String get amortizationSchedule => 'Tabela de Amortização';

  @override
  String get month => 'Mês';

  @override
  String get year => 'Ano';

  @override
  String get years => 'anos';

  @override
  String get payment => 'Pagamento';

  @override
  String get principalPaid => 'Capital';

  @override
  String get interestPaid => 'Juros';

  @override
  String get balance => 'Saldo';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get share => 'Compartilhar';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get calculate => 'Calcular';

  @override
  String get reset => 'Reiniciar';

  @override
  String get close => 'Fechar';

  @override
  String get add => 'Adicionar';

  @override
  String get storageLimitTitle => 'Limite de Armazenamento';

  @override
  String storageLimitLoans(int count) {
    return 'Você salvou o máximo de $count empréstimos. Atualize para Premium para salvamentos ilimitados!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Você salvou o máximo de $count poupanças. Atualize para Premium para salvamentos ilimitados!';
  }

  @override
  String get saveLoan => 'Salvar Empréstimo';

  @override
  String get loanNameHint => 'Nome do empréstimo (opcional)';

  @override
  String get amount => 'Valor';

  @override
  String get rate => 'Taxa';

  @override
  String get loanSaved => 'Empréstimo salvo';

  @override
  String get saveSavings => 'Salvar Poupança';

  @override
  String get savingsNameHint => 'Nome da poupança (opcional)';

  @override
  String get savingsSaved => 'Poupança salva';

  @override
  String get savedLoans => 'Empréstimos Salvos';

  @override
  String get savedSavings => 'Poupanças Salvas';

  @override
  String loansCount(int count) {
    return 'Empréstimos ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Poupanças ($count)';
  }

  @override
  String get noSavedItems => 'Nenhum item salvo ainda';

  @override
  String get noSavedLoans => 'Nenhum empréstimo salvo';

  @override
  String get noSavedLoansSubtitle =>
      'Calcule e salve empréstimos para ver depois';

  @override
  String get noSavedSavings => 'Nenhuma poupança salva';

  @override
  String get noSavedSavingsSubtitle =>
      'Calcule e salve poupanças para ver depois';

  @override
  String errorLoading(String error) {
    return 'Erro: $error';
  }

  @override
  String get compoundingFrequency => 'Frequência de Capitalização';

  @override
  String get daily => 'Diário';

  @override
  String get monthly => 'Mensal';

  @override
  String get quarterly => 'Trimestral';

  @override
  String get yearly => 'Anual';

  @override
  String get calculationResults => 'Resultados do Cálculo';

  @override
  String get totalReceived => 'Total Recebido';

  @override
  String get interestEarned => 'Juros Ganhos';

  @override
  String get effectiveAnnualRate => 'Taxa Anual Efetiva';

  @override
  String get compoundingPeriods => 'Períodos de Capitalização';

  @override
  String get compareWithSimple => 'Comparar com Juros Simples';

  @override
  String get simpleInterest => 'Juros Simples';

  @override
  String get compoundInterest => 'Juros Compostos';

  @override
  String compoundBenefit(String amount) {
    return 'Os juros compostos rendem $amount a mais';
  }

  @override
  String get savingsType => 'Tipo de Poupança';

  @override
  String get initialDeposit => 'Depósito Inicial';

  @override
  String get monthlyDeposit => 'Depósito Mensal';

  @override
  String get annualRate => 'Taxa Anual';

  @override
  String get finalBalance => 'Saldo Final';

  @override
  String get totalDeposited => 'Total Depositado';

  @override
  String get returnRate => 'Taxa de Retorno';

  @override
  String get avgMonthlyInterest => 'Média de Juros Mensais';

  @override
  String get detailedAnalysis => 'Análise Detalhada';

  @override
  String get deposits => 'Depósitos';

  @override
  String get reinvestInfo => 'Os juros são capitalizados mensalmente';

  @override
  String get withdrawInfo =>
      'Os juros são pagos mensalmente, sem capitalização';

  @override
  String get averageMonthlyInterest => 'Juros Médios/Mês';

  @override
  String get totalStructure => 'Estrutura Total';

  @override
  String get premium => 'Atualizar para Premium';

  @override
  String get premiumActivated => 'Você é Premium!';

  @override
  String get premiumMember => 'Membro Premium';

  @override
  String get premiumThanks => 'Obrigado pelo seu apoio!';

  @override
  String get premiumDescription => 'Desbloqueie todos os recursos';

  @override
  String get premiumFeature1 => 'Salvamentos ilimitados';

  @override
  String get premiumFeature1Desc =>
      'Armazene todos os seus empréstimos e poupanças';

  @override
  String get premiumFeature2 => 'Suite completa de gráficos';

  @override
  String get premiumFeature2Desc =>
      'Veja detalhes com todos os tipos de gráficos';

  @override
  String get premiumFeature3 => 'Comparação de cenários';

  @override
  String get premiumFeature3Desc => 'Compare várias opções lado a lado';

  @override
  String get premiumFeature4 => 'Exportar PDF';

  @override
  String get premiumFeature4Desc =>
      'Crie relatórios detalhados para imprimir ou compartilhar';

  @override
  String get premiumFeature5 => 'Apoie o desenvolvimento';

  @override
  String get premiumFeature5Desc => 'Ajude-nos a melhorar o aplicativo';

  @override
  String get premiumFeatures => 'Recursos Premium';

  @override
  String get lifetime => 'Vitalício';

  @override
  String get oneTimePurchase => 'Pague uma vez, use para sempre';

  @override
  String get upgradeNow => 'Atualizar Agora';

  @override
  String get restorePurchase => 'Restaurar Compra';

  @override
  String purchaseDate(String date) {
    return 'Data da compra: $date';
  }

  @override
  String get premiumRequired => 'Premium Necessário';

  @override
  String get premiumMonthlyTitle => 'Premium Monthly Subscription';

  @override
  String get premiumYearlyTitle => 'Premium Yearly Subscription';

  @override
  String get premiumLifetimeTitle => 'Premium Lifetime Access';

  @override
  String get billedMonthly => 'Billed monthly';

  @override
  String get billedAnnually => 'Billed annually';

  @override
  String get payOnceOwnForever => 'Pay once, own forever';

  @override
  String get perMonth => 'per month';

  @override
  String get perYear => 'per year';

  @override
  String get oneTime => 'one-time';

  @override
  String get subscriptionPaymentInfo =>
      'Payment will be charged to your Apple ID account at confirmation of purchase.';

  @override
  String get subscriptionAutoRenewInfo =>
      'Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period. You can manage and cancel subscriptions in your App Store account settings.';

  @override
  String upgradeTo(String feature) {
    return 'Atualizar para $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Ativado';

  @override
  String get unlockAllFeatures => 'Desbloqueie todos os recursos';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get language => 'Idioma';

  @override
  String get about => 'Sobre';

  @override
  String version(String version) {
    return 'Versão $version';
  }

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get error => 'Erro';

  @override
  String get errorGeneric => 'Algo deu errado';

  @override
  String get tryAgain => 'Tentar Novamente';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Atualizar';

  @override
  String get compareScenarios => 'Comparar Cenários';

  @override
  String get upgradeToCompare => 'Atualize para comparar cenários';

  @override
  String get loanSettings => 'Configurações do Empréstimo';

  @override
  String get scenarioA => 'Cenário A';

  @override
  String get scenarioB => 'Cenário B';

  @override
  String get comparison => 'Comparação';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Cenário $scenario economiza $amount';
  }

  @override
  String get simulation => 'Simulação';

  @override
  String get noScenariosYet => 'Nenhum cenário ainda';

  @override
  String get addScenariosSubtitle =>
      'Adicione empréstimos ou poupanças para simular\nsuas finanças ao longo do tempo';

  @override
  String get addLoan => 'Adicionar Empréstimo';

  @override
  String get addSavings => 'Adicionar Poupança';

  @override
  String get loans => 'Empréstimos';

  @override
  String get savings => 'Poupanças';

  @override
  String get timeline => 'Linha do Tempo';

  @override
  String monthNumber(int number) {
    return 'Mês $number';
  }

  @override
  String get netWorth => 'Patrimônio Líquido';

  @override
  String get positive => 'Positivo';

  @override
  String get negativeDebt => 'Negativo (dívida)';

  @override
  String get now => 'Agora';

  @override
  String yearsCount(int count) {
    return '$count anos';
  }

  @override
  String get debt => 'Dívida';

  @override
  String get remaining => 'Restante';

  @override
  String get clearAll => 'Limpar Tudo?';

  @override
  String get allScenariosDeleted => 'Todos os cenários serão excluídos.';

  @override
  String get loanNameHintExample => 'Nome do empréstimo (ex: Financiamento)';

  @override
  String get savingsNameHintExample => 'Nome (ex: Aposentadoria)';

  @override
  String get deposit => 'Depósito';

  @override
  String get loan => 'Empréstimo';

  @override
  String get selectThemeDescription => 'Escolha um tema para o aplicativo';

  @override
  String get selectLanguageDescription => 'Escolha seu idioma preferido';

  @override
  String get apply => 'Aplicar';

  @override
  String get financialTools => 'Ferramentas Financeiras';

  @override
  String get reminders => 'Lembretes';

  @override
  String get paymentRemindersSubtitle => 'Acompanhe as datas de vencimento';

  @override
  String get savingsGoalsSubtitle => 'Alcance suas metas';

  @override
  String get calendar => 'Calendário';

  @override
  String get calendarSubtitle => 'Veja todos os eventos';

  @override
  String get achievementsSubtitle => 'Seu progresso';

  @override
  String get reportsSubtitle => 'Veja as estatísticas';

  @override
  String get rateAlertsSubtitle => 'Monitore as taxas';

  @override
  String get paymentReminders => 'Lembretes de Pagamento';

  @override
  String get noRemindersYet => 'Nenhum lembrete ainda';

  @override
  String get addRemindersSubtitle =>
      'Adicione lembretes de pagamento para se manter organizado';

  @override
  String get addReminder => 'Adicionar Lembrete';

  @override
  String get editReminder => 'Editar Lembrete';

  @override
  String get reminderNameHint => 'Nome do lembrete (ex: Cartão de Crédito)';

  @override
  String get dueDate => 'Data de Vencimento';

  @override
  String get remindBefore => 'Lembrar Antes';

  @override
  String get days => 'dias';

  @override
  String get recurring => 'Recorrente';

  @override
  String get totalDue => 'Total a Pagar';

  @override
  String get overdue => 'Vencido';

  @override
  String get upcoming => 'Próximo';

  @override
  String get completed => 'Concluído';

  @override
  String get markAsPaid => 'Marcar como Pago';

  @override
  String get markAsPaidConfirm => 'Tem certeza de que deseja marcar como pago?';

  @override
  String get pending => 'Pendente';

  @override
  String get paid => 'Pago';

  @override
  String get skipped => 'Ignorado';

  @override
  String get markPaid => 'Marcar Pago';

  @override
  String get weekly => 'Semanal';

  @override
  String get biWeekly => 'Quinzenal';

  @override
  String get dueToday => 'Vence hoje';

  @override
  String get dueTomorrow => 'Vence amanhã';

  @override
  String dueInDays(int days) {
    return 'Vence em $days dias';
  }

  @override
  String get pleaseEnterName => 'Por favor, insira um nome';

  @override
  String get savingsGoals => 'Metas de Poupança';

  @override
  String get noGoalsYet => 'Nenhuma meta ainda';

  @override
  String get addGoalsSubtitle =>
      'Defina metas de poupança e acompanhe seu progresso';

  @override
  String get addGoal => 'Adicionar Meta';

  @override
  String get editGoal => 'Editar Meta';

  @override
  String get goalNameHint => 'Nome da meta (ex: Viagem)';

  @override
  String get targetAmount => 'Valor Alvo';

  @override
  String get initialAmount => 'Valor Inicial';

  @override
  String get deadline => 'Prazo';

  @override
  String get suggestedMonthly => 'Sugestão Mensal';

  @override
  String get activeGoals => 'Metas Ativas';

  @override
  String get completedGoals => 'Metas Concluídas';

  @override
  String get totalSaved => 'Total Economizado';

  @override
  String get totalTarget => 'Meta Total';

  @override
  String get ofTotalTarget => 'da meta total';

  @override
  String get milestones => 'Marcos';

  @override
  String get addMoney => 'Adicionar Dinheiro';

  @override
  String get withdraw => 'Sacar';

  @override
  String get addContribution => 'Adicionar Contribuição';

  @override
  String get notesOptional => 'Observações (opcional)';

  @override
  String get withdrawReason => 'Motivo do saque';

  @override
  String get noContributionsYet => 'Nenhuma contribuição ainda';

  @override
  String get pauseGoal => 'Pausar Meta';

  @override
  String get deleteGoal => 'Excluir Meta';

  @override
  String get deleteGoalConfirm =>
      'Tem certeza de que deseja excluir esta meta?';

  @override
  String get target => 'Meta';

  @override
  String get goals => 'Metas';

  @override
  String savePerMonth(String amount) {
    return 'Economize $amount/mês para atingir a meta';
  }

  @override
  String get pleaseEnterGoalName => 'Por favor, insira um nome para a meta';

  @override
  String get withdrawal => 'Saque';

  @override
  String get start => 'Início';

  @override
  String get goalReached => 'Meta!';

  @override
  String get progress => 'Progresso';

  @override
  String get achievements => 'Conquistas';

  @override
  String get financialHealthScore => 'Índice de Saúde Financeira';

  @override
  String get financialHealth => 'Saúde Financeira';

  @override
  String get points => 'pontos';

  @override
  String get healthExcellent => 'Excelente! Continue com o ótimo trabalho!';

  @override
  String get healthGood => 'Bom progresso! Você está no caminho certo.';

  @override
  String get healthFair => 'Razoável. Há espaço para melhorias.';

  @override
  String get healthNeedsWork => 'Precisa de atenção. Vamos melhorar juntos!';

  @override
  String get paymentStreak => 'Sequência de Pagamentos';

  @override
  String get dayStreak => 'dias seguidos';

  @override
  String get keepItUp => 'Continue assim!';

  @override
  String get longest => 'Mais Longo';

  @override
  String get unlocked => 'Desbloqueado';

  @override
  String get locked => 'Bloqueado';

  @override
  String get financialCalendar => 'Calendário Financeiro';

  @override
  String get monthView => 'Visão Mensal';

  @override
  String get weekView => 'Visão Semanal';

  @override
  String get today => 'Hoje';

  @override
  String get noEventsForDay => 'Nenhum evento para este dia';

  @override
  String get goalDeadline => 'Prazo da Meta';

  @override
  String get contribution => 'Contribuição';

  @override
  String get reports => 'Relatórios';

  @override
  String get week => 'Semana';

  @override
  String get quarter => 'Trimestre';

  @override
  String get allTime => 'Todos os Tempos';

  @override
  String get totalPaid => 'Total Pago';

  @override
  String get totalDebt => 'Dívida Total';

  @override
  String get debtVsPaid => 'Dívida vs Pago';

  @override
  String get outstanding => 'Pendente';

  @override
  String get noDataYet => 'Nenhum dado ainda';

  @override
  String get monthlyOverview => 'Visão Geral Mensal';

  @override
  String get due => 'Vencimento';

  @override
  String get paymentPerformance => 'Desempenho de Pagamentos';

  @override
  String get onTime => 'No Prazo';

  @override
  String get late => 'Atrasado';

  @override
  String get onTimeRate => 'Taxa de Pontualidade';

  @override
  String get rateAlerts => 'Alertas de Taxa';

  @override
  String get currentMarketRates => 'Taxas de Mercado Atuais';

  @override
  String get edit => 'Editar';

  @override
  String get triggeredAlerts => 'Alertas Acionados';

  @override
  String get activeAlerts => 'Alertas Ativos';

  @override
  String get inactiveAlerts => 'Alertas Inativos';

  @override
  String get noAlertsYet => 'Nenhum alerta ainda';

  @override
  String get addAlertsSubtitle =>
      'Adicione alertas para acompanhar mudanças nas taxas de juros';

  @override
  String get addAlert => 'Adicionar Alerta';

  @override
  String get alertNameHint => 'Nome do alerta (ex: Taxa de Financiamento)';

  @override
  String get loanType => 'Tipo de Empréstimo';

  @override
  String get alertWhen => 'Alertar Quando';

  @override
  String get rateDrops => 'Taxa Cair';

  @override
  String get rateRises => 'Taxa Subir';

  @override
  String get targetRate => 'Taxa Alvo';

  @override
  String get when => 'Quando';

  @override
  String get current => 'Atual';

  @override
  String get triggered => 'Acionado';

  @override
  String get editMarketRates => 'Editar Taxas de Mercado';

  @override
  String get personalLoan => 'Empréstimo Pessoal';

  @override
  String get carLoan => 'Financiamento de Veículo';

  @override
  String get savingsRate => 'Taxa de Poupança';

  @override
  String get homeShort => 'Casa';

  @override
  String get personalShort => 'Pessoal';

  @override
  String get carShort => 'Carro';

  @override
  String get savingsShort => 'Poupança';

  @override
  String get rateDropAlert => 'Alerta de Queda de Taxa!';

  @override
  String get rateIncreaseAlert => 'Alerta de Aumento de Taxa!';

  @override
  String get updated => 'Atualizado';

  @override
  String get newUpdateAvailable => 'Atualização Disponível';

  @override
  String get updateAppMessage =>
      'Uma nova versão do aplicativo está disponível. Por favor, atualize para obter os recursos e melhorias mais recentes.';

  @override
  String get updateNow => 'Atualizar Agora';

  @override
  String get later => 'Mais Tarde';

  @override
  String get qrTools => 'Ferramentas QR';

  @override
  String get createQRCode => 'Criar Código QR';

  @override
  String get createQRSubtitle => 'Gerar códigos QR';

  @override
  String get scanQRCode => 'Escanear Código QR';

  @override
  String get scanQRSubtitle => 'Escanear qualquer código QR';

  @override
  String get selectQRType => 'Selecione o Tipo de QR';

  @override
  String get qrLink => 'Link';

  @override
  String get qrText => 'Texto';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'Contato';

  @override
  String get qrCode => 'Código QR';

  @override
  String get websiteAddress => 'Endereço do Site';

  @override
  String get textContent => 'Conteúdo de Texto';

  @override
  String get enterContent => 'Digite seu conteúdo aqui';

  @override
  String get networkNameSSID => 'Nome da Rede (SSID)';

  @override
  String get wifiPasswordLabel => 'Senha';

  @override
  String get encryptionType => 'Tipo de Criptografia';

  @override
  String get noEncryption => 'Sem Criptografia';

  @override
  String get contactName => 'Nome do Contato';

  @override
  String get contactNameHint => 'João Silva';

  @override
  String get phoneNumber => 'Número de Telefone';

  @override
  String get generateQRButton => 'Gerar Código QR';

  @override
  String get qrGeneratedOnDevice => 'O código QR é gerado no seu dispositivo';

  @override
  String get qrLinkInfo =>
      'Digite uma URL de site para criar um código QR que abre o link quando escaneado.';

  @override
  String get qrWifiInfo =>
      'Crie um código QR que permite que outras pessoas se conectem rapidamente à sua rede WiFi.';

  @override
  String get pleaseEnterWebsite => 'Por favor, insira um endereço de site';

  @override
  String get pleaseEnterTextContent => 'Por favor, insira o conteúdo de texto';

  @override
  String get pleaseEnterWifiName => 'Por favor, insira o nome da rede WiFi';

  @override
  String get pleaseEnterContactName => 'Por favor, insira o nome do contato';

  @override
  String get copy => 'Copiar';

  @override
  String get copyData => 'Copiar Dados';

  @override
  String get dataCopied => 'Dados copiados para a área de transferência';

  @override
  String get saveToGallery => 'Salvar na Galeria';

  @override
  String get qrPrivacyNote =>
      'Este código QR é gerado localmente no seu dispositivo e não é enviado para nenhum servidor.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Contato: $name';
  }

  @override
  String get cannotCreateQRImage => 'Não é possível criar imagem QR';

  @override
  String get cannotSaveQR => 'Não é possível salvar o código QR';

  @override
  String get qrSavedToGallerySuccess => 'Código QR salvo na galeria';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get scanAgain => 'Escanear Novamente';

  @override
  String get openLink => 'Abrir Link';

  @override
  String get copyPassword => 'Copiar Senha';

  @override
  String get passwordCopied => 'Senha copiada para a área de transferência';

  @override
  String get noQRCodeFound => 'Nenhum código QR encontrado na imagem';

  @override
  String get pointCameraAtQR => 'Aponte a câmera para o código QR';

  @override
  String get scanFromGallery => 'Escanear da galeria';

  @override
  String get websiteLink => 'Link do Site';

  @override
  String get wifiNetworkLabel => 'Rede WiFi';

  @override
  String get openInBrowser => 'Abrir no navegador';

  @override
  String get wifiCredentials => 'Credenciais WiFi';

  @override
  String get contactInformation => 'Informações de contato';

  @override
  String get plainTextContent => 'Conteúdo de texto simples';

  @override
  String get reportIssue => 'Relatar Problema';

  @override
  String get reportIssueSubtitle => 'Envie-nos seu feedback';

  @override
  String get earlyWithdrawal => 'Resgate Antecipado';

  @override
  String get earlyWithdrawalSubtitle => 'Calcular perda por resgate';

  @override
  String get depositAmount => 'Valor do depósito';

  @override
  String get termDepositRate => 'Taxa de depósito a prazo';

  @override
  String get demandDepositRate => 'Taxa de depósito à vista';

  @override
  String get originalTerm => 'Prazo original';

  @override
  String get actualHoldingPeriod => 'Período real de manutenção';

  @override
  String get withdrawalResult => 'Resultado do resgate';

  @override
  String get amountReceived => 'Valor recebido';

  @override
  String get actualInterestReceived => 'Juros reais recebidos';

  @override
  String get interestLost => 'Juros perdidos';

  @override
  String get lossPercentage => 'Percentual de perda';

  @override
  String get ifHeldToMaturity => 'Se mantido até o vencimento';

  @override
  String get youWillLose => 'Você perderá';

  @override
  String get earlyWithdrawalWarning => 'Aviso de resgate antecipado';

  @override
  String get earlyWithdrawalWarningDesc =>
      'O resgate antecipado aplica a taxa à vista em vez da taxa a prazo.';
}
