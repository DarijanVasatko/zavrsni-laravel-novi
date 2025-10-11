<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Proizvod;
use App\Models\Kategorija;

class ProizvodController extends Controller
{
    public function index(Request $request)
    {
        $query = Proizvod::query();

        // search filter
        if ($request->has('search')) {
            $query->where('Naziv', 'like', '%' . $request->search . '%');
        }

        // sorting
        if ($request->sort == 'price_asc') {
            $query->orderBy('Cijena', 'asc');
        } elseif ($request->sort == 'price_desc') {
            $query->orderBy('Cijena', 'desc');
        } elseif ($request->sort == 'name_asc') {
            $query->orderBy('Naziv', 'asc');
        } elseif ($request->sort == 'name_desc') {
            $query->orderBy('Naziv', 'desc');
        } elseif ($request->sort == 'newest') {
            $query->orderBy('created_at', 'desc');
        }

        $proizvodi = $query->paginate(9);
        $kategorije = Kategorija::all();

        // If user visits /categories, show category.blade.php
        if ($request->is('categories')) {
            return view('category', [
                'proizvodi' => $proizvodi,
                'kategorije' => $kategorije,
                'categoryId' => null
            ]);
        }

        // Otherwise, show homepage
        return view('index', [
            'proizvodi' => $proizvodi,
            'kategorije' => $kategorije
        ]);
    }
}
