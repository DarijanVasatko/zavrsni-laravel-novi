<nav class="navbar navbar-expand-lg navbar-dark shadow-sm sticky-top" style="background: linear-gradient(90deg, #0d6efd, #0046b8);">
    <div class="container py-2">

        <!-- Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center text-white" href="{{ url('/') }}">
            <i class="bi bi-display me-2 fs-4"></i>
            <span>TechShop</span>
        </a>

        <!-- Toggle (mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <!-- Left Side -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-medium {{ request()->is('/') ? 'active' : '' }}" href="{{ url('/') }}">
                        <i class="bi bi-house me-1"></i> Početna
                    </a>
                </li>

                <!-- Categories Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white fw-medium" href="#" id="kategorijeDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-grid me-1"></i> Kategorije
                    </a>
                    <ul class="dropdown-menu border-0 shadow">
                        @foreach($kategorije ?? [] as $kat)
                            <li>
                                <a class="dropdown-item" href="{{ route('proizvodi.kategorija', $kat->id_kategorija) }}">
                                    {{ $kat->ImeKategorija }}
                                </a>
                            </li>
                        @endforeach
                    </ul>
                </li>
            </ul>

            <!-- Search Form -->
            <form method="GET"
                  action="{{ isset($categoryId) && $categoryId ? route('proizvodi.kategorija', $categoryId) : route('proizvodi.index') }}"
                  class="d-flex align-items-center me-3 w-50">

                <div class="input-group">
                    <input type="text" name="search" value="{{ request('search') }}" class="form-control rounded-start-pill"
                           placeholder="Pretraži proizvode...">

                    <select name="sort" class="form-select border-start-0" style="max-width: 160px;"
                            onchange="this.form.submit()">
                        <option value="">Sortiraj</option>
                        <option value="name_asc" {{ request('sort') == 'name_asc' ? 'selected' : '' }}>Naziv (A-Z)</option>
                        <option value="name_desc" {{ request('sort') == 'name_desc' ? 'selected' : '' }}>Naziv (Z-A)</option>
                        <option value="price_asc" {{ request('sort') == 'price_asc' ? 'selected' : '' }}>Cijena (↓)</option>
                        <option value="price_desc" {{ request('sort') == 'price_desc' ? 'selected' : '' }}>Cijena (↑)</option>
                        <option value="newest" {{ request('sort') == 'newest' ? 'selected' : '' }}>Najnoviji</option>
                    </select>

                    <button type="submit" class="btn btn-light rounded-end-pill">
                        <i class="bi bi-search text-primary"></i>
                    </button>
                </div>
            </form>

            <!-- Right Side -->
            <ul class="navbar-nav align-items-center mb-2 mb-lg-0">
                <!-- Cart -->
                <li class="nav-item me-3 position-relative">
                    <a href="{{ route('cart.index') }}" class="text-white position-relative fs-5">
                        <i class="bi bi-cart"></i>
                        @if(session('cart'))
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                {{ count(session('cart')) }}
                            </span>
                        @endif
                    </a>
                </li>

                <!-- Auth Buttons -->
                @guest
                    <li class="nav-item me-2">
                        <a class="btn btn-outline-light rounded-pill px-3" href="{{ route('login') }}">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Prijava
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn text-white rounded-pill px-3"
                           style="background: linear-gradient(90deg, #ff6600, #ff3366);"
                           href="{{ route('register') }}">
                            <i class="bi bi-person-plus me-1"></i> Registracija
                        </a>
                    </li>
                @else
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button"
                           data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle me-1"></i> {{ Auth::user()->name }}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                            <li>
                                <a class="dropdown-item" href="#"
                                   onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                                    <i class="bi bi-box-arrow-right me-1"></i> Odjava
                                </a>
                            </li>
                        </ul>
                    </li>
                    <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                        @csrf
                    </form>
                @endguest
            </ul>
        </div>
    </div>
</nav>
