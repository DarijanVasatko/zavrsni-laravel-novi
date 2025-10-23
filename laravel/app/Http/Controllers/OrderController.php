<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Models\Narudzba;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Narudzba::where('user_id', Auth::id())
            ->with('nacinPlacanja')
            ->latest()
            ->get();

        return view('orders.index', compact('orders'));
    }

    public function show($id)
    {
        $order = Narudzba::with(['detalji.proizvod', 'nacinPlacanja'])
            ->where('user_id', Auth::id())
            ->findOrFail($id);

        return view('orders.show', compact('order'));
    }
}
