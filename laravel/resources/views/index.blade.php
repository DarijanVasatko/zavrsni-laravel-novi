@extends('layouts.app')

@section('title', 'TechShop - Najbolja tehnologija u Hrvatskoj')

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
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <div class="mb-3" style="font-size: 2.5rem;">
                                <i class="fas fa-microchip"></i>
                            </div>
                            <h5 class="card-title">Laptop</h5>
                            <a href="{{ url('/kategorija/1') }}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <div class="mb-3" style="font-size: 2.5rem;">
                                <i class="fas fa-microchip"></i>
                            </div>
                            <h5 class="card-title">Računalo</h5>
                            <a href="{{ url('/kategorija/2') }}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <div class="mb-3" style="font-size: 2.5rem;">
                                <i class="fas fa-microchip"></i>
                            </div>
                            <h5 class="card-title">Komponente</h5>
                            <a href="{{ url('/kategorija/3') }}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <div class="mb-3" style="font-size: 2.5rem;">
                                <i class="fas fa-microchip"></i>
                            </div>
                            <h5 class="card-title">Pohrana</h5>
                            <a href="{{ url('/kategorija/4') }}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

{{-- Featured Products --}}
<section id="featured-products" class="py-5">
    <div class="container">
        <h2 class="text-center mb-5">Izdvojeni proizvodi</h2>

        <!-- Infinite scrollable container -->
        <div id="product-row" class="d-flex gap-4 overflow-hidden pb-3" 
             style="scroll-behavior: smooth; white-space: nowrap;">
            @foreach ($proizvodi as $product)
                <div class="card product-card flex-shrink-0" style="width: 250px;">
                    <div class="product-img-container" style="height: 200px; overflow: hidden;">
                        <img src="{{ $product->Slika }}" 
                             class="product-img w-100 h-100 object-fit-cover"
                             alt="{{ $product->Naziv }}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">{{ $product->Naziv }}</h5>
                        <p class="card-text text-muted">{{ $product->Opis }}</p>
                        <h5 class="text-primary mb-0">{{ number_format($product->Cijena, 2) }} €</h5>
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
            @endforeach
        </div>
    </div>
</section>

    <!-- View all button -->
        <div class="text-center mt-4">
    <a href="{{ route('categories') }}" class="btn btn-outline-primary btn-lg">
        Pogledaj sve proizvode i kategorije
    </a>
</div>


{{-- Auto-scroll script with hover pause --}}
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const container = document.getElementById("product-row");

        // Duplicate content for seamless infinite loop
        container.innerHTML += container.innerHTML;

        let step = 1/2; // lower = slower scroll (pixels per frame)
        let isPaused = false;

        function autoScroll() {
            if (!isPaused) {
                container.scrollLeft += step;

                // Reset halfway (since content is cloned)
                if (container.scrollLeft >= container.scrollWidth / 2) {
                    container.scrollLeft = 0;
                }
            }
            requestAnimationFrame(autoScroll);
        }

        // Pause on hover
        container.addEventListener("mouseenter", () => { isPaused = true; });
        container.addEventListener("mouseleave", () => { isPaused = false; });

        autoScroll();
    });
</script>


@endsection
