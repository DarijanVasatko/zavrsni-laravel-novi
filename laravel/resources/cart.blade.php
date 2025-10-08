@extends('layouts.app')

@section('title', 'Košarica - TechShop')

@section('content')
<div class="container py-5">
    <h2 class="mb-4">Vaša košarica</h2>

    @if(session('cart') && count(session('cart')) > 0)
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Proizvod</th>
                    <th>Cijena</th>
                    <th>Količina</th>
                    <th>Ukupno</th>
                </tr>
            </thead>
            <tbody>
                @foreach($cart as $id => $item)
                    <tr>
                        <td>
                            <img src="{{ asset($item['image']) }}" alt="{{ $item['name'] }}" width="50">
                            {{ $item['name'] }}
                        </td>
                        <td>{{ number_format($item['price'], 2) }} €</td>
                        <td>{{ $item['quantity'] }}</td>
                        <td>{{ number_format($item['price'] * $item['quantity'], 2) }} €</td>
                    </tr>
                @endforeach
                <tr>
                    <td colspan="3" class="text-end fw-bold">Ukupno:</td>
                    <td class="fw-bold">{{ number_format($total, 2) }} €</td>
                </tr>
            </tbody>
        </table>
    @else
        <p>Vaša košarica je prazna.</p>
    @endif
</div>
@endsection
