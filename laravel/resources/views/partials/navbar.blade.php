<nav class="navbar navbar-expand-lg navbar-dark shadow-sm sticky-top" style="background: #0d6efd;">
    <div class="container py-2">

        <!-- Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center text-white" href="{{ route('index.index') }}">
            <i class="bi bi-display me-2 fs-4"></i> <span class="fs-4">TechShop</span>
        </a>

        <!-- Toggle (mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <!-- Left Side -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link text-white fw-medium {{ request()->is('/') ? 'active' : '' }}"
                       href="{{ route('index.index') }}">
                        <i class="bi bi-house-door me-1"></i> Početna
                    </a>
                </li>

                <!-- Categories Dropdown -->
                <li class="nav-item dropdown position-relative kategorije-dropdown">
                    <a class="nav-link dropdown-toggle text-white fw-medium"
                       href="{{ route('index.index') }}"
                       id="kategorijeDropdown" role="button" aria-expanded="false">
                        <i class="bi bi-grid me-1"></i> Kategorije
                    </a>

                    <ul class="dropdown-menu shadow border-0" aria-labelledby="kategorijeDropdown">
                        @if(!empty($kategorije) && count($kategorije) > 0)
                            @foreach($kategorije as $kat)
                                @if(is_object($kat))
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center"
                                           href="{{ route('proizvodi.kategorija', $kat->id_kategorija) }}">
                                            <i class="bi bi-tag-fill text-primary me-2"></i>
                                            <span>{{ $kat->ImeKategorija }}</span>
                                        </a>
                                    </li>
                                @endif
                            @endforeach
                        @else
                            <li><span class="dropdown-item text-muted">Nema dostupnih kategorija</span></li>
                        @endif
                    </ul>
                </li>
            </ul>

            <!-- Search Bar -->
            <form method="GET"
                action="{{ isset($categoryId) && $categoryId ? route('proizvodi.kategorija', $categoryId) : route('proizvodi.index') }}"
                class="d-flex align-items-center search-form me-3">
                <div class="search-container d-flex align-items-center bg-white rounded-pill shadow-sm px-3 py-1">
                    <input type="text" name="search" value="{{ request('search') }}"
                           class="form-control border-0 search-input"
                           placeholder="Pretraži proizvode..." aria-label="Search">
                    <button type="submit" class="btn btn-link text-primary p-0 ms-2">
                        <i class="bi bi-search fs-5"></i>
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
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"
                           data-bs-toggle="dropdown">{{ Auth::user()->name }}</a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <li>
                                <a class="dropdown-item" href="{{ route('logout') }}"
                                   onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                                    Odjava
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

<!-- Navbar Styling -->
<style>
    .navbar .dropdown-menu a.dropdown-item:hover {
        background-color: #f8f9fa;
        transform: translateX(5px);
        transition: 0.2s;
    }

    .navbar .nav-link.active {
        font-weight: bold;
        border-bottom: 2px solid #fff;
    }

    /* Search bar animation */
    .search-container {
        transition: all 0.3s ease;
        width: 590px;
    }

    .search-container:focus-within {
        width: 600px;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }

    .search-input {
        outline: none !important;
        box-shadow: none !important;
    }

    .search-input::placeholder {
        color: #888;
    }

    .search-input:focus::placeholder {
        color: transparent;
    }

    @media (max-width: 992px) {
        .search-container {
            width: 100%;
        }
    }

    /* ✅ Center dropdown under 'Kategorije' with 10px gap */
    .navbar .dropdown-menu {
        left: 50% !important;
        transform: translateX(-50%) !important;
        margin-top: 10px !important;
    }
</style>

<!-- ✅ JS: Hover to open dropdown -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const dropdown = document.querySelector(".kategorije-dropdown");
        const toggle = dropdown?.querySelector(".dropdown-toggle");
        const menu = dropdown?.querySelector(".dropdown-menu");
        let timeoutId;

        if (dropdown && toggle && menu) {
            const bsDropdown = new bootstrap.Dropdown(toggle);

            // Show on hover
            dropdown.addEventListener("mouseenter", () => {
                clearTimeout(timeoutId);
                bsDropdown.show();
            });

            // Hide only after a delay when leaving
            dropdown.addEventListener("mouseleave", () => {
                timeoutId = setTimeout(() => {
                    bsDropdown.hide();
                }, 50); // 👈 stays open for 300ms after leaving
            });

            // Keep open while hovering over menu itself
            menu.addEventListener("mouseenter", () => clearTimeout(timeoutId));
            menu.addEventListener("mouseleave", () => {
                timeoutId = setTimeout(() => {
                    bsDropdown.hide();
                }, 300);
            });
        }
    });
</script>

