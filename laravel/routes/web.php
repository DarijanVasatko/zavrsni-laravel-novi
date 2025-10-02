<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');


use App\Http\Controllers\ProizvodController;

Route::get('/', [ProizvodController::class, 'index'])->name('proizvodi.index');
Route::get('/kategorija/{id}', [ProizvodController::class, 'kategorija'])->name('proizvodi.kategorija');
