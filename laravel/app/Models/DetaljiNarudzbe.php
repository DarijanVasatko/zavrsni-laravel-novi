<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetaljiNarudzbe extends Model
{
    use HasFactory;

    protected $table = 'detalji_narudzbe';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'narudzba_id',
        'proizvod_id',
        'kolicina',
        'cijena'
    ];

    /** 🔗 Relations */
    public function narudzba()
    {
        return $this->belongsTo(Narudzba::class, 'narudzba_id');
    }

    public function proizvod()
    {
        return $this->belongsTo(Proizvod::class, 'proizvod_id');
    }
}
