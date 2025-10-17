<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProizvodController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CategoryController;

// ---------------------
// 🏠 Homepage
// ---------------------
Route::get('/', [ProizvodController::class, 'index'])->name('proizvodi.index');
Route::get('/dashboard', function () {
    return redirect()->route('proizvodi.index');
})->name('dashboard');

// ---------------------
// 🧩 Category pages
// ---------------------
Route::get('/proizvodi', [ProizvodController::class, 'index'])->name('proizvodi.index');
Route::get('/kategorija/{id}', [ProizvodController::class, 'kategorija'])->name('proizvodi.kategorija');

// ---------------------
// 🛒 Cart
// ---------------------
Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
Route::post('/cart/add/{id}', [CartController::class, 'add'])->name('cart.add');

// ---------------------
// 👤 Authenticated user pages (from Breeze)
// ---------------------
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// ---------------------
// 📦 Sve kategorije i proizvodi
// ---------------------
Route::get('/categories', function () {
    return view('category');
})->name('categories');

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');



// ---------------------
// 🌐 Auth routes (Breeze)
// ---------------------
require __DIR__.'/auth.php';
