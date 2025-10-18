@extends('layouts.app')

@section('title', $proizvod->Naziv . ' - TechShop')

@section('content')
<div class="container py-5">

    <!-- 🔙 Back Button -->
    <a href="{{ route('proizvodi.index') }}" class="btn btn-outline-primary mb-4 rounded-pill px-4">
        <i class="bi bi-arrow-left me-2"></i> Natrag
    </a>

    <div class="row g-5 align-items-start">

        <!-- 🖼 Product Image -->
        <div class="col-lg-6 text-center">
            <div class="product-image-wrapper"
                 style="overflow: hidden; border-radius: 1rem; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
                <img src="{{ asset($proizvod->Slika) }}"
                     alt="{{ $proizvod->Naziv }}"
                     class="img-fluid product-image"
                     style="width:100%; height:auto; transition: transform 0.4s ease;">
            </div>
        </div>

        <!-- 📝 Product Info -->
        <div class="col-lg-6">
            <h2 class="fw-bold text-primary mb-3">{{ $proizvod->Naziv }}</h2>
            

            <!-- 💰 Price -->
            <h3 class="text-primary fw-bold mb-3">{{ number_format($proizvod->Cijena, 2) }} €</h3>

            <!-- 🧮 Stock Info -->
            <p class="mb-4">
                @if($proizvod->StanjeNaSkladistu > 0)
                    <span class="badge bg-success px-3 py-2">Na zalisi: {{ $proizvod->StanjeNaSkladistu }}</span>
                @else
                    <span class="badge bg-danger px-3 py-2">Nema na zalihi</span>
                @endif
            </p>

            <!-- 📖 Short Description -->
            <p class="text-secondary mb-4">
                {{ $proizvod->KratkiOpis ?? 'Nema dostupnog kratkog opisa za ovaj proizvod.' }}
            </p>

            <!-- 🛒 Add to Cart Form -->
            <form action="{{ route('cart.add', ['id' => $proizvod->Proizvod_ID]) }}" method="POST" class="d-flex align-items-center gap-3 flex-wrap">
                @csrf

                <!-- Quantity Selector -->
                <div class="input-group quantity-selector" style="width: 140px;">
                    <button type="button" class="btn btn-outline-secondary" onclick="decrementQty()">−</button>
                    <input type="number" name="quantity" id="quantity" value="1" min="1"
                           max="{{ $proizvod->Kolicina ?? 10 }}" class="form-control text-center" style="width:60px;">
                    <button type="button" class="btn btn-outline-secondary" onclick="incrementQty()">+</button>
                </div>

                <!-- Add to Cart Button -->
                <button type="submit" class="btn btn-primary btn-lg rounded-pill px-4 fw-semibold">
                    <i class="bi bi-cart-plus me-2"></i> Dodaj u košaricu
                </button>
            </form>
        </div>
    </div>

    <!-- 📄 Full Description -->
    <div class="mt-5">
        <h4 class="fw-bold text-primary mb-3">Opis proizvoda</h4>
        <p class="text-muted" style="line-height: 1.7;">
            {{ $proizvod->Opis ?? 'Detaljan opis za ovaj proizvod trenutno nije dostupan.' }}
        </p>
    </div>

    <!-- 🛒 Related Products -->
    @if($slicni->isNotEmpty())
        <div class="mt-5">
            <h4 class="fw-bold text-primary mb-4">Slični proizvodi</h4>
            <div class="row g-4">
                @foreach($relatedProducts as $related)
                    <div class="col-md-3 col-sm-6">
                        <div class="card border-0 shadow-sm h-100 product-card"
                             style="border-radius: 1rem; transition: all 0.25s ease;">
                            <a href="{{ route('proizvod.show', $related->Proizvod_ID) }}" class="text-decoration-none text-dark">
                                <div class="position-relative"
                                     style="height: 180px; overflow:hidden; border-top-left-radius:1rem; border-top-right-radius:1rem;">
                                    <img src="{{ asset($related->Slika) }}" alt="{{ $related->Naziv }}"
                                         class="w-100 h-100 object-fit-cover product-img"
                                         style="transition: transform 0.3s ease;">
                                </div>
                                <div class="card-body text-center">
                                    <h6 class="fw-bold mb-1">{{ $related->Naziv }}</h6>
                                    <p class="text-muted small mb-2">{{ $related->kategorija->ImeKategorija ?? '' }}</p>
                                    <h6 class="text-primary fw-semibold">{{ number_format($related->Cijena, 2) }} €</h6>
                                </div>
                            </a>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    @endif

</div>

<!-- 💅 CSS -->
<style>
    .product-image-wrapper:hover .product-image {
        transform: scale(1.07);
    }

    .quantity-selector .btn {
        font-size: 1.2rem;
        font-weight: bold;
    }

    .quantity-selector input::-webkit-inner-spin-button,
    .quantity-selector input::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    .product-card:hover .product-img {
        transform: scale(1.08);
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
    }
</style>

<!-- ⚙️ JS for Quantity Selector -->
<script>
    function incrementQty() {
        const input = document.getElementById('quantity');
        let val = parseInt(input.value);
        if (val < parseInt(input.max)) input.value = val + 1;
    }

    function decrementQty() {
        const input = document.getElementById('quantity');
        let val = parseInt(input.value);
        if (val > 1) input.value = val - 1;
    }
</script>
@endsection
