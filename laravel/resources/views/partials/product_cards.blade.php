@foreach($proizvodi as $proizvod)
    <div class="col-md-4 col-sm-6 mb-4">
        <div class="card border-0 shadow-sm h-100" 
             style="transition: all 0.2s ease; overflow: visible;">
            
            {{-- 🖼️ CLICKABLE IMAGE AREA --}}
            <div style="
                position: relative;
                height: 220px;
                overflow: hidden;
                border-top-left-radius: 1rem;
                border-top-right-radius: 1rem;
            ">
                <img 
                    src='{{ asset($proizvod->Slika) }}' 
                    alt='{{ $proizvod->Naziv }}'
                    class='w-100 h-100 object-fit-cover'
                    style='
                        transition: transform 0.25s ease;
                        display: block;
                    '
                    onmouseover="this.style.transform='scale(1.05)'"
                    onmouseout="this.style.transform='scale(1)'"
                >

                {{-- 🔗 FULL CLICKABLE OVERLAY --}}
                <a 
                    href="{{ route('proizvod.show', $proizvod->Proizvod_ID) }}"
                    style="
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: 10;
                        cursor: pointer;
                        background: transparent;
                        display: block;
                    "
                    aria-label="{{ $proizvod->Naziv }}">
                </a>
            </div>

            {{-- 🧾 Product info --}}
            <div class="card-body text-center">
                <h6 class="fw-bold mb-1">{{ $proizvod->Naziv }}</h6>
                <p class="text-muted small mb-2">{{ $proizvod->kategorija->ImeKategorija ?? '' }}</p>
                <h5 class="text-primary fw-bold">{{ number_format($proizvod->Cijena, 2) }} €</h5>
            </div>

            {{-- 🛒 Add to cart --}}
            <div class="card-footer text-center bg-white border-0 pb-3">
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
