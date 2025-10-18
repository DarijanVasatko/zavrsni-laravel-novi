@extends('layouts.app')

@section('title', 'TechShop - Najbolja tehnologija u Hrvatskoj')

@section('content')
<section class="hero-section bg-dark text-white py-5">
    <div class="container py-5 text-center">
        <h1 class="display-4 fw-bold mb-4">Dobrodošli u TechShop</h1>
        <p class="lead mb-4">Najbolja tehnologija po najpovoljnijim cijenama.</p>
        <a href="{{ route('proizvodi.index') }}" class="btn btn-primary btn-lg rounded-pill">
            <i class="bi bi-shop me-2"></i> Pregledaj proizvode
        </a>
    </div>
</section>

<section id="featured-products" class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center mb-5">Izdvojeni proizvodi</h2>
        <div class="d-flex gap-4 overflow-hidden pb-3" id="product-row" style="scroll-behavior: smooth; white-space: nowrap;">
            @foreach ($proizvodi as $product)
                <div class="card product-card flex-shrink-0 shadow-sm" style="width: 250px;">
                    <div class="product-img-container" style="height: 200px; overflow: hidden;">
                        <img src="{{ asset($product->Slika) }}" class="w-100 h-100 object-fit-cover"
                             alt="{{ $product->Naziv }}"
                             style="transition: transform .3s ease;"
                             onmouseover="this.style.transform='scale(1.05)'"
                             onmouseout="this.style.transform='scale(1)'">
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">{{ $product->Naziv }}</h5>
                        <p class="card-text text-muted">{{ $product->Opis_kratki ?? '' }}</p>
                        <h5 class="text-primary mb-0">{{ number_format($product->Cijena, 2) }} €</h5>
                    </div>
                    <div class="card-footer text-center bg-white border-0">
                        <form action="{{ route('cart.add', ['id' => $product->Proizvod_ID]) }}" method="POST"
                              class="js-add-to-cart d-inline-block"
                              data-product-name="{{ $product->Naziv }}">
                            @csrf
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn btn-primary btn-sm rounded-pill js-add-to-cart-btn">
                                Dodaj u košaricu
                            </button>
                        </form>
                    </div>
                </div>
            @endforeach
        </div>
    </div>
</section>
@endsection
