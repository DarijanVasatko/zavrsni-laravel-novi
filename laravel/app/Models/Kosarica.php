<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kosarica extends Model
{
    protected $table = 'kosarica';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'korisnik_id', 'proizvod_id', 'kolicina', 'datum_dodavanja'
    ];

    public function kupac()
    {
        return $this->belongsTo(Kupac::class, 'korisnik_id', 'Kupac_ID');
    }

    public function proizvod()
    {
        return $this->belongsTo(Proizvod::class, 'proizvod_id', 'Proizvod_ID');
    }
}
