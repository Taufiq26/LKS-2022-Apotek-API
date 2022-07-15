<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_Obat extends Model
{
    protected $table = 'Tbl_Obat';
    protected $primaryKey = "Id_Obat";
    protected $fillable = [
        'Kode_Obat', 'Nama_Obat', 
        'Expired_Date', 'Jumlah',
        'Harga'
    ];
    public $timestamps = false;
}
