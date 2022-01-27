<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\RedirectResponse;

class PurchaseController extends Controller
{
    public function savePo(Request $request)
    {
        $url = $request->Current_url;
        $values = parse_url($url);
        $host = explode('/purchases',$values['path']);//cut end
        $redirect = $host[0] . "/purchases";

        $supplier_select = $request->Supplier_code;
        if($supplier_select != 'new_supplier'){
            $supplier_code = $supplier_select;
        }else{
            $id = DB::table('suppliers')->insertGetId([
                'supplier_name' => $request->Supplier_name,
                'supplier_address' => $request->Supplier_address,
                'supplier_contact' => $request->Supplier_contact,
            ]);
            $supplier_code = $id;
        }

        $id_update = $request->Id_update;
        if($id_update > 0){
            DB::table('Purchases')->where('id',$id_update)->delete();
            $id = DB::table('Purchases')->insertGetId([
                'supplier_code' => $supplier_code, //coming from ajax request
                'total_quantity' => $request->Total_quantity,
                'freight_fee' => $request->Freight_fee,
                'discount' => $request->Total_discount,
                'total_amount' => $request->Total_amount,
                'visa_fee' => $request->Visa_fee,
                'other_fee' => $request->Other_fee,
                'forwarder_fee' => $request->Forwarder_fee,
                'net_amount' => $request->Net_amount,
                'created_by' => $request->Buyer,
                'purchase_date' => $request->Po_date,
                'balance' => $request->Balance,
            ]);
            DB::table('Purchases')
              ->where('id',$id)
              ->update(['id' => $id_update]);
            $id = $id_update;
            $message = "updated";
        }else{
            $id = DB::table('Purchases')->insertGetId([
                'supplier_code' => $supplier_code, //coming from ajax request
                'total_quantity' => $request->Total_quantity,
                'freight_fee' => $request->Freight_fee,
                'discount' => $request->Total_discount,
                'total_amount' => $request->Total_amount,
                'visa_fee' => $request->Visa_fee,
                'other_fee' => $request->Other_fee,
                'forwarder_fee' => $request->Forwarder_fee,
                'net_amount' => $request->Net_amount,
                'created_by' => $request->Buyer,
                'purchase_date' => $request->Po_date,
                'balance' => $request->Balance,
            ]);
            $message = "inserted";

        }
        

        //insert Sale_records
        $po_records = $request->Po_records;//coming from ajax request
        foreach($po_records as $k => $data){
            DB::table('Purchase_records')->insert([
                'po_code' => $id, 
                'product_code' => $data['product_code'],
                'quantity' => $data['quantity'],
                'cost' => $data['cost'],
                'sale_price' => $data['sale_price'],
                'cost_amount' => $data['cost_amount'],
            ]);
        }

        return response()->json(
            [
                'success' => true,
                'message' => 'Data '.$message.' successfully',
                'redirect' => $redirect
                
            ]
        );
    }
}
