@extends('layouts.app')

@section('title', 'Registracija - TechShop')

@section('content')
<div class="container d-flex justify-content-center align-items-center" style="min-height: 85vh;">
    <div class="col-md-6">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-5">
                <h3 class="text-center mb-4 fw-bold text-primary">
                    <i class="bi bi-person-plus me-2"></i> Registracija
                </h3>

                <form method="POST" action="{{ route('register') }}">
                    @csrf

                    <div class="mb-3">
                        <label for="name" class="form-label">Ime i prezime</label>
                        <input id="name" type="text" name="name"
                            class="form-control @error('name') is-invalid @enderror"
                            value="{{ old('name') }}" required autofocus>
                        @error('name')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email adresa</label>
                        <input id="email" type="email" name="email"
                            class="form-control @error('email') is-invalid @enderror"
                            value="{{ old('email') }}" required>
                        @error('email')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Lozinka</label>
                            <input id="password" type="password" name="password"
                                class="form-control @error('password') is-invalid @enderror" required>
                            @error('password')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password-confirm" class="form-label">Potvrdi lozinku</label>
                            <input id="password-confirm" type="password" name="password_confirmation" class="form-control" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-semibold">
                        Registriraj se
                    </button>
                </form>

                <div class="text-center mt-4">
                    <span>Već imate račun?</span>
                    <a href="{{ route('login') }}" class="text-decoration-none fw-semibold text-primary">
                        Prijavite se
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
