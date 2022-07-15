<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_User extends Model
{
    protected $table = 'Tbl_User';
    protected $primaryKey = 'Id_User';
    protected $fillable = [
        'Tipe_User', 'Nama_User', 
        'Alamat', 'Telepon', 
        'Username', 'Password'
    ];
    public $timestamps = false;
}
