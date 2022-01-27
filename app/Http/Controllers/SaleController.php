<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\RedirectResponse;

class SaleController extends Controller
{
    public function index()
    {
        echo "Hello Sale Controller";
    }

    public function saveSale(Request $request)
    {
        $url = $request->Current_url;
        $values = parse_url($url);
        $host = explode('/sales',$values['path']);//cut end
        $redirect = $host[0] . "/sales";

        $customer_select = $request->Customer_select;
        if($customer_select != 'new_customer'){
            $customer_code = $request->Customer_select;
        }else{
            $id = DB::table('customers')->insertGetId([
                'customer_name' => $request->Customer_name,
                'customer_address' => $request->Address,
                'customer_contact' => $request->Contact,
            ]);
            $customer_code = $id;
        }

        $id_update = $request->Id_update;
        if($id_update > 0){
            DB::table('Sales')->where('id',$id_update)->delete();
            $id = DB::table('Sales')->insertGetId([
                'customer_code' => $customer_code, //coming from ajax request
                'delivery_fee' => $request->Delivery_fee,
                'discount' => $request->Total_discount,
                'total_amount' => $request->Total_amount,
                'forwarder_fee' => $request->Forwarder_fee,
                'net_amount' => $request->Net_amount,
                'created_by' => $request->Seller,
                'sale_date' => $request->Sale_date,
                'balance' => $request->Balance,
            ]);
            DB::table('Sales')
              ->where('id',$id)
              ->update(['id' => $id_update]);
            $id = $id_update;
            $message = "updated";
        }else{
            $id = DB::table('Sales')->insertGetId([
                'customer_code' => $customer_code, //coming from ajax request
                'delivery_fee' => $request->Delivery_fee,
                'discount' => $request->Total_discount,
                'total_amount' => $request->Total_amount,
                'forwarder_fee' => $request->Forwarder_fee,
                'net_amount' => $request->Net_amount,
                'created_by' => $request->Seller,
                'sale_date' => $request->Sale_date,
                'balance' => $request->Balance,
            ]);
            $message = "inserted";

        }
        

        //insert Sale_records
        $sale_records = $request->Sale_records;//coming from ajax request
        foreach($sale_records as $k => $data){
            DB::table('Sale_records')->insert([
                'sale_code' => $id, 
                'product_code' => $data['product_code'],
                'quantity' => $data['quantity'],
                'unit_price' => $data['price'],
                'discount' => $data['discount'],
                'amount' => $data['total_amount'],
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
    public function saveProduct(Request $request)
    {
        $id = DB::table('Products')->insertGetId([
            'product_name' => $request->Product_name, //coming from ajax request
            'product_type' => $request->Product_type,
        ]);
        return response()->json(
            [
                'success' => true,
                'message' => 'Product created successfully',
                'product_code' => $id
            ]
        );
    }
    public function deleteHoldSale(Request $request)
    {
        DB::table('hold_sales')->where('id','=', $request->delete_id)->delete();
        return response()->json(
            [
                'success' => true,
                'message' => 'Hold sale was deleted successfully',
            ]
        );
    }
    public function holdSale(Request $request)
    {
        $id = DB::table('hold_sales')->insertGetId([
            'customer_code' => $request->Customer_select,
            'customer_name' => $request->Customer_name,
            'customer_contact' => $request->Customer_contact,
            'customer_address' => $request->Customer_address,
            'delivery_fee' => $request->Delivery_fee,
            'total_discount' => $request->Total_discount,
            'delivery_expense' => $request->Forwarder_fee,
            'seller' => $request->Seller,
            'sale_date' => $request->Sale_date,
        ]);
    
         $sale_records = $request->Sale_records;
         foreach($sale_records as $k => $data){
             DB::table('hold_sale_records')->insert([
                 'sale_code' => $id, 
                 'product_id' => $data['product_code'],
                 'quantity' => $data['quantity'],
                 'unit_price' => $data['price'],
                 'discount' => $data['discount'],
             ]);
         }

        return response()->json(
            [
                'success' => true,
                'message' => 'Sales records was hold successfully',
            ]
        );
    }
    public function getSaleReport(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        $ad_expense = DB::table('advertisements')->select('ad_expense')->whereBetween('ad_date',[$start_date,$end_date])->sum('ad_expense');
        $sales = DB::select("SELECT s.*,c.customer_address,SUM(sr.quantity) total_qty,SUM(ps.cost*sr.quantity) total_cost,s.net_amount - SUM((ps.cost*sr.quantity)) profit 
            FROM Sale_records sr
            JOIN Product_stocks ps ON sr.product_code=ps.product_code
            JOIN Sales s ON s.id=sr.sale_code
            JOIN customers c ON c.id=s.customer_code
            WHERE s.sale_date BETWEEN '$start_date' AND '$end_date'
            GROUP BY s.id");
        return response()->json(
            [
                'success' => true,
                'sales' => $sales,
                'ad_expense' => $ad_expense,
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
            JOIN Purchases po ON po.id=pr.po_code
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
    public function getStockReport(Request $request)
    {
        $report_type = $request->report_type;
        $report_detail = $request->report_detail;
        $select = "SELECT ps.product_code,p.product_name,ps.quantity,ps.cost,ps.sale_price FROM product_stocks ps JOIN Products p ON p.id=ps.product_code";
        if($report_type == 'all'){
            $stocks = DB::select(" $select ORDER BY ps.product_code ASC");
        }elseif($report_type == 'by_product'){
            if($report_detail != 'all_product'){
                $stocks = DB::select(" $select WHERE p.id = '$report_detail' ");
            }else{
                $stocks = DB::select(" $select ORDER BY ps.product_code ASC");
            }
        }elseif($report_type == 'by_type'){
            if($report_detail != 'all_type'){
                $stocks = DB::select(" $select WHERE p.product_type = '$report_detail' ");
            }else{
                $stocks = DB::select(" $select ORDER BY ps.product_code ASC");
            }
        }
        return response()->json(
            [
                'success' => true,
                'stocks' => $stocks,
            ]
        );
    }
    public function return_stock(Request $request)
    {
        $status = $request->status;
        $id = $request->id;
        $product_id = '';
        $old_quantity = '';
        $sale = DB::table('sale_records')->select('product_code','quantity')->where('sale_code',$id)->get();
        // foreach ($sale as $value){
        //     array_push($product_id,$value->product_code);
        // }

        if($status > 0){
            DB::table('sales')->where('id',$id)->update(['status' => 0]);
            foreach ($sale as $key => $value){
                $product_id = $value->product_code;
                $old_quantity = DB::table('product_stocks')->select('quantity')->where('product_code',$product_id)->first()->quantity;
                $quantity = ($old_quantity - 0) + ($value->quantity -0);
                DB::table('product_stocks')->where('product_code',$product_id)->update(['quantity'=>$quantity]);
            }
            
        }else{
            DB::table('sales')->where('id',$id)->update(['status' => 1]);
            foreach ($sale as $key => $value){
                $product_id = $value->product_code;
                $old_quantity = DB::table('product_stocks')->select('quantity')->where('product_code',$product_id)->first()->quantity;
                $quantity = ($old_quantity - 0) - ($value->quantity -0);
                DB::table('product_stocks')->where('product_code',$product_id)->update(['quantity'=>$quantity]);
            }
        }
        return response()->json(
            [
                'success' => true,
                'message' => 'Stock redo successful',
                'old_quantity' => $old_quantity,
            ]
        );
    }
}
