<!-- resources/views/cart.blade.php -->
@extends('layouts.app')

@section('content')
    <h2>🛒 Vaša košarica</h2>

    @if(session('cart') && count(session('cart')) > 0)
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Slika</th>
                    <th>Naziv</th>
                    <th>Količina</th>
                    <th>Cijena</th>
                    <th>Ukupno</th>
                </tr>
            </thead>
            <tbody>
                @php $total = 0; @endphp
                @foreach(session('cart') as $id => $item)
                    @php $subtotal = $item['price'] * $item['quantity']; $total += $subtotal; @endphp
                    <tr>
                        <td><img src="{{ $item['image'] }}" alt="{{ $item['name'] }}" width="80"></td>
                        <td>{{ $item['name'] }}</td>
                        <td>{{ $item['quantity'] }}</td>
                        <td>{{ number_format($item['price'], 2) }} €</td>
                        <td>{{ number_format($subtotal, 2) }} €</td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        <h4 class="text-end">Ukupno: <strong>{{ number_format($total, 2) }} €</strong></h4>
    @else
        <p>Vaša košarica je prazna.</p>
    @endif
@endsection
