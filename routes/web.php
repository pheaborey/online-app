<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SaleController;
use App\Http\Controllers\PurchaseController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//for sales report
Route::get('/reports/sales-report', function () {
    return view('vendor.voyager.reports.sales-report');
});
Route::post('get_sale_report', [SaleController::class, 'getSaleReport']);

//for stocks report
Route::get('/reports/stocks-report', function (){
    return view('vendor.voyager.reports.stocks-report');
});
Route::post('get_stock_report', [SaleController::class, 'getStockReport']);

//for purchase report
Route::get('/reports/purchases-report', function () {
    return view('vendor.voyager.reports.purchases-report');
});
Route::post('get_purchase_report', [SaleController::class, 'getPOReport']);

Route::post('return_stock', [SaleController::class, 'return_stock']);


Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});

// for sales
Route::post('saleinsert', [SaleController::class, 'saveSale']);
Route::post('poinsert', [PurchaseController::class, 'savePo']);
Route::post('createproduct', [SaleController::class, 'saveProduct']);
Route::post('holdsale', [SaleController::class, 'holdSale']);
Route::post('deleteholdsale', [SaleController::class, 'deleteHoldSale']);


