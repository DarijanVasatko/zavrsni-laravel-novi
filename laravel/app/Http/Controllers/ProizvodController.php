<?php

namespace App\Http\Controllers;

use App\Models\Proizvod;
use App\Models\Kategorija;
use Illuminate\Http\Request;
use Illuminate\Pagination\Paginator;

class ProizvodController extends Controller
{
    public function __construct()
    {
        // Ensure Bootstrap styling for pagination
        Paginator::useBootstrapFive();
    }

    /**
     * Display all products (with search + sorting + pagination)
     */
    public function index(Request $request)
    {
        $kategorije = Kategorija::all();
        $query = Proizvod::with('kategorija');

        // 🔍 Search filter
        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where('Naziv', 'like', "%{$search}%");
        }

        // ↕️ Sorting
        if ($request->filled('sort')) {
            switch ($request->input('sort')) {
                case 'name_asc':
                    $query->orderBy('Naziv', 'asc');
                    break;
                case 'name_desc':
                    $query->orderBy('Naziv', 'desc');
                    break;
                case 'price_asc':
                    $query->orderBy('Cijena', 'asc');
                    break;
                case 'price_desc':
                    $query->orderBy('Cijena', 'desc');
                    break;
                case 'newest':
                    $query->latest(); // assumes created_at column
                    break;
            }
        }

        $proizvodi = $query->paginate(9)->withQueryString(); // 9 per page

        return view('index', [
            'proizvodi'   => $proizvodi,
            'kategorije' => $kategorije,
            'categoryId' => null, // no category selected
        ]);
    }

    /**
     * Display products filtered by category (with search + sorting + pagination)
     */
    public function kategorija(Request $request, $id)
    {
        $kategorije = Kategorija::all();
        $query = Proizvod::with('kategorija')->where('id_kategorija', $id);

        // 🔍 Search filter
        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where('Naziv', 'like', "%{$search}%");
        }

        // ↕️ Sorting
        if ($request->filled('sort')) {
            switch ($request->input('sort')) {
                case 'name_asc':
                    $query->orderBy('Naziv', 'asc');
                    break;
                case 'name_desc':
                    $query->orderBy('Naziv', 'desc');
                    break;
                case 'price_asc':
                    $query->orderBy('Cijena', 'asc');
                    break;
                case 'price_desc':
                    $query->orderBy('Cijena', 'desc');
                    break;
                case 'newest':
                    $query->latest(); // assumes created_at column
                    break;
            }
        }

        $proizvodi = $query->paginate(9)->withQueryString(); // 9 per page

        return view('index', [
            'proizvodi'   => $proizvodi,
            'kategorije' => $kategorije,
            'categoryId' => $id, // highlight current category
        ]);
    }

    /**
     * Show the form for creating a new product.
     */
    public function create() {}

    /**
     * Store a newly created product in storage.
     */
    public function store(Request $request) {}

    /**
     * Display the specified product.
     */
    public function show(Proizvod $proizvod) {}

    /**
     * Show the form for editing the specified product.
     */
    public function edit(Proizvod $proizvod) {}

    /**
     * Update the specified product in storage.
     */
    public function update(Request $request, Proizvod $proizvod) {}

    /**
     * Remove the specified product from storage.
     */
    public function destroy(Proizvod $proizvod) {}
}
