@extends('layouts.app')

@section('title', 'Prijava - TechShop')

@section('content')
<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="col-md-5">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-5">
                <h3 class="text-center mb-4 fw-bold text-primary">
                    <i class="bi bi-box-arrow-in-right me-2"></i> Prijava
                </h3>

                @if (session('status'))
                    <div class="alert alert-success">{{ session('status') }}</div>
                @endif

                <form method="POST" action="{{ route('login') }}">
                    @csrf

                    <div class="mb-3">
                        <label for="email" class="form-label">Email adresa</label>
                        <input id="email" type="email" name="email"
                            class="form-control @error('email') is-invalid @enderror"
                            value="{{ old('email') }}" required autofocus>
                        @error('email')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Lozinka</label>
                        <input id="password" type="password" name="password"
                            class="form-control @error('password') is-invalid @enderror" required>
                        @error('password')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="remember" id="remember">
                            <label class="form-check-label" for="remember">Zapamti me</label>
                        </div>

                        @if (Route::has('password.request'))
                            <a class="text-decoration-none text-primary" href="{{ route('password.request') }}">
                                Zaboravljena lozinka?
                            </a>
                        @endif
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-semibold">
                        Prijavi se
                    </button>
                </form>

                <div class="text-center mt-4">
                    <span>Nemate račun?</span>
                    <a href="{{ route('register') }}" class="text-decoration-none fw-semibold text-primary">
                        Registrirajte se
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
