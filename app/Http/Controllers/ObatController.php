<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Tbl_Obat;
use App\Models\Tbl_JenisObat;

class ObatController extends Controller
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

    public function getObat (Request $req) 
    {
        try {
            $obat = Tbl_Obat::all();
    
            return response()->json([
                'data' => $obat
            ], 200);
        } catch (\Throwable $th) {
    
            return response()->json([
                'status' => 'Fail (missing field / unexpected value)'
            ], 400);
        }
    }

    public function getJenisObat (Request $req) 
    {
        try {
            $jenis_obat = Tbl_JenisObat::all();
    
            return response()->json([
                'data' => $jenis_obat
            ], 200);
        } catch (\Throwable $th) {
    
            return response()->json([
                'status' => 'Fail (missing field / unexpected value)'
            ], 400);
        }
    }
}