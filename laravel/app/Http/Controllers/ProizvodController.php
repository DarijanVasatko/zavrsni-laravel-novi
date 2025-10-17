<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Proizvod;
use App\Models\Kategorija;

class ProizvodController extends Controller
{
    /**
     * Show all products.
     */
    public function index(Request $request)
    {
        $query = Proizvod::query();

        // 🔍 Search
        if ($request->filled('search')) {
            $query->where('Naziv', 'like', '%' . $request->search . '%');
        }

        // ↕️ Sorting
        switch ($request->sort) {
            case 'price_asc':
                $query->orderBy('Cijena', 'asc');
                break;
            case 'price_desc':
                $query->orderBy('Cijena', 'desc');
                break;
            case 'name_asc':
                $query->orderBy('Naziv', 'asc');
                break;
            case 'name_desc':
                $query->orderBy('Naziv', 'desc');
                break;
            case 'newest':
                $query->orderBy('created_at', 'desc');
                break;
        }

        $proizvodi = $query->paginate(9);
        $kategorije = Kategorija::all();

        // Always show the category page layout for this
        return view('category', [
            'proizvodi' => $proizvodi,
            'kategorije' => $kategorije,
            'categoryId' => null,
        ]);
    }

    /**
     * Show products for a specific category.
     */
    public function kategorija($id, Request $request)
    {
        $query = Proizvod::where('id_kategorija', $id);

        // 🔍 Search
        if ($request->filled('search')) {
            $query->where('Naziv', 'like', '%' . $request->search . '%');
        }

        // ↕️ Sorting
        switch ($request->sort) {
            case 'price_asc':
                $query->orderBy('Cijena', 'asc');
                break;
            case 'price_desc':
                $query->orderBy('Cijena', 'desc');
                break;
            case 'name_asc':
                $query->orderBy('Naziv', 'asc');
                break;
            case 'name_desc':
                $query->orderBy('Naziv', 'desc');
                break;
            case 'newest':
                $query->orderBy('created_at', 'desc');
                break;
        }

        $proizvodi = $query->paginate(9);
        $kategorije = Kategorija::all();

        return view('category', [
            'proizvodi' => $proizvodi,
            'kategorije' => $kategorije,
            'categoryId' => $id,
        ]);
    }

    public function ajaxSearch(Request $request)
{
    $query = Proizvod::query();

    if ($request->filled('categoryId')) {
        $query->where('id_kategorija', $request->categoryId);
    }

    if ($request->filled('search')) {
        $query->where('Naziv', 'like', '%' . $request->search . '%');
    }

    $proizvodi = $query->limit(12)->get();

    return response()->json([
        'html' => view('partials.product_cards', ['proizvodi' => $proizvodi])->render()
    ]);
}

}
