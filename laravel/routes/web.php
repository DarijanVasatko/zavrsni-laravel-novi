<?php


use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProizvodController;
use App\Http\Controllers\CartController;

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// 🛒 Products
Route::get('/', [ProizvodController::class, 'index'])->name('proizvodi.index');
Route::get('/kategorija/{id}', [ProizvodController::class, 'kategorija'])->name('proizvodi.kategorija');

// 🧭 Category page (category.blade.php)
Route::get('/categories', function () {
    return view('category');
})->name('categories');

// 🛍️ Cart
Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
Route::post('/cart/add/{id}', [CartController::class, 'add'])->name('cart.add');


