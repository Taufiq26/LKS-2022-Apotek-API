<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Tbl_AccessToken;
use App\Models\Tbl_Transaksi;
use App\Models\Tbl_TransaksiDetail;
use App\Models\Tbl_LogActivity;
use App\Models\Tbl_Obat;

class TransaksiController extends Controller
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

    public function generateNoTransaksi()
    {
        $last = Tbl_Transaksi::orderBy('Id_Transaksi', 'DESC')->first();

        if ($last) {
            $next_no = 'T';

            $id = $last->Id_Transaksi + 1;
            $digit = strlen((string)$id);
            for ($i=0; $i<(3-$digit); $i++) {
                $next_no .= '0';
            }

            $next_no .= (string)$id;
            return $next_no;
        } else {
            return 'T001';
        }
    }

    public function submitTransaksi (Request $req) 
    {
        try {
            $user = Tbl_AccessToken::where('Token', $req->header('Authorization'))
                                    ->first()
                                    ->user;

            $transaksi = Tbl_Transaksi::create([
                'No_Transaksi' => $this->generateNoTransaksi(),
                'Tgl_Transaksi' => date('Y-m-d'),
                'Total_Bayar' => $req->total_bayar,
                'Nama_Pasien' => $req->nama_pasien,
                'Id_User' => $user->Id_User,
                'Id_JenisObat' => $req->id_jenis_obat
            ]);

            foreach ($req->obat as $obat) {
                $obat_update = Tbl_Obat::find($obat);

                Tbl_TransaksiDetail::create([
                    'Id_Transaksi' => $transaksi->Id_Transaksi,
                    'Id_Obat' => $obat_update->Id_Obat,
                    'Qty_Obat' => 1,
                    'Subtotal' => $obat_update->Harga,
                ]);

                $obat_update->Jumlah = $obat_update->Jumlah - 1;
                $obat_update->save();
            }

            Tbl_LogActivity::create([
                'waktu' => date("Y-m-d H:i:s"),
                'aktifitas' => 'Transaksi '. $transaksi->No_Transaksi .' pada Android',
                'Id_User' => $user->Id_User
            ]);
    
            $transaksi = Tbl_Transaksi::with('detail.obat')
                                    ->find($transaksi->Id_Transaksi);
            return response()->json([
                'data' => $transaksi
            ], 200);
        } catch (\Throwable $th) {
    
            return response()->json([
                'status' => 'Fail (missing field / unexpected value)',
                'error' => $th
            ], 400);
        }
    }
}