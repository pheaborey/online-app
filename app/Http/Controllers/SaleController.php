<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\RedirectResponse;
use Carbon\Carbon;

class SaleController extends Controller
{
    public function index()
    {
        echo "Hello Sale Controller";
    }

    public function saveSale(Request $request)
    {
        // $url = $request->Current_url;
        // $values = parse_url($url);
        // $host = explode('/sales',$values['path']);//cut end
        // $redirect = $host[0] . "/sales/create";

        $id_update = $request->id_update;
        if($id_update > 0){
            DB::table('sale_records')->where('sale_id',$id_update)->delete();
            DB::table('sales')
              ->where('id',$id_update)
              ->update([
                        'customer_id' => $request->customer_id, //coming from ajax request
                        'delivery_fee' => $request->delivery_fee,
                        'discount' => $request->discount,
                        'amount' => $request->amount,
                        'net_amount' => $request->net_amount,
                        'seller_id' => $request->seller_id,
                        'sale_date' => $request->sale_date,
                        'total_qty' => $request->total_qty,
                        'cupon' => $request->cupon,
                        'tax_vat' => $request->tax_vat,
                        'total_cost' => $request->total_cost,
                        'total_profit' => $request->total_profit
                        ]);
            $id = $id_update;
            $message = "updated";
            $redirect = true;
        }else{
            $id = DB::table('sales')->insertGetId([
                'customer_id' => $request->customer_id, //coming from ajax request
                'delivery_fee' => $request->delivery_fee,
                'discount' => $request->discount,
                'amount' => $request->amount,
                'net_amount' => $request->net_amount,
                'seller_id' => $request->seller_id,
                'sale_date' => $request->sale_date,
                'total_qty' => $request->total_qty,
                'cupon' => $request->cupon,
                'tax_vat' => $request->tax_vat,
                'total_cost' => $request->total_cost,
                'total_profit' => $request->total_profit
            ]);
            $message = "inserted";
            $redirect = false;
        }
        

        //insert Sale_records
        $sale_records = $request->sale_record_arr;//coming from ajax request
        foreach($sale_records as $k => $data){
            DB::table('sale_records')->insert([
                'sale_id' => $id, 
                'product_id' => $data['product_id'],
                'quantity' => $data['quantity'],
                'unit_price' => $data['unit_price'],
                'discount' => $data['discount'],
                'amount' => $data['amount'],
                'cost' => $data['cost'],
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

    public function saveCustomer(Request $request)
    {
        $id = DB::table('customers')->insertGetId([
            'customer_name' => $request->customer_name, //coming from ajax request
            'address' => $request->customer_address,
            'contact' => $request->customer_contact
        ]);
        return response()->json(
            [
                'success' => true,
                'message' => 'Customer created successfully',
                'customer_id' => $id
            ]
        );
    }

    public function deleteHoldSale(Request $request)
    {
        DB::table('hold_carts')->where('created_at','=', $request->cart_no)->delete();
        return response()->json(
            [
                'success' => true,
                'message' => 'Hold cart was deleted successfully',
            ]
        );
    }
    public function holdSale(Request $request)
    {
         $hold_carts = $request->hold_cart_arr;
         foreach($hold_carts as $k => $data){
             DB::table('hold_carts')->insert([
                 'product_id' => $data['product_id'],
                 'quantity' => $data['quantity'],
                 'unit_price' => $data['unit_price'],
                 'discount' => $data['discount'],
                 'amount' => $data['amount'],
                 'cart_type' =>'sale'
             ]);
         }

        return response()->json(
            [
                'success' => true,
                'message' => 'Your cart was hold successfully',
            ]
        );
    }
    
    public function getPOReport(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        $purchases = DB::select("SELECT po.*,s.supplier_address,SUM(pr.quantity) total_qty,SUM(ps.cost*pr.quantity) total_cost,po.net_amount - SUM((ps.cost*pr.quantity)) profit 
            FROM Purchase_records pr
            JOIN Product_stocks ps ON pr.product_code=ps.product_code
            JOIN Purchase_orders po ON po.id=pr.po_code
            JOIN suppliers s ON s.id=po.supplier_code
            WHERE po.purchase_date BETWEEN '$start_date' AND '$end_date'
            GROUP BY po.id");
        return response()->json(
            [
                'success' => true,
                'purchases' => $purchases,
            ]
        );
    }
    
    // public function return_stock(Request $request)
    // {
    //     $status = $request->status;
    //     $id = $request->id;
    //     $product_id = '';
    //     $old_quantity = '';
    //     $sale = DB::table('sale_records')->select('product_id','quantity')->where('sale_id',$id)->get();
    //     // foreach ($sale as $value){
    //     //     array_push($product_id,$value->product_code);
    //     // }

    //     if($status > 0){
    //         DB::table('sales')->where('id',$id)->update(['deleted_at' => Carbon::now()]);
    //         foreach ($sale as $key => $value){
    //             $product_id = $value->product_id;
    //             $old_quantity = DB::table('product_stocks')->select('total_qty')->where('product_id',$product_id)->first()->total_qty;
    //             $quantity = ($old_quantity - 0) + ($value->quantity -0);
    //             DB::table('product_stocks')->where('product_id',$product_id)->update(['total_qty'=>$quantity]);
    //         }
            
    //     }else{
    //         DB::table('sales')->where('id',$id)->update(['deleted_at' => NULL]);
    //         foreach ($sale as $key => $value){
    //             $product_id = $value->product_id;
    //             $old_quantity = DB::table('product_stocks')->select('total_qty')->where('product_id',$product_id)->first()->total_qty;
    //             $quantity = ($old_quantity - 0) - ($value->quantity -0);
    //             DB::table('product_stocks')->where('product_id',$product_id)->update(['total_qty'=>$quantity]);
    //         }
    //     }
    //     return response()->json(
    //         [
    //             'success' => true,
    //             'message' => 'Stock redo successful',
    //             'old_quantity' => $old_quantity,
    //         ]
    //     );
    // }
}
?>
