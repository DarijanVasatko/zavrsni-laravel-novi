@extends('layouts.app')

@section('title', $categoryId ? 'TechShop - ' . ($kategorije->find($categoryId)->ImeKategorija ?? '') : 'TechShop - Svi proizvodi')

@section('content')
<div class="container py-5">

    <!-- Heading -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="fw-bold mb-0 text-primary">
            {{ $categoryId ? 'Proizvodi iz kategorije: ' . ($kategorije->find($categoryId)->ImeKategorija ?? '') : 'Svi proizvodi' }}
        </h2>
        <a href="{{ url('/') }}" class="btn btn-outline-primary rounded-pill">
            <i class="bi bi-arrow-left me-1"></i> Natrag na početnu
        </a>
    </div>

    <div class="row">
        <!-- Sidebar kategorije -->
        <div class="col-lg-3 mb-4">
            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-body">
                    <h5 class="fw-semibold mb-3 text-center text-primary">Kategorije</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 {{ $categoryId ? '' : 'bg-primary text-white fw-bold rounded' }}">
                            <a href="{{ route('proizvodi.index', request()->only(['search','sort'])) }}" 
                               class="text-decoration-none {{ $categoryId ? 'text-dark' : 'text-white' }} d-block">
                                Sve kategorije
                            </a>
                        </li>
                        @foreach($kategorije as $kat)
                            <li class="list-group-item border-0 {{ $categoryId == $kat->id_kategorija ? 'bg-primary text-white fw-bold rounded' : '' }}">
                                <a href="{{ route('proizvodi.kategorija', array_merge(['id' => $kat->id_kategorija], request()->only(['search','sort']))) }}"
                                   class="text-decoration-none {{ $categoryId == $kat->id_kategorija ? 'text-white' : 'text-dark' }} d-block">
                                    {{ $kat->ImeKategorija }}
                                </a>
                            </li>
                        @endforeach
                    </ul>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-lg-9">
            
            <!-- Search & Sort -->
            <form id="search-form" method="GET" class="row g-2 mb-4 align-items-center">
                <input type="hidden" name="categoryId" value="{{ $categoryId }}">
                <div class="col-md-6">
                    <input type="text" id="search-input" name="search" value="{{ request('search') }}" 
                           class="form-control rounded-pill shadow-sm px-4" placeholder="🔍 Pretraži proizvode...">
                </div>
                <div class="col-md-4">
                    <select name="sort" id="sort-select" class="form-select rounded-pill shadow-sm">
                        <option value="">Sortiraj</option>
                        <option value="name_asc" {{ request('sort') == 'name_asc' ? 'selected' : '' }}>Naziv (A-Z)</option>
                        <option value="name_desc" {{ request('sort') == 'name_desc' ? 'selected' : '' }}>Naziv (Z-A)</option>
                        <option value="price_asc" {{ request('sort') == 'price_asc' ? 'selected' : '' }}>Cijena (najniža)</option>
                        <option value="price_desc" {{ request('sort') == 'price_desc' ? 'selected' : '' }}>Cijena (najviša)</option>
                        <option value="newest" {{ request('sort') == 'newest' ? 'selected' : '' }}>Najnoviji</option>
                    </select>
                </div>
            </form>

            <!-- Products Grid -->
            <div id="product-grid" class="row g-4">
                @include('partials.product_cards', ['proizvodi' => $proizvodi])
            </div>

            <!-- Pagination -->
            <div class="d-flex justify-content-center mt-5">
                {{ $proizvodi->links() }}
            </div>

        </div>
    </div>
</div>

<!-- Dynamic AJAX Search Script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const sortSelect = document.getElementById('sort-select');
    const productGrid = document.getElementById('product-grid');
    const categoryId = document.querySelector('input[name="categoryId"]').value;
    let timer;

    function fetchProducts() {
        const search = searchInput.value;
        const sort = sortSelect.value;

        fetch(`/search-proizvodi?search=${encodeURIComponent(search)}&sort=${encodeURIComponent(sort)}&categoryId=${categoryId}`)
            .then(res => res.json())
            .then(data => {
                productGrid.innerHTML = data.html;
            })
            .catch(err => console.error(err));
    }

    // Live search (with debounce)
    searchInput.addEventListener('input', () => {
        clearTimeout(timer);
        timer = setTimeout(fetchProducts, 300);
    });

    // Sort trigger
    sortSelect.addEventListener('change', fetchProducts);
});
</script>

<style>
    /* Smooth card hover animation */
    .product-card {
        transition: all 0.25s ease-in-out;
    }
    .product-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }

    .product-img {
        transition: transform 0.3s ease;
    }
    .product-card:hover .product-img {
        transform: scale(1.05);
    }

    .form-control:focus, .form-select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.25rem rgba(13,110,253,0.25);
    }
</style>
@endsection
