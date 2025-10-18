@extends('layouts.app')

@section('title', 'TechShop - ' . $proizvod->Naziv)

@section('content')
<div class="container py-4">
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="rounded-4 overflow-hidden shadow-sm" style="height: 420px;">
                <img src="{{ asset($proizvod->Slika) }}" alt="{{ $proizvod->Naziv }}"
                     class="w-100 h-100 object-fit-cover"
                     style="transition: transform .3s ease;"
                     onmouseover="this.style.transform='scale(1.05)'"
                     onmouseout="this.style.transform='scale(1)'">
            </div>
        </div>

        <div class="col-lg-6">
            <h2 class="fw-bold mb-2">{{ $proizvod->Naziv }}</h2>
            <p class="text-muted mb-3">{{ $proizvod->Opis_kratki ?? '' }}</p>

            <h3 class="text-primary fw-bold">{{ number_format($proizvod->Cijena, 2) }} €</h3>
            <p class="text-muted">(PDV uključen)</p>

            @if($proizvod->StanjeNaSkladistu > 0)
    <p class="text-success fw-semibold mb-1">
        <i class="bi bi-check-circle me-1"></i> Na zalihi: {{ $proizvod->StanjeNaSkladistu }} kom
    </p>
@else
    <p class="text-danger fw-semibold mb-1">
        <i class="bi bi-x-circle me-1"></i> Nema na zalihi
    </p>
@endif


            <form action="{{ route('cart.add', ['id' => $proizvod->Proizvod_ID]) }}" method="POST"
                  class="mt-4 d-flex align-items-center gap-3 flex-wrap js-add-to-cart"
                  data-product-name="{{ $proizvod->Naziv }}">
                @csrf
                <div class="input-group" style="width: 140px;">
                    <button type="button" class="btn btn-outline-secondary" onclick="this.nextElementSibling.stepDown()">−</button>
                    <input type="number" name="quantity" value="1" min="1" max="{{ $proizvod->StanjeNaSkladistu ?? 1 }}" class="form-control text-center">
                    <button type="button" class="btn btn-outline-secondary" onclick="this.previousElementSibling.stepUp()">+</button>
                </div>

                <button type="submit" class="btn btn-primary rounded-pill px-4 fw-semibold js-add-to-cart-btn">
                    <i class="bi bi-cart-plus me-2"></i> Dodaj u košaricu
                </button>
            </form>

            <hr class="my-4">

            <h5 class="fw-semibold">Detaljni opis</h5>
            <p class="text-muted">{{ $proizvod->Opis ?? '—' }}</p>
        </div>
    </div>
</div>
@endsection
