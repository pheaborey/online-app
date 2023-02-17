@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
    $rate_kh = DB::table('currencies')->select('rate','symbol')->where('id','1')->first();

    $hold_sale = DB::table('hold_sales')->select('*')->get();
    $products = DB::table('Products')
                ->join('product_stocks', 'products.id', '=', 'product_stocks.product_id')
                ->join('products_types', 'products.product_type', '=', 'products_types.id')
                ->select('products.id','product_code','product_name','product_image','sale_price','product_type')->get();
    $customers = DB::table('customers')->select('id','customer_name','address','contact')->get();
    $categories = DB::table('products_types')->select('id','type_name')->get();
    
    $hold_option ='';
    $customer_option ='';
    $option ='';
    $sale_record = DB::table('Sale_records')
                        ->select('sale_id','product_id','quantity','unit_price','discount','amount','created_at')
                        ->get();
    $sale = DB::table('Sales')->select('*')->get();
    $default_row = 5;
    $tr = '';
    if ($edit == "") {//$edit is a general variable of voyarger for check edit or add
        // echo "Add";
        // $invoice_no = DB::table('Sales')->select('id')->latest('id')->first()->id +1;
        $invoice_id = DB::table('Sales')->select('id')->latest('id')->first();
        if($invoice_id != NULL){
            $invoice_no = $invoice_id->id +1;
        }else{
            $invoice_no = 0;
        }
        
    }else{
        // echo "Edit".$edit;
        $url = $_SERVER['REQUEST_URI'];
        $values = parse_url($url);
        $host = explode('/edit',$values['path']);//cut end
        $host2 = explode('sales',$values['path']);//cut begin
        $edit = substr($host[0],(strlen($host2[0])+6));//select only sales id
        $sale = DB::table('Sales')->select('*')->where('id',$edit)->get();
        $sale_record = DB::table('Sale_records')
                        ->select('sale_id','product_id','quantity','unit_price','discount','amount','created_at')
                        ->where('sale_id',$edit)->get();
        $default_row = $sale_record->count();
        $invoice_no = $edit;
    }
    $menu = '';
    foreach ($products as $key=>$item){
        $option .= '<option value="'. $item->id .'">'. $item->product_name . '</option>';
        $menu .='<div id="pro_id_'.$item->id.'" class="col-sm-2 btn id_pro" cate_id="'.$item->product_type.'" id_pro="'.$item->id.'" name_pro="'.$item->product_name.'" price_pro = "'.$item->sale_price.'">'.
                    '<img src="../../public/storage/'.$item->product_image.'" style="width:100%;">'.
                    '<span class="caption">'.
                    '<p style="font-size:11px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;text-align:center">'. $item->product_name . '</p>'.
                    '</span></div>';
    }
    foreach ($customers as $item){
        $customer_option .= '<option value="'. $item->id .'">'. $item->customer_name .' - '.$item->address.' - '.$item->contact. '</option>';
    }
    foreach ($hold_sale as $key => $value) {
        $hold_option .= '<option value="'. $value->id .'">'.$value->customer_name.' - Hold '.$value->id. '</option>';
    }
    $option_btn = '<li><button class="btn_cate" cate_id = "all">All Categories</button></li>';
    foreach ($categories as $key=>$item){
        $option_btn .= '<li><button class="btn_cate" cate_id = "'. $item->id .'">'.$item->type_name.'</button></li>';
    }
@endphp

@extends('voyager::master')

@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        .fixed_header tbody td .menu_scroll{
        display:block;
        width: 100%;
        overflow: auto;
        height:800px;
        }
        .fixed_header tbody td .item_scroll{
        display:block;
        width: 100%;
        overflow: auto;
        height:500px;
        }
        .space{height:5px;}
        .bg-color{background-color:LightSalmon;color:white;border-radius:3px;}
    </style>
@stop

@section('page_title', __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    
    <!-- <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular') }}  
    </h1> -->
    
        <table class="table table-responsive fixed_header" >
            <thead>
                <tr>
                    <th>
                        <ul class="pagination">
                            <?php echo $option_btn ;?>
                        </ul>
                        <!-- <div class="input-group"> -->
                            <!-- <span class="input-group-addon">Find the product name or Enter the Barcode</span> -->
                            <input id="search_product" type="text" class="form-control" style="border: 1px solid LightSalmon;border-radius:5px;" placeholder="Find the product name or Enter the Barcode">
                        <!-- </div> -->
                    </th>
                    <th>
                        <select class="selectpicker" id="select_customer" data-live-search="true">
                            @php echo $customer_option @endphp   
                        </select>
                        <button class="btn-xs btn-warning" id="btn-addNewCus"><span class="voyager-plus"> Add New</span></button>
                        <button onclick="clear_cart();" class="btn-xs btn-danger" id="btn-reload"><span class="voyager-trash"> Clear Cart</span></button>
                        <span style="float: right; padding-top:5px;">Rate: $1 = <?php echo $rate_kh->rate ." ". $rate_kh->symbol ?></span>
                    </th>
                </tr>
            </thead>
            <tbody id="myTable">
                <tr>
                    <td width=70%>
                        <span class="menu_scroll" id="menu_item">
                            <!-- search data will show here -->
                            <?php echo $menu;?>
                        </span>
                    </td>
                    <td id="td_cart" style="border: 1px solid black;">
                        <span class="col-sm-1 bg-color">No.</span>
                        <span class="col-sm-6 bg-color">Product Name</span>
                        <span class="col-sm-2 bg-color">QTY</span>
                        <span class="col-sm-2 bg-color">Amount</span>
                        <span class="col-sm-1"></span>
                        <span id="cart_list" class="item_scroll">
                            <!-- data will show here -->
                        </span>
                        <div style="background-color:LightSalmon; color:white;border-radius:5px; text-align:center;">
                            <label> <span class="glyphicon glyphicon-plus-sign">Add</span></label>
                            <span class="btn" id="add_discount">Discount(%)</span>
                            <span class="btn" id="add_cupon">Cupon($)</span>
                            <span class="btn" id="add_delivery_fee">Delivery Fee($)</span>
                        </div>
                            
                        <div class="space"></div>
                        <div class="form-group">
                            <label class="col-sm-4 col-form-label">Subtotal ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="subtotal" readonly value=0>
                            </div>
                        </div>
                        <div class="form-group" id="div_add_discount" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Discount (%):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="discount" value=0>
                            </div>  
                        </div>
                        <div class="form-group" id="div_add_cupon" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Cupon ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="cupon" value=0>
                            </div>  
                        </div>
                        <div class="form-group" id="div_add_delivery_fee" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Delivery Fee ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="delivery_fee" value=0>
                            </div>  
                        </div>
                        <div class="form-group">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">VAT (%):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="tax_vat" value=0>
                            </div>  
                        </div>
                        
                        <div class="form-group">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Grand Total ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="grand_total" readonly value=0>
                            </div>  
                        </div>
                        <div class="col-md-6">
                            <button class="btn btn-warning" id="btn-hold"><span class="glyphicon glyphicon-download"> Hold Order</span></button>
                        </div>
                        <div class="col-md-6">
                            <button class="btn btn-success" id="btn-check-out" style="float:right;"><span class="glyphicon glyphicon-check"> Check Out</span></button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    
    {{-- invoice print --}}
    <div id="invoice_print" style="border: black solid 1px; width:210mm; height:auto; display:none;"> {{-- height:297mm --}}
        <table class="table">
            <tr>
                <center><h4>{{setting('admin.company_name')}}</h4></center>
                <center><h6>Shop {{setting('admin.company_contact')}}</h6></center>
                <center><h6>{{setting('admin.company_bank_account')}}</h6></center>
            </tr>
            <tr>
                <center><h5>Sale Invoice</h5></center>
            </tr>
            <tr>
                <td colspan="3">Customer Name:<span class="cus_name">Customer name here </span></td>
                <td></td><td></td>
                <td>Invoice Code: <span class="invoice_no"><?php echo $invoice_no ?></span></td>
            </tr>
            <tr>
                <td colspan="3">Tel: <span class="cus_tel">Telephone here</span></td>
                <td></td><td></td>
                <td>Sale Date: <span class="s_date">Sale Date here</span></td>
            </tr>
            <tr>
                <td colspan="3">Address: <span class="cus_address">Address here</span></td>
                <td></td><td></td>
                <td>Seller: <span class="s_seller">Seller here</span></td>
            </tr>
        </table>
        <table class="table">
            <thead>         
                <tr>
                    <th>No.</th>
                    <th>Product Name</th>
                    <th>QTY</th>
                    <th>Price</th>
                    <th>Discount</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody id="tbody_invoice">
                
            </tbody>
            <tfoot style="font-weight: bold">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Total QTY</td>
                    <td><p class="total_qty_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Total Amount</td>
                    <td><p class="total_amount_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Discount</td>
                    <td><p class="total_discount_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Amount Due</td>
                    <td><p class="amount_due_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Balance</td>
                    <td><p class="balance_inv"></p></td>
                </tr>
                <tr>
                    <td colspan="6"><center>{{setting('admin.company_thanks')}}</center></td>
                </tr>
            </tfoot>
        </table>
    </div>
     {{-- delivery card print --}}
     <div id="delivery_print" style="border: black solid 1px; width:80mm; height:100mm; display:none;"> {{-- height:297mm --}}
        <table class="table">
            <tr>
                <center>
                    <h4>{{setting('admin.company_name')}}</h4>
                    <h6>Shop {{setting('admin.company_contact')}}</h6>
                    <h6>{{setting('admin.company_bank_account')}}</h6>
                </center>
            </tr>
            <tr>
                <td>Code: <span id="invoice_no" class="invoice_no"><?php echo $invoice_no ?></span></td>
                <td>Date: <span id="s_date" class="s_date">........</span></td>
            </tr>
            <tr>
                <td colspan="2">FB Name:<span id="cus_name" class="cus_name">........</span></td>
            </tr>
            <tr>
                <td colspan="2">Tel: <span class="cus_tel" id="cus_tel" style="font-size:14px ;font-weight: bold">..........</span></td>
            </tr>
            <tr>
                <td colspan="2">Address: 
                    <span id="cus_address" class="cus_address" style="font-size:14px ;font-weight: bold">.................................... ..................................................................</span>
                </td>
            </tr>
            <tr>
                <td>Discount: $<span class="total_discount_inv">.......</span></td>
                <td>Delivery: $<span class="delivery_fee_inv">.......</span></td>
            </tr>
            <tr>
                <td colspan="2" style="font-size:14px ;font-weight: bold">Amount Due: $<span class="amount_due_inv">.........</span></td>
            </tr>
            <tr><td colspan="2"><center>{{setting('admin.company_thanks')}}</center></td></tr>
        </table>
    </div>
    <div class="modal fade modal-danger" id="confirm_delete_modal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> {{ __('voyager::generic.are_you_sure') }}</h4>
                </div>

                <div class="modal-body">
                    <h4>{{ __('voyager::generic.are_you_sure_delete') }} '<span class="confirm_delete_name"></span>'</h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                    <button type="button" class="btn btn-danger" id="confirm_delete">{{ __('voyager::generic.delete_confirm') }}</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Delete File Modal -->

    <div class="modal fade modal-payment" id="payment_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> Payment Form</h4>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <h2>Payment Info</h2>
                        <form class="form-horizontal" action="">
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="amount_due">Amount_Due: ($_USD)</label>
                                <div class="col-sm-3">
                                <input type="text" class="form-control" id="amount_due" disabled value="<?php  ?>">
                                </div>
                                <div class="col-sm-3">
                                <input type="text" class="form-control" id="amount_due_kh" disabled>
                                </div>
                                <span>(៛_KHR)</span>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="amount_paid">Amount_Paid: ($_USD)</label>
                                <div class="col-sm-3">          
                                <input type="text" class="form-control" id="amount_paid" value="0">
                                </div>
                                <div class="col-sm-3">          
                                    <input type="text" class="form-control" id="amount_paid_kh" value="0">
                                </div>
                                <span>(៛_KHR)</span>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="balance">Balance: ($_USD)</label>
                                <div class="col-sm-3">          
                                <input type="text" class="form-control" id="balance" disabled>
                                </div>
                                <div class="col-sm-3">          
                                    <input type="text" class="form-control" id="balance_kh" disabled>
                                </div>
                                <span>(៛_KHR)</span>
                            </div>
                            <div style="float:right;">
                                <input type="checkbox" id="print_invoice" name="print_invoice" value="1">
                                <label for="print_invoice"> Print Invoice</label><br>
                                <input type="checkbox" id="print_delivery" name="print_delivery" value="2">
                                <label for="print_delivery"> Print Delivery Card</label>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="paid">Paid</button>
                    <button type="button" class="btn btn-warning" id="debt">Debt</button>
                </div>
            </div>
            
        </div>
    </div>
    <!-- End Payment Modal -->

    <div class="modal fade modal-poduct" id="product_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-list-add"></i> Add New Product</h4>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <h2>Product Info</h2>
                        <form class="form-horizontal" action="">
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="new_product_name">New_Product_name</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="new_product_name">
                                </div>
                            </div>
                            
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="save_product">Save</button>
                </div>
            </div>
        </div>
    </div>
@stop

@section('javascript')
    <script>
        
        var pro_i = 1;
        var pro_list = [];

        function remove_item(div_id){
            $('#div_row'+div_id).remove();
            pro_i -= 1;
            $('.no_index').each(function(index, value) {
                var new_index = index + 1;
                $(this).text(new_index);
            });
            var removeItem = div_id;
            pro_list = jQuery.grep(pro_list, function(value) {
            return value != removeItem;
            })
            subtotal();
        };

        $('#add_discount, #add_cupon, #add_delivery_fee').on('click',function(){
            var div_id ='div_'+ $(this).attr('id');
            document.getElementById(div_id).style.display = "inline";
        });

       function clear_cart() {
            if (confirm('Are you sure ! Clear Cart?')) {
                pro_i = 1;
                pro_list = [];
                $('#cart_list').empty();
                $('#discount, #cupon, #delivery_fee, #tax_vat, #subtotal, #grand_total').val(0);
            } else {
                return false;
            }   
       };
       $('.btn_cate').on('click', function(){
            var cate_id = $(this).attr('cate_id');
            if(cate_id == 'all'){
                cate_id = '';
            }
            $("#menu_item div").filter(function() {
                $(this).toggle($(this).attr('cate_id').indexOf(cate_id) > -1)
            });
            $('#search_product').val('');
        });

       $('.id_pro').on('click', function(){
            var id = $(this).attr('id_pro');
            var pro_name = $(this).attr('name_pro');
            var pro_price = $(this).attr('price_pro');
            
            if (pro_i > 1){   
                var condition='';
                condition = pro_list.find(checkID);

                if(condition != id){
                    addlist();
                }else{
                    var qty_id = '#qty'+id;
                    var current_qty = $('#quantity'+id).val();
                    var new_qty = (current_qty - 0 ) + (1-0);
                    $(qty_id).text(new_qty);
                    $('#quantity'+id).val(new_qty);

                    var amount_id = '#amount'+id;
                    var new_amount = (new_qty - 0 ) * ($('#sale_price'+id).val()-0);
                    $(amount_id).text(new_amount);
                }
                
            }else{
                addlist();
            }
            
            function addlist(){
                $('#cart_list').append('<div class="div_row panel-info" id="div_row'+id+'">'+
                                '<div class="panel-heading">'+
                                '<span class="col-sm-1 no_index" id="no_index'+pro_i+'">'+pro_i+'</span>'+
                                '<a style="text-decoration: none; white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" data-toggle="collapse" href="#collapse'+id+'" class="col-sm-6">'+pro_name+'</a>'+   
                                '<span class="col-sm-2 qty_row" id="qty'+id+'">1</span>'+
                                '<span class="col-sm-2 amount_row" id="amount'+id+'">'+pro_price+'</span>'+
                                '<button onclick="remove_item('+id+')" id="remove'+id+'" class="glyphicon glyphicon-remove-sign"></button>'+
                                '</div>'+
                                '<div id="collapse'+id+'" class="panel-collapse collapse">'+
                                '<div class="input-group">'+
                                '<span class="input-group-addon">Quantities</span>'+
                                '<input id="quantity'+id+'" type="number" class="form-control qty" value="1" name="quantity">'+
                                '<span class="input-group-addon">Sale price ($)</span>'+
                                '<input id="sale_price'+id+'" type="number" class="form-control price" value="'+pro_price+'" disabled>'+
                                '<span class="input-group-addon">Discount (%) </span>'+
                                '<input id="discount'+id+'" type="number" class="form-control discount" value="0" name="discount">'+
                                '</div></div></div>');
                pro_list.push(id);
                pro_i +=1;
                
            }
            function checkID(result) {
                return result == id;
            }
            $('.qty, .discount').on('input',function(){
                // console.log(qty);
                var get_id = (this.id).slice(8);
                var price_id = '#sale_price'+get_id;
                var price = $(price_id).val();
                var dis_id = '#discount'+get_id;
                
                var total_price = 0;
                var quantity_id = '#quantity'+get_id;
                var quantity = $(quantity_id).val();
                var discount = ($(dis_id).val()/100) * (price * quantity);
                var qty_id = '#qty'+get_id;
                $(qty_id).text(quantity);
                
                var total_price = (price * quantity) - discount;
                var amount_id = '#amount'+get_id;
                $(amount_id).text(total_price);
                subtotal();
            });

            subtotal();

        });
        $('#search_product').on('input', function(){
            var search = $(this).val().toLowerCase();
            $("#menu_item div").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(search) > -1)
            });
        });
        
        $('#discount , #cupon, #tax_vat, #delivery_fee').on('input', function(){
            subtotal();
        });
        $('#search_product').on('keypress',function(e) {
            var search_code = $(this).val().toLowerCase();
            if(e.which == 13) {//13 is key enter
                var product_arr = @php echo $products @endphp;
                var product_code = product_arr.filter( function(product_arr){
                    var arr_pro_code = (product_arr.product_code).toLowerCase();
                    return (arr_pro_code==search_code);
                });
                if(product_code != ''){
                    var pro_id = '#pro_id_' + product_code[0]['id'];
                    product_code = (product_code[0]['product_code']).toLowerCase();
                    if(search_code == product_code){//if search box is a correct barcode
                        $(pro_id).click();
                        $(this).val('');//clear search box
                        var search = $(this).val().toLowerCase();
                        $("#menu_item div").filter(function() {
                            $(this).toggle($(this).text().toLowerCase().indexOf(search) > -1)
                        });
                    }
                }else{
                        alert("Product not found!");
                    }
                
            }
        });
        function subtotal(){
            //subtotal
            var total_amount = 0;
            var total_qty = 0;
            var discount = 0;
            var cupon = 0;
            var delivery_fee = 0;
            var tax_vat = 0;
            $(".amount_row").filter(function() {
                total_amount += ($(this).text()-0);
            });
            $('#subtotal').val(total_amount);
            discount = ($('#discount').val() * total_amount) / 100;
            cupon = $('#cupon').val() - 0;
            delivery_fee = $('#delivery_fee').val() - 0;
            tax_vat = ($('#tax_vat').val() * total_amount) / 100;
            $('#grand_total').val(total_amount - discount - cupon + delivery_fee + tax_vat);
            // $(".qty_row").filter(function() {
            //     total_qty += ($(this).text()-0);
            // });
        };
        


        $('document').ready(function () {

        });
        
    </script>
@stop
