/*
 * MoneyMate - Dependency Providers
 * Riverpod Dependency Injection
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money/core/storage/local_storage_service.dart';

// ============================================================================
// CORE PROVIDERS
// ============================================================================

/// SharedPreferences provider (will be overridden in main)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main');
});

// ============================================================================
// STORAGE PROVIDERS
// ============================================================================

/// LocalStorage service provider
final localStorageProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});

/// Saved loans provider
final savedLoansProvider =
    StateNotifierProvider<SavedLoansNotifier, AsyncValue<List<SavedLoan>>>(
  (ref) => SavedLoansNotifier(ref.watch(localStorageProvider)),
);

/// Saved savings provider
final savedSavingsProvider =
    StateNotifierProvider<SavedSavingsNotifier, AsyncValue<List<SavedSavings>>>(
  (ref) => SavedSavingsNotifier(ref.watch(localStorageProvider)),
);

/// Premium status provider
final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(localStorageProvider).isPremium();
});

// ============================================================================
// NOTIFIERS
// ============================================================================

class SavedLoansNotifier extends StateNotifier<AsyncValue<List<SavedLoan>>> {
  final LocalStorageService _storage;

  SavedLoansNotifier(this._storage) : super(const AsyncValue.loading()) {
    loadLoans();
  }

  void loadLoans() {
    state = const AsyncValue.loading();
    try {
      final loans = _storage.getAllLoans();
      state = AsyncValue.data(loans);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> saveLoan(SavedLoan loan) async {
    final result = await _storage.saveLoan(loan);
    loadLoans();
    return result;
  }

  Future<bool> deleteLoan(String id) async {
    final result = await _storage.deleteLoan(id);
    loadLoans();
    return result;
  }

  int get count => _storage.getLoanCount();
}

class SavedSavingsNotifier
    extends StateNotifier<AsyncValue<List<SavedSavings>>> {
  final LocalStorageService _storage;

  SavedSavingsNotifier(this._storage) : super(const AsyncValue.loading()) {
    loadSavings();
  }

  void loadSavings() {
    state = const AsyncValue.loading();
    try {
      final savings = _storage.getAllSavings();
      state = AsyncValue.data(savings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> saveSavings(SavedSavings savings) async {
    final result = await _storage.saveSavings(savings);
    loadSavings();
    return result;
  }

  Future<bool> deleteSavings(String id) async {
    final result = await _storage.deleteSavings(id);
    loadSavings();
    return result;
  }

  int get count => _storage.getSavingsCount();
}
