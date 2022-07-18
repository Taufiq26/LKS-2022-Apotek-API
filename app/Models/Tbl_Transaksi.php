<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_Transaksi extends Model
{
    protected $table = 'Tbl_Transaksi';
    protected $primaryKey = 'Id_Transaksi';
    protected $fillable = [
        'No_Transaksi', 'Tgl_Transaksi', 
        'Nama_Pasien', 'Total_Bayar', 
        'Id_User', 'Id_JenisObat'
    ];
    public $timestamps = false;

    
    public function detail() {
        return $this->hasMany(Tbl_TransaksiDetail::class, 'Id_Transaksi', 'Id_Transaksi');
    }
    
    public function jenis_obat() {
        return $this->hasOne(Tbl_JenisObat::class, 'Id_JenisObat', 'Id_JenisObat');
    }
}
