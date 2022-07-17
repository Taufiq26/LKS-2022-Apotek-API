<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_TransaksiDetail extends Model
{
    protected $table = 'Tbl_TransaksiDetail';
    protected $primaryKey = 'Id_TransaksiDetail';
    protected $fillable = [
        'Id_Transaksi', 'Id_Resep', 
        'Id_Obat', 'Qty_Obat',
        'Subtotal'
    ];
    public $timestamps = false;

    
    public function obat() {
        return $this->hasMany(Tbl_Obat::class, 'Id_Obat', 'Id_Obat');
    }
}
