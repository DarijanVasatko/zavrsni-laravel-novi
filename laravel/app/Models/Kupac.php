<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kupac extends Model
{
    protected $table = 'kupac';
    protected $primaryKey = 'Kupac_ID';
    public $timestamps = false;

    protected $fillable = [
        'Ime', 'Prezime', 'Adresa', 'KucniBroj',
        'PostarskiBroj', 'Drzava', 'Email',
        'Username', 'Lozinka'
    ];

    public function narudzbe()
    {
        return $this->hasMany(Narudzba::class, 'Kupac_ID', 'Kupac_ID');
    }
}
