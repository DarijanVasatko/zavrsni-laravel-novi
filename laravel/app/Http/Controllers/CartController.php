<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Proizvod;

class CartController extends Controller
{
    // Show cart page
    public function index()
    {
        $cart = session()->get('cart', []); // Get cart from session
        $total = 0;

        // Calculate total price
        foreach ($cart as $item) {
            $total += $item['price'] * $item['quantity'];
        }

        return view('cart', compact('cart', 'total'));
    }

    // Add product to cart
    public function add(Request $request, $id)
    {
        $product = Proizvod::findOrFail($id);

        $cart = session()->get('cart', []);

        if (isset($cart[$id])) {
            $cart[$id]['quantity']++;
        } else {
            $cart[$id] = [
                "name" => $product->Naziv,
                "quantity" => 1,
                "price" => $product->Cijena,
                "image" => $product->Slika
            ];
        }

        session()->put('cart', $cart);

        return redirect()->back()->with('success', 'Proizvod dodan u košaricu!');
    }
}
