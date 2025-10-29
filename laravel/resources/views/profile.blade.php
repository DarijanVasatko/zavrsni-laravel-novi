@extends('layouts.app')

@section('title', 'Korisnički profil — TechShop')

@section('content')
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="row g-4">

                    <!-- Sidebar Menu -->
                    <div class="col-md-4 col-lg-3">
                        <div class="list-group shadow-sm rounded-4 overflow-hidden sticky-top" style="top: 90px;"
                            id="profile-menu">
                            <div class="list-group-item bg-primary text-white fw-bold text-center py-3">
                                <i class="bi bi-person-circle me-2"></i> Moj profil
                            </div>
                            <a href="#" class="list-group-item list-group-item-action active fw-semibold"
                                data-section="profile">
                                <i class="bi bi-person me-2 text-primary"></i> Osobni podaci
                            </a>
                            <a href="#" class="list-group-item list-group-item-action" data-section="addresses">
                                <i class="bi bi-geo-alt me-2 text-primary"></i> Adrese dostave
                            </a>
                            <a href="#" class="list-group-item list-group-item-action" data-section="orders">
                                <i class="bi bi-box-seam me-2 text-primary"></i> Narudžbe
                            </a>
                            <a href="#" class="list-group-item list-group-item-action" data-section="promos">
                                <i class="bi bi-ticket-perforated me-2 text-primary"></i> Promo kodovi
                            </a>
                            <a href="#" class="list-group-item list-group-item-action" data-section="password">
                                <i class="bi bi-key me-2 text-primary"></i> Lozinka
                            </a>
                            <a href="#" class="list-group-item list-group-item-action" data-section="2fa">
                                <i class="bi bi-shield-lock me-2 text-primary"></i> 2FA zaštita
                            </a>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-8 col-lg-9">
                        <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                            <div class="card-header bg-primary text-white fw-bold py-3 fs-5">
                                <i class="bi bi-person-gear me-2"></i> <span id="section-title">Osobni podaci</span>
                            </div>

                            <div class="card-body p-4 bg-light">
                                <!-- Section: Profile -->
                                <div id="section-profile" class="profile-section">
                                    <h5 class="fw-bold mb-3 text-primary">Uredi osobne podatke</h5>

                                    @if(session('success'))
                                        <div class="alert alert-success rounded-pill text-center">{{ session('success') }}</div>
                                    @endif

                                    <form method="POST" action="{{ route('profile.update') }}"
                                        class="p-3 bg-white rounded-4 shadow-sm">
                                        @csrf
                                        @method('PATCH')

                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label for="ime" class="form-label fw-semibold">Ime</label>
                                                <input type="text" name="ime" id="ime" value="{{ old('ime', auth()->user()->ime ?? '') }}"
                                                    class="form-control rounded-pill shadow-sm" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="prezime" class="form-label fw-semibold">Prezime</label>
                                                <input type="text" name="prezime" id="prezime"
                                                    value="{{ old('prezime', auth()->user()->prezime ?? '') }}"
                                                    class="form-control rounded-pill shadow-sm" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="email" class="form-label fw-semibold">Email</label>
                                                <input type="email" name="email" id="email"
                                                    value="{{ old('email', auth()->user()->email ?? '') }}"
                                                    class="form-control rounded-pill shadow-sm" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="telefon" class="form-label fw-semibold">Telefon</label>
                                                <input type="text" name="telefon" id="telefon"
                                                    value="{{ old('telefon', auth()->user()->telefon ?? '') }}"
                                                    class="form-control rounded-pill shadow-sm">
                                            </div>

                                            <div class="text-end mt-3">
                                                <button type="submit"
                                                    class="btn btn-primary rounded-pill px-4 fw-semibold shadow-sm">
                                                    <i class="bi bi-save me-1"></i> Spremi promjene
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <!-- Section: Addresses -->
                                <div id="section-addresses" class="profile-section d-none">
                                    <h5 class="fw-bold mb-3 text-primary">Adrese dostave</h5>

                                    @if(session('success'))
                                        <div class="alert alert-success rounded-pill text-center">{{ session('success') }}</div>
                                    @endif

                                    <!-- Add address -->
                                    <form method="POST" action="{{ route('profile.address.add') }}"
                                        class="mb-4 p-3 bg-white rounded-4 shadow-sm">
                                        @csrf
                                        <div class="row g-2">
                                            <div class="col-md-6">
                                                <input type="text" name="adresa" class="form-control rounded-pill"
                                                    placeholder="Adresa" required>
                                            </div>
                                            <div class="col-md-6">
                                                <input type="text" name="grad" class="form-control rounded-pill"
                                                    placeholder="Grad" required>
                                            </div>
                                            <div class="col-md-6">
                                                <input type="text" name="postanski_broj" class="form-control rounded-pill"
                                                    placeholder="Poštanski broj" required>
                                            </div>
                                            <div class="col-md-6 position-relative">
                                                <input type="text" name="drzava" id="drzava"
                                                    class="form-control rounded-pill"
                                                    placeholder="Počni upisivati državu..." autocomplete="off">
                                                <ul id="country-suggestions"
                                                    class="list-group position-absolute w-100 mt-1 shadow-sm d-none"
                                                    style="z-index: 1000;"></ul>
                                            </div>


                                            <div class="col-12 d-flex align-items-center mt-2">
                                                <input type="checkbox" name="is_default" id="is_default"
                                                    class="form-check-input me-2" value="1">
                                                <label for="is_default" class="form-check-label fw-semibold">Postavi kao
                                                    zadanu adresu</label>
                                            </div>
                                        </div>
                                        <div class="mt-3 text-end">
                                            <button type="submit"
                                                class="btn btn-primary rounded-pill px-4 fw-semibold shadow-sm">
                                                <i class="bi bi-plus-circle me-1"></i> Dodaj adresu
                                            </button>
                                        </div>
                                    </form>

                                    <!-- Saved addresses -->
                                    @if(auth()->user()->addresses->isEmpty())
                                        <p class="text-muted text-center">Nemate spremljenih adresa.</p>
                                    @else
                                        <div class="list-group shadow-sm rounded-4">
                                            @foreach(auth()->user()->addresses as $address)
                                                <div
                                                    class="list-group-item d-flex justify-content-between align-items-start {{ $address->is_default ? 'bg-light border-primary' : '' }}">
                                                    <div>
                                                        <strong>{{ $address->adresa }}</strong><br>
                                                        {{ $address->postanski_broj }} {{ $address->grad }}<br>
                                                        <small class="text-muted">{{ $address->drzava }}</small>
                                                        @if($address->is_default)
                                                            <span class="badge bg-primary ms-2">Zadana</span>
                                                        @endif
                                                    </div>

                                                    <div class="d-flex align-items-center gap-2">
                                                        @if(!$address->is_default)
                                                            <form action="{{ route('profile.address.default', $address->id) }}"
                                                                method="POST">
                                                                @csrf
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-success rounded-pill">
                                                                    <i class="bi bi-check-circle"></i> Zadana
                                                                </button>
                                                            </form>
                                                        @endif
                                                        <form action="{{ route('profile.address.delete', $address->id) }}"
                                                            method="POST">
                                                            @csrf
                                                            @method('DELETE')
                                                            <button type="submit"
                                                                class="btn btn-sm btn-outline-danger rounded-pill">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            @endforeach
                                        </div>
                                    @endif
                                </div>


                                <!-- Section: Orders -->
                                <div id="section-orders" class="profile-section d-none">
                                    <p class="text-muted">Trenutno nemate narudžbi.</p>
                                </div>

                                <!-- Section: Promos -->
                                <div id="section-promos" class="profile-section d-none">
                                    <p class="text-muted">Trenutno nemate aktivnih promo kodova.</p>
                                </div>

                                <!-- Section: Password -->
                                <div id="section-password" class="profile-section d-none">
                                    <form method="POST" action="{{ route('profile.update') }}"
                                        class="p-3 bg-white rounded-4 shadow-sm">
                                        @csrf
                                        @method('PATCH')
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Nova lozinka</label>
                                            <input type="password" name="password" class="form-control rounded-pill">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Potvrdi lozinku</label>
                                            <input type="password" name="password_confirmation"
                                                class="form-control rounded-pill">
                                        </div>
                                        <button type="submit"
                                            class="btn btn-primary rounded-pill px-4 fw-semibold shadow-sm">
                                            Promijeni lozinku
                                        </button>
                                    </form>
                                </div>

                                <!-- Section: 2FA -->
                                <div id="section-2fa" class="profile-section d-none">
                                    <p class="text-muted">Dvofaktorska autentifikacija još nije postavljena.</p>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .list-group-item {
            border: none;
            border-bottom: 1px solid #f1f1f1;
            padding: 0.85rem 1.2rem;
            transition: all 0.2s ease;
        }

        .list-group-item.active {
            background-color: #0d6efd !important;
            color: white !important;
            border: none;
        }

        .list-group-item:hover {
            background-color: #f0f7ff;
        }

        .card-header {
            font-size: 1.1rem;
        }

        .profile-section {
            animation: fadeIn 0.25s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(5px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const links = document.querySelectorAll('#profile-menu a');
            const sections = document.querySelectorAll('.profile-section');
            const title = document.getElementById('section-title');

            links.forEach(link => {
                link.addEventListener('click', function (e) {
                    e.preventDefault();

                    // Sidebar highlight
                    links.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');

                    // Hide all sections
                    sections.forEach(section => section.classList.add('d-none'));

                    // Show selected
                    const sectionId = this.dataset.section;
                    document.getElementById(`section-${sectionId}`).classList.remove('d-none');

                    // Update title
                    title.textContent = this.textContent.trim();
                });
            });
        });
    </script>

    <script>
document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('drzava');
    const suggestions = document.getElementById('country-suggestions');
    let timeout = null;

    input.addEventListener('input', function() {
        const query = this.value.trim();
        clearTimeout(timeout);

        if (query.length < 1) {
            suggestions.classList.add('d-none');
            return;
        }

        timeout = setTimeout(() => {
            fetch(`/countries/search?q=${encodeURIComponent(query)}`)
                .then(res => res.json())
                .then(data => {
                    suggestions.innerHTML = '';
                    if (data.length === 0) {
                        suggestions.classList.add('d-none');
                        return;
                    }
                    data.forEach(country => {
                        const li = document.createElement('li');
                        li.className = 'list-group-item list-group-item-action';
                        li.textContent = country;
                        li.onclick = () => {
                            input.value = country;
                            suggestions.classList.add('d-none');
                        };
                        suggestions.appendChild(li);
                    });
                    suggestions.classList.remove('d-none');
                });
        }, 300);
    });

    document.addEventListener('click', (e) => {
        if (!suggestions.contains(e.target) && e.target !== input) {
            suggestions.classList.add('d-none');
        }
    });
});
</script>

@endsection