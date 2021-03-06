<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tbl_AccessToken extends Model
{
    protected $table = 'Tbl_AccessToken';
    protected $fillable = [
        'Id_User', 'Token'
    ];
    public $timestamps = false;


    public function user() {
        return $this->hasOne(Tbl_User::class, 'Id_User', 'Id_User');
    }
}