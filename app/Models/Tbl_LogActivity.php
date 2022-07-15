<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_LogActivity extends Model
{
    protected $table = 'Tbl_LogActivity';
    protected $primaryKey = "Id_Log";
    protected $fillable = [
        'waktu', 'aktifitas', 'Id_User'
    ];
    public $timestamps = false;
}
