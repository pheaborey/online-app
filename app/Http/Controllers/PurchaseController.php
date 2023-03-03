<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Models\ProductStock;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\RedirectResponse;

class PurchaseController extends Controller
{
    public function savePurchase(Request $request)
    {
        $url = $request->Current_url;
        $values = parse_url($url);
        $host = explode('/Purchases',$values['path']);//cut end
        $redirect = $host[0];

        $id_update = $request->id_update;
        if($id_update > 0){
            DB::table('purchase_records')->where('purchase_id',$id_update)->delete();
            $id = DB::table('purchases')
                ->where('id',$id_update)
                ->update([
                            'supplier_id' => $request->supplier_id, //coming from ajax request
                            'total_qty' => $request->total_qty,
                            'freight_fee' => $request->freight_fee,
                            'discount' => $request->discount,
                            'amount' => $request->amount,
                            'visa_fee' => $request->visa_fee,
                            'forwarder_fee' => $request->forwarder_fee,
                            'tax_vat' => $request->tax_vat,
                            'net_amount' => $request->net_amount,
                            'purchaser' => $request->purchaser,
                            'purchase_date' => $request->purchase_date,
                            'balance' => $request->balance,
            ]);
            $id = $id_update;
            $message = "updated";
            $redirect = true;
        }else{
            $id = DB::table('Purchases')->insertGetId([
                'supplier_id' => $request->supplier_id, //coming from ajax request
                'total_qty' => $request->total_qty,
                'freight_fee' => $request->freight_fee,
                'discount' => $request->discount,
                'amount' => $request->amount,
                'visa_fee' => $request->visa_fee,
                'forwarder_fee' => $request->forwarder_fee,
                'tax_vat' => $request->tax_vat,
                'net_amount' => $request->net_amount,
                'purchaser' => $request->purchaser,
                'purchase_date' => $request->purchase_date,
                'balance' => $request->balance,
            ]);
            $message = "inserted";
            $redirect = false;

        }

        //insert purchase_records
        $purchase_records = $request->purchase_record_arr;//coming from ajax request
        
        foreach($purchase_records as $k => $data){
            DB::table('purchase_records')->insert([
                'purchase_id' => $id, 
                'product_id' => $data['product_id'],
                'quantity' => $data['quantity'],
                'cost' => $data['cost'],
                'sale_price' => $data['sale_price'],
                'cost_amount' => $data['amount'],
            ]);

            //product stock
            $pro_id_stock = DB::table('product_stocks')->where('product_id',$data['product_id'])->select('product_id')->first();
            $current_qty = ($data['quantity']-0);
            if(is_null($pro_id_stock)){
                DB::table('product_stocks')->insert([
                    'product_id' => $data['product_id'],
                    'cost' => $data['cost'],
                    'sale_price' => $data['sale_price'],
                    'total_qty' => $data['quantity']
                ]);
            }else{
                $stock_qty = DB::table('product_stocks')->select('total_qty')->where('product_id',$data['product_id'])->first()->total_qty;
                DB::table('product_stocks')->where('product_id',$data['product_id'])
                ->update([
                    'cost' => $data['cost'],
                    'total_qty' => ($stock_qty + $current_qty)
                ]);
            }
        }

        return response()->json(
            [
                'success' => true,
                'message' => 'Data '.$message.' successfully',
                'redirect' => $redirect
                
            ]
        );
    }
    public function saveSupplier(Request $request)
    {
        $id = DB::table('suppliers')->insertGetId([
            'supplier_name' => $request->supplier_name, //coming from ajax request
            'address' => $request->supplier_address,
            'contact' => $request->supplier_contact
        ]);
        return response()->json(
            [
                'success' => true,
                'message' => 'Supplier created successfully',
                'supplier_id' => $id
            ]
        );
    }
    public function saveProduct(Request $request)
    {
        $id = DB::table('products')->insertGetId([
            'product_name' => $request->product_name, //coming from ajax request
            'product_code' => $request->product_code,
            'product_type' => $request->product_type
        ]);
        return response()->json(
            [
                'success' => true,
                'message' => 'Supplier created successfully',
                'product_id' => $id
            ]
        );
    }
    public function deleteHoldPurchase(Request $request)
    {
        DB::table('hold_carts')->where('created_at','=', $request->cart_no)->delete();
        return response()->json(
            [
                'success' => true,
                'message' => 'Hold cart was deleted successfully',
            ]
        );
    }
    public function holdPurchase(Request $request)
    {
         $hold_carts = $request->hold_cart_arr;
         foreach($hold_carts as $k => $data){
             DB::table('hold_carts')->insert([
                 'product_id' => $data['product_id'],
                 'quantity' => $data['quantity'],
                 'unit_price' => $data['unit_price'],
                 'cost' => $data['cost'],
                 'amount' => $data['amount'],
                 'cart_type' =>'purchase'
             ]);
         }

        return response()->json(
            [
                'success' => true,
                'message' => 'Your cart was hold successfully',
            ]
        );
    }
}
