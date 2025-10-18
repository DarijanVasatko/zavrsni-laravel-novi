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
    // 🔹 1. Find the product
    $proizvod = Proizvod::findOrFail($id);

    // 🔹 2. Get the quantity from the form (default to 1)
    $quantity = (int) $request->input('quantity', 1);

    // 🔹 3. Stock check (Step 4)
    if ($proizvod->StanjeNaSkladistu < $quantity) {
        return redirect()->back()->with('error', 'Nema dovoljno proizvoda na zalihi.');
    }

    // 🔹 4. Get existing cart from session or create empty one
    $cart = session()->get('cart', []);

    // 🔹 5. If product already in cart → increase quantity
    if (isset($cart[$id])) {
        // Prevent exceeding stock
        $newQuantity = $cart[$id]['quantity'] + $quantity;

        if ($newQuantity > $proizvod->StanjeNaSkladistu) {
            return redirect()->back()->with('error', 'Ne možete dodati više od dostupne količine.');
        }

        $cart[$id]['quantity'] = $newQuantity;
    } else {
        // 🔹 6. Add as a new product
        $cart[$id] = [
            'name' => $proizvod->Naziv,
            'price' => $proizvod->Cijena,
            'image' => $proizvod->Slika,
            'quantity' => $quantity,
        ];
    }

    // 🔹 7. Save the updated cart in session
    session()->put('cart', $cart);

    // 🔹 8. Redirect back with success message
    return redirect()->back()->with('success', 'Proizvod dodan u košaricu!');
}

}
