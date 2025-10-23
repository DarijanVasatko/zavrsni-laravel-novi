<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NacinPlacanja extends Model
{
    use HasFactory;

    protected $table = 'nacin_placanja';
    protected $primaryKey = 'id_nacin_placanja';
    public $timestamps = false;

    protected $fillable = ['Opis']; // ✅ Use the correct column name

    /** 🔗 Relations */
    public function narudzbe()
    {
        return $this->hasMany(Narudzba::class, 'nacin_placanja_id');
    }
}
