<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProizvodController;
use App\Http\Controllers\CartController;

use App\Http\Controllers\ProfileController;

// ---------------------
// Homepage (index.blade.php)
// ---------------------
Route::get('/', [ProizvodController::class, 'home'])->name('index.index');

// ---------------------
// Products / Categories (category.blade.php)
// ---------------------
Route::get('/proizvodi', [ProizvodController::class, 'list'])->name('proizvodi.index');
Route::get('/kategorija/{id}', [ProizvodController::class, 'kategorija'])->name('proizvodi.kategorija');

// AJAX search (used by category.blade.php JS)
Route::get('/ajax/proizvodi', [ProizvodController::class, 'ajaxSearch'])->name('proizvodi.search');

// ---------------------
// Cart
// ---------------------
Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
Route::post('/cart/add/{id}', [CartController::class, 'add'])->name('cart.add');
Route::delete('/cart/remove/{id}', [CartController::class, 'remove'])->name('cart.remove');


// ---------------------
// Authenticated user pages (Breeze)
// ---------------------
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// ---------------------
// Dashboard (for logged-in users only)
// ---------------------
Route::get('/dashboard', function () { return view('dashboard'); // this points to resources/views/dashboard.blade.php
})->middleware(['auth', 'verified'])->name('dashboard');

// ---------------------
// Single product page
// ---------------------
Route::get('/proizvod/{id}', [\App\Http\Controllers\ProizvodController::class, 'show'])
    ->name('proizvod.show');

// ---------------------
// Profile routes
// ---------------------
    Route::middleware('auth')->group(function () {
    Route::get('/profile', [App\Http\Controllers\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [App\Http\Controllers\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');

    // 🏠 User addresses routes
    Route::post('/profile/address', [App\Http\Controllers\ProfileController::class, 'addAddress'])->name('profile.address.add');
    Route::delete('/profile/address/{id}', [App\Http\Controllers\ProfileController::class, 'deleteAddress'])->name('profile.address.delete');
});

Route::post('/profile/address/{id}/default', [ProfileController::class, 'setDefaultAddress'])
    ->name('profile.address.default');







// ---------------------
// Auth routes (Breeze)
// ---------------------
require __DIR__.'/auth.php';
