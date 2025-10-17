@foreach($proizvodi as $proizvod)
    <div class="col-md-4 col-sm-6 mb-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 product-card">
            <div class="position-relative" style="height: 220px; overflow: hidden; border-top-left-radius: 1rem; border-top-right-radius: 1rem;">
                <img src="{{ asset($proizvod->Slika) }}" 
                     alt="{{ $proizvod->Naziv }}" 
                     class="w-100 h-100 object-fit-cover product-img">
            </div>
            <div class="card-body text-center">
                <h6 class="fw-bold mb-1">{{ $proizvod->Naziv }}</h6>
                <p class="text-muted small mb-2">{{ $proizvod->kategorija->ImeKategorija ?? '' }}</p>
                <h5 class="text-primary fw-bold mb-3">{{ number_format($proizvod->Cijena, 2) }} €</h5>
                <form action="{{ route('cart.add', ['id' => $proizvod->Proizvod_ID]) }}" method="POST">
                    @csrf
                    <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">
                        <i class="bi bi-cart-plus me-1"></i> Dodaj u košaricu
                    </button>
                </form>
            </div>
        </div>
    </div>
@endforeach

@if($proizvodi->isEmpty())
    <p class="text-center text-muted">Nema pronađenih proizvoda.</p>
@endif
