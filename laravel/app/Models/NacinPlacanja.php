<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NacinPlacanja extends Model
{
    protected $table = 'nacin_placanja';
    protected $primaryKey = 'NacinPlacanja_ID';
    public $timestamps = false;

    protected $fillable = ['Opis'];

    public function narudzbe()
    {
        return $this->hasMany(Narudzba::class, 'NacinPlacanja_ID', 'NacinPlacanja_ID');
    }
}
