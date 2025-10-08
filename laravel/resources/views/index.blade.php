@extends('layouts.app')

@section('title', 'TechShop - Najbolja tehnologija u Hrvatskoj')

@section('styles')
    /* Put custom page-specific CSS here */
@endsection

@section('content')
    <!-- Hero Section -->
    <section class="hero-section bg-dark text-white py-5">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Dobrodošli u TechShop</h1>
                    <p class="lead mb-4">
                        Najbolje tehnološke proizvode po najpovoljnijim cijenama.
                        Istražite naš asortiman i pronađite savršene gadgete za svoje potrebe.
                    </p>
                </div>
                <div class="col-lg-6 d-none d-lg-block">
                    <img src="https://images.unsplash.com/photo-1518770660439-4636190af475" alt="Tech products"
                        class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    {{-- Popularne kategorije --}}
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Popularne kategorije</h2>
            <div class="row g-4">
                {{-- Example category card --}}
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <div class="mb-3" style="font-size: 2.5rem;">
                                <i class="fas fa-microchip"></i>
                            </div>
                            <h5 class="card-title">Laptop</h5>
                            <a href="{{ url('/category/1') }}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
                {{-- Repeat for other categories --}}
            </div>
        </div>
    </section>

    {{-- Featured Products --}}
    <section id="featured-products" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Izdvojeni proizvodi</h2>
            <div class="row g-4">
                {{-- Loop products dynamically --}}
                @foreach ($proizvodi as $product)
                    <div class="col-lg-3 col-md-6">
                        <div class="card h-100 product-card">
                            <div class="product-img-container" style="height: 200px; overflow: hidden;">
                                <img src="{{ $product->image }}" class="product-img w-100 h-100 object-fit-cover"
                                    alt="{{ $product->title }}">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">{{ $product->title }}</h5>
                                <p class="card-text text-muted">{{ $product->description }}</p>
                                <h5 class="text-primary mb-0">{{ $product->price }} €</h5>
                            </div>
                           <div class="card-footer text-center bg-white border-0">
    <form action="{{ route('cart.add', ['id' => $product->Proizvod_ID]) }}" method="POST">
        @csrf
        <button type="submit" class="btn btn-primary btn-sm">
            Dodaj u košaricu
        </button>
    </form>
</div>


                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </section>
@endsection