<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Tbl_User;
use App\Models\Tbl_AccessToken;
use App\Models\Tbl_LogActivity;

class UserController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    function gen_uuid() {
        return sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
            // 32 bits for "time_low"
            mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),
    
            // 16 bits for "time_mid"
            mt_rand( 0, 0xffff ),
    
            // 16 bits for "time_hi_and_version",
            // four most significant bits holds version number 4
            mt_rand( 0, 0x0fff ) | 0x4000,
    
            // 16 bits, 8 bits for "clk_seq_hi_res",
            // 8 bits for "clk_seq_low",
            // two most significant bits holds zero and one for variant DCE1.1
            mt_rand( 0, 0x3fff ) | 0x8000,
    
            // 48 bits for "node"
            mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff )
        );
    }

    public function login (Request $req) 
    {
        $username = $req->username;
        $password = $req->password;

        $user = Tbl_User::where('Username', $username)
                        ->where('Password', md5($password))
                        ->first();

        $token = Tbl_AccessToken::create([
                    'Id_User' => $user->Id_User,
                    'Token' => $this->gen_uuid()
                ]);

        if ($user && $token) {
            Tbl_LogActivity::create([
                'waktu' => date("Y-m-d H:i:s"),
                'aktifitas' => 'Login pada Android',
                'Id_User' => $user->Id_User
            ]);

            return response()->json([
                'status' => 'Success',
                'data' => $user,
                'access_token' => $token->Token
            ], 200);
        } else if (!$user)
            return response()->json([
                'status' => 'Kombinasi username dan password tidak cocok!'
            ], 400);
        else
            return response()->json([
                'status' => 'Fail (missing field / unexpected value)'
            ], 400);
    }

    public function register (Request $req) 
    {
        $username = $req->username;
        $password = $req->password;

        try {
            $user = Tbl_User::create([
                            'Tipe_User' => 'Kasir',
                            'Nama_User' => $req->nama_lengkap,
                            'Alamat' => $req->alamat,
                            'Telepon' => $req->telepon,
                            'Username' => $username,
                            'Password' => md5($password)
                        ]);

            Tbl_LogActivity::create([
                'waktu' => date("Y-m-d H:i:s"),
                'aktifitas' => 'Register pada Android',
                'Id_User' => $user->Id_User
            ]);

            if ($user)
                return response()->json([
                    'status' => 'Success'
                ], 200);
            else
                return response()->json([
                    'status' => 'Fail (missing field / unexpected value)'
                ], 400);
        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'Fail (missing field / unexpected value)'
            ], 400);
        }
    }
}
