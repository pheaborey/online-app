<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\RedirectResponse;
use Carbon\Carbon;
class ReportController extends Controller
{
    public function getStockReport(Request $request)
    {
        $report_type = $request->report_type;
        $report_detail = $request->report_detail;
        $select = "SELECT ps.id,p.product_code,p.product_name,ps.total_qty,ps.cost,ps.sale_price FROM product_stocks ps JOIN Products p ON p.id=ps.product_id";
        if($report_type == 'all'){
            $stocks = DB::select(" $select ORDER BY p.id ASC");
        }elseif($report_type == 'by_product'){
            if($report_detail != 'all_product'){
                $stocks = DB::select(" $select WHERE p.id = '$report_detail' ");
            }else{
                $stocks = DB::select(" $select ORDER BY p.id ASC");
            }
        }elseif($report_type == 'by_type'){
            if($report_detail != 'all_type'){
                $stocks = DB::select(" $select WHERE p.product_type = '$report_detail' ");
            }else{
                $stocks = DB::select(" $select ORDER BY p.id ASC");
            }
        }
        return response()->json(
            [
                'success' => true,
                'stocks' => $stocks,
            ]
        );
    }
    public function getSaleReport(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        $ad_expense = DB::table('advertisements')->select('ad_expense')->whereBetween('ad_date',[$start_date,$end_date])->sum('ad_expense');
        $sales = DB::table('sales')
                    ->select('sales.*','users.name','customers.customer_name','customers.address','customers.contact','profit')
                    ->whereBetween('sale_date',[$start_date,$end_date])
                    ->join('customers','customer_id','customers.id')
                    ->join('users','users.id','seller_id')
                    ->get();
        return response()->json(
            [
                'success' => true,
                'sales' => $sales,
                'ad_expense' => $ad_expense,
            ]
        );
    }
}
