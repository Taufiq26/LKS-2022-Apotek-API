<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_JenisObat extends Model
{
    protected $table = 'Tbl_JenisObat';
    protected $primaryKey = "Id_JenisObat";
    protected $fillable = [
        'Jenis_Obat'
    ];
    public $timestamps = false;
}
