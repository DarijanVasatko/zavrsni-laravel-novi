<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\Kategorija; // ✅ Correct namespace for your model
use Illuminate\Support\Facades\View;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // ✅ Share categories & categoryId globally
        View::composer('*', function ($view) {
            $view->with('kategorije', Kategorija::all());
            $view->with('categoryId', null);
        });
    }
}
