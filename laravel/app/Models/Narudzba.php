<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Narudzba extends Model
{
    protected $table = 'narudzba';
    protected $primaryKey = 'Narudzba_ID';
    public $timestamps = false;

    protected $fillable = [
        'Kupac_ID', 'NacinPlacanja_ID', 'Datum_narudzbe', 'Ukupni_iznos'
    ];

    public function kupac()
    {
        return $this->belongsTo(Kupac::class, 'Kupac_ID', 'Kupac_ID');
    }

    public function detalji()
    {
        return $this->hasMany(DetaljiNarudzbe::class, 'Narudzba_ID', 'Narudzba_ID');
    }

    public function nacinPlacanja()
    {
        return $this->belongsTo(NacinPlacanja::class, 'NacinPlacanja_ID', 'NacinPlacanja_ID');
    }
}
