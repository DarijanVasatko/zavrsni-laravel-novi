@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row">

            {{-- Sidebar kategorije --}}
            <div class="col-md-3">
                <h4>Kategorije</h4>
                <ul class="list-group mb-4">
                    <li class="list-group-item {{ $categoryId ? '' : 'active' }}">
                        <a href="{{ route('proizvodi.index', request()->only(['search','sort'])) }}" 
                           class="text-decoration-none d-block">
                            Sve kategorije
                        </a>
                    </li>
                    @foreach($kategorije as $kat)
                        <li class="list-group-item {{ $categoryId == $kat->id_kategorija ? 'active' : '' }}">
                            <a href="{{ route('proizvodi.kategorija', array_merge(['id' => $kat->id_kategorija], request()->only(['search','sort']))) }}"
                               class="text-decoration-none d-block">
                                {{ $kat->ImeKategorija }}
                            </a>
                        </li>
                    @endforeach
                </ul>
            </div>

            {{-- Main content --}}
            <div class="col-md-9">
                <h4>Proizvodi</h4>

                <!-- 🔍 Search & Sort -->
                <form method="GET"
                      action="{{ $categoryId ? route('proizvodi.kategorija', $categoryId) : route('proizvodi.index') }}"
                      class="row mb-4">
                    <div class="col-md-6">
                        <input type="text" name="search" value="{{ request('search') }}" class="form-control"
                               placeholder="Pretraži proizvode...">
                    </div>
                    <div class="col-md-4">
                        <select name="sort" class="form-select" onchange="this.form.submit()">
                            <option value="">Sortiraj</option>
                            <option value="name_asc" {{ request('sort') == 'name_asc' ? 'selected' : '' }}>Naziv (A-Z)</option>
                            <option value="name_desc" {{ request('sort') == 'name_desc' ? 'selected' : '' }}>Naziv (Z-A)</option>
                            <option value="price_asc" {{ request('sort') == 'price_asc' ? 'selected' : '' }}>Cijena (najniža)</option>
                            <option value="price_desc" {{ request('sort') == 'price_desc' ? 'selected' : '' }}>Cijena (najviša)</option>
                            <option value="newest" {{ request('sort') == 'newest' ? 'selected' : '' }}>Najnoviji</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Traži</button>
                    </div>
                </form>

               
<div class="row">
    @forelse($proizvodi as $proizvod)
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm border-0">
                <img src="{{ asset($proizvod->Slika) }}" class="card-img-top"
                     alt="{{ $proizvod->Naziv }}" style="height:200px; object-fit:cover;">
                <div class="card-body">
                    <h5 class="card-title">{{ $proizvod->Naziv }}</h5>
                    <p class="text-muted mb-1">{{ $proizvod->kategorija->ImeKategorija ?? '' }}</p>
                    <p class="fw-bold text-primary">{{ number_format($proizvod->Cijena, 2) }} €</p>
                </div>
                <div class="card-footer text-center bg-white border-0">
                    <a href="#" class="btn btn-primary btn-sm">Dodaj u košaricu</a>
                </div>
            </div>
        </div>
    @empty
        <p>Nema proizvoda u ovoj kategoriji.</p>
    @endforelse
</div>


<div class="d-flex justify-content-center mt-4">
    {{ $proizvodi->links() }}
</div>

            </div>

        </div>
    </div>
@endsection
