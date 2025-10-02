<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetaljiNarudzbe extends Model
{
    protected $table = 'detalji_narudzbe';
    protected $primaryKey = 'DetaljiNarudzbe_ID';
    public $timestamps = false;

    protected $fillable = [
        'Narudzba_ID', 'Proizvod_ID', 'Kolicina'
    ];

    public function narudzba()
    {
        return $this->belongsTo(Narudzba::class, 'Narudzba_ID', 'Narudzba_ID');
    }

    public function proizvod()
    {
        return $this->belongsTo(Proizvod::class, 'Proizvod_ID', 'Proizvod_ID');
    }
}
