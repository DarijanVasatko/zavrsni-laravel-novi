<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Narudzba extends Model
{
    use HasFactory;

    protected $table = 'narudzba';
    protected $primaryKey = 'id';
    public $timestamps = true;

    protected $fillable = [
        'user_id',
        'nacin_placanja_id',
        'ukupna_cijena',
        'status',
        'adresa_dostave',
    ];

    /** 🔗 Relations */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function detalji()
    {
        return $this->hasMany(DetaljiNarudzbe::class, 'narudzba_id');
    }

    public function nacinPlacanja()
    {
        return $this->belongsTo(NacinPlacanja::class, 'nacin_placanja_id');
    }
}
