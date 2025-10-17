<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProizvodController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ProfileController;

// ---------------------
// 🏠 Homepage (index.blade.php)
// ---------------------
Route::get('/', [ProizvodController::class, 'home'])->name('index.index');

// ---------------------
// 🧩 Products / Categories (category.blade.php)
// ---------------------
Route::get('/proizvodi', [ProizvodController::class, 'list'])->name('proizvodi.index');
Route::get('/kategorija/{id}', [ProizvodController::class, 'kategorija'])->name('proizvodi.kategorija');

// 🔍 AJAX search (used by category.blade.php JS)
Route::get('/ajax/proizvodi', [ProizvodController::class, 'ajaxSearch'])->name('proizvodi.search');

// ---------------------
// 🛒 Cart
// ---------------------
Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
Route::post('/cart/add/{id}', [CartController::class, 'add'])->name('cart.add');

// ---------------------
// 👤 Authenticated user pages (Breeze)
// ---------------------
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// ---------------------
// 🌐 Auth routes (Breeze)
// ---------------------
require __DIR__.'/auth.php';
