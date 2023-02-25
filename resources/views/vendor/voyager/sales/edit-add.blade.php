@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
    $userId = Auth::id();
    $rate_kh = DB::table('currencies')->select('rate','symbol')->where('id','1')->first();
    $rate_tax = DB::table('currencies')->select('rate','symbol')->where('short_name','VAT')->first();

    $hold_cart = DB::table('hold_carts')->select('created_at')->groupBy('created_at')->get();
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
        $src_url = '../../public/storage/';
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
        $invoice_no = $edit;
        $src_url = '../../../public/storage/';
    }
    $menu = '';
    foreach ($products as $key=>$item){
        $option .= '<option value="'. $item->id .'">'. $item->product_name . '</option>';
        $menu .='<div id="pro_id_'.$item->id.'" class="col-sm-2 btn id_pro" cate_id="'.$item->product_type.'" id_pro="'.$item->id.'" name_pro="'.$item->product_name.'" price_pro = "'.$item->sale_price.'">'.
                    '<img src="'.$src_url.''.$item->product_image.'" style="width:100%;">'.
                    '<span class="caption">'.
                    '<p style="font-size:11px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;text-align:center">'. $item->product_name . '</p>'.
                    '</span></div>';
    }
    foreach ($customers as $item){
        $customer_option .= '<option value="'. $item->id .'">'. $item->customer_name .' - '.$item->address.' - '.$item->contact. '</option>';
    }
    foreach ($hold_cart as $key => $value) {
        $hold_option .= '<option value="'. $value->created_at .'"> Cart No.'.$value->created_at. '</option>';
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
                        <select name="select_customer" class="selectpicker" id="select_customer" data-live-search="true">
                            @php echo $customer_option @endphp   
                        </select>
                        <button class="btn-xs btn-warning" id="btn-addNewCus"><span class="voyager-plus"> Add New</span></button>
                        <button onclick="clear_cart(0);" class="btn-xs btn-danger" id="btn-reload"><span class="voyager-trash"> Clear Cart</span></button>
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
                            <span class="btn" id="add_date">Date</span>
                        </div>
                            
                        <div class="space"></div>
                        <div class="form-group" id="div_add_date" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Date:</label>
                            <div class="col-sm-8">
                                <input type="date" class="form-control" id="sale_date" value="<?php echo date("Y-m-d");?>">
                            </div>  
                        </div>
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
                            <label class="col-sm-4 col-form-label">VAT (<?php echo $rate_tax->rate . $rate_tax->symbol ?>):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="tax_vat" value=0 readonly>
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
                            <button class="btn btn-warning" id="btn-hold"><span class="glyphicon glyphicon-download"> Hold Cart</span></button>
                            <button class="btn btn-warning" id="btn-select_hold"><span class="glyphicon glyphicon-download"> Select Hold Cart</span></button>
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

{{-- Start Modal New Customer --}}
<div class="modal fade modal-customer" id="modal-customer">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="voyager-list-add"></i> Add New Customer</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h2>Customer Info</h2>
                    <form class="form-horizontal" action="">
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_customer_name">Customer name</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_customer_name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_address">Customer address</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_address">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_contact">Customer contact</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_contact">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="save_customer">Save</button>
            </div>
        </div>
    </div>
</div>
{{-- End  modal new customer --}}

{{-- Start Modal Hold Cart --}}
<div class="modal fade modal-hold-cart" id="modal-hold-cart">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="voyager-list-add"></i> Select Hold Carts</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h2>Hold Cart Info</h2>
                    <select id="select-hold-cart" name="select-hold-cart" class="selectpicker form-control">
                        @php
                            echo $hold_option;
                        @endphp
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="remove_hold">Remove hold</button>
                <button type="button" class="btn btn-primary" id="add_to_cart">Add to cart</button>
            </div>
        </div>
    </div>
</div>
{{-- End  modal Hold Cart --}}

{{-- Start modal payment --}}
<div class="modal fade modal-payment" id="modal-payment">
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
                            <input type="text" class="form-control" id="amount_due" readonly value="<?php  ?>">
                            </div>
                            <div class="col-sm-3">
                            <input type="text" class="form-control" id="amount_due_kh" readonly>
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
                            <input type="text" class="form-control" id="balance" readonly>
                            </div>
                            <div class="col-sm-3">          
                                <input type="text" class="form-control" id="balance_kh" readonly>
                            </div>
                            <span>(៛_KHR)</span>
                        </div>
                        <div align='center'>
                            <input type="checkbox" id="print_invoice" name="print_invoice" value="1">
                            <label for="print_invoice"> Print Invoice</label>
                            <input type="checkbox" id="print_delivery" name="print_delivery" value="2">
                            <label for="print_delivery"> Print Delivery Card</label>
                            <input type="checkbox" id="print_receipt" name="print_receipt" value="3" checked>
                            <label for="print_receipt"> Print Receipt</label>
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
<!-- End modal payment -->

{{-- invoice print --}}
<div id="invoice_print" style="border: black solid 1px; display:none" class="container">
    <div class="container">
        <h2>{{setting('admin.company_name')}}</h2>
        <p>Address: {{setting('admin.company_address')}}</p>
        <p>Contact: {{setting('admin.company_contact')}}</p>
        <p>Bank Account:{{setting('admin.company_bank_account')}}</p>
        <p><strong>Billed to : </strong> </p>
        <div class="col-xs-6">
            <p class="customer">................Customer name here.............</p>
        </div>
        <div class="col-xs-6" align="right">
            <p class="invoice_no">Invoice number: <?php echo $invoice_no ?> </p>
            <p class="invoice_date"> Invoice date : ..................</p>
            <p class="due_date"> Due date : <?php echo date('Y-m-d') ?></p>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Unit price</th>
                    <th>Discount</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody class="tbody_record_print">
                <tr>
                    <td>1</td>
                    <td>Anna</td>
                    <td>Pitt</td>
                    <td>35</td>
                    <td>New York</td>
                    <td>USA</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Anna</td>
                    <td>Pitt</td>
                    <td>35</td>
                    <td>New York</td>
                    <td>USA</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4"></td>
                    <td>
                        <p>Subtotal:</p>
                        <p>Discount(%):</p>
                        <p>Cupon($):</p>
                        <p>Delivery Fee($):</p>
                        <p>Tax VAT(10%)</p>
                        <p>Amount due:</p>
                    </td>
                    <td class="td_record_print">
                    </td>
                </tr>
                <tr>
                    <td colspan="4">Signature</td>
                    <td>Date</td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>

{{-- receipt print --}}
<div id="receipt_print" style="border: black solid 1px; display:none" class="container">
    <div class="container">
        <div class="col-xs-6">
            <h3>{{setting('admin.company_name')}}</h3>
            <p>Address: {{setting('admin.company_address')}}</p>
            <p>Contact: {{setting('admin.company_contact')}}</p>
        </div>
        <div class="col-xs-6" align="right">
            <p class="invoice_no">Receipt No: <?php echo $invoice_no ?> </p>
            <p class="invoice_date"> Date : ..................</p>
            <p class="customer"> Customer : ..................</p>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Description</th>
                    <th>QTY</th>
                    <th>Price</th>
                    <th>Dis(%)</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody class="tbody_record_print">
                <tr>
                    <td>1</td>
                    <td>Anna</td>
                    <td>Anna</td>
                    <td>35</td>
                    <td>New York</td>
                    <td>USA</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Anna</td>
                    <td>Anna</td>
                    <td>35</td>
                    <td>New York</td>
                    <td>USA</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4"></td>
                    <td>
                        <p>Subtotal:</p>
                        <p>Discount(%):</p>
                        <p>Cupon($):</p>
                        <p>Delivery Fee($):</p>
                        <p>Tax VAT(10%)</p>
                        <p>Amount due:</p>
                    </td>
                    <td class="td_record_print">
                    </td>
                    
                </tr>
                <tr>
                    <td colspan="5">Thanks for your support!</td>
                </tr>
            </tfoot>
        </table>
    </div>
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
        <td>Date: <span id="s_date" class="s_date"><?php echo date('Y-m-d') ?></span></td>
    </tr>
    <tr>
        <td colspan="2"><span id="cus_name" class="customer">...Customer.....</span></td>
    </tr>
    <tr>
        <td colspan="2"><span class="cus_tel" id="cus_tel" style="font-size:14px ;font-weight: bold">....................................</span></td>
    </tr>
    <tr>
        <td colspan="2"> 
            <span id="cus_address" class="cus_address" style="font-size:14px ;font-weight: bold">..................................................................</span>
        </td>
    </tr>
    <tr>
        <td colspan="2">Delivery Fee: $<span class="delivery_fee_inv">....................................</span></td>
    </tr>
    <tr>
        <td colspan="2" style="font-size:14px ;font-weight: bold">Amount Due: $<span class="amount_due_inv">....................................</span></td>
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

@stop

@section('javascript')
    <script>
        
        var pro_i = 1;
        var pro_list = [];
        var total_qty = 0;
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

        $('#add_discount, #add_cupon, #add_delivery_fee, #add_date').on('click',function(){
            var div_id ='div_'+ $(this).attr('id');
            document.getElementById(div_id).style.display = "inline";
        });

       function clear_cart(force) {
            if (force==0){
                if (confirm('Are you sure ! Clear Cart?')) {
                    pro_i = 1;
                    pro_list = [];
                    $('#cart_list').empty();
                    $('#discount, #cupon, #delivery_fee, #tax_vat, #subtotal, #grand_total').val(0);
                } else {
                    return false;
                }   
            }else{
                pro_i = 1;
                pro_list = [];
                $('#cart_list').empty();
                $('#discount, #cupon, #delivery_fee, #tax_vat, #subtotal, #grand_total').val(0);
            }
            subtotal();
       };
       $('#btn-addNewCus').on('click', function(){
            $('#modal-customer').modal('show');
       });
       $('#save_customer').on('click', function(){
            var customer_name = $('#new_customer_name').val();
            var customer_address = $('#new_address').val();
            var customer_contact = $('#new_contact').val();
            var url = '{{ url('createcustomer') }}';
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    customer_name:customer_name,
                    customer_address:customer_address,
                    customer_contact:customer_contact
                },
            success:function(response){
                if(response.success){
                    var customer_id = response.customer_id;
                    $('#select_customer').append('<option value="'+customer_id+'">'+customer_name+' - '+customer_address+' - '+customer_contact+'</option>');
                    $('select[name=select_customer]').val(customer_id);
                    $('.selectpicker').selectpicker('refresh');
                    $('#modal-customer').modal('hide');
                    toastr.success(response.message,"Create New Customer");
                    $('#new_customer_name').val('');
                    $('#new_address').val('');
                    $('#new_contact').val('');
                }
            },
            error:function(error){
                console.log(error)
            }
            });
        });
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
                                '<a id="product_id'+id+'" style="text-decoration: none; white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" data-toggle="collapse" href="#collapse'+id+'" class="col-sm-6 pro_row">'+pro_name+'</a>'+   
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
                        toastr.error("Product not found!","Invalid Barcode");
                    }
                
            }
        });
        function subtotal(){
            //subtotal
            var total_amount = 0;
            var discount = 0;
            var cupon = 0;
            var delivery_fee = 0;
            var tax_vat = @php echo $rate_tax->rate; @endphp;
            $(".amount_row").filter(function() {
                total_amount += ($(this).text()-0);
            });
            $('#subtotal').val(total_amount);
            discount = ($('#discount').val() * total_amount) / 100;
            cupon = $('#cupon').val() - 0;
            delivery_fee = $('#delivery_fee').val() - 0;
            tax_vat = (tax_vat * total_amount) / 100;
            $('#tax_vat').val(tax_vat);
            $('#grand_total').val(total_amount - discount - cupon + delivery_fee + tax_vat);

            if(pro_i>1){
                $('#btn-hold').show();
                $('#btn-select_hold').hide();
            }else{
                $('#btn-hold').hide();
                $('#btn-select_hold').show();
            }
        };
        $('#btn-select_hold').on('click', function(){
            $('#modal-hold-cart').modal('show');
        });
        $('#add_to_cart').on('click', function(){
            $('#modal-hold-cart').modal('hide');
            var cart_select = $('#select-hold-cart').val();
            var cart_list = @php $cart = DB::table('hold_carts')->where('cart_type','sale')->select('product_id','unit_price','quantity','discount','amount','created_at')->get(); echo $cart @endphp;
            var new_cart_list = cart_list.filter(function(cart_list){ return (cart_list.created_at==cart_select);});
            
            $.each(new_cart_list, function( index, value ) {
                var pro_id = '#pro_id_'+value['product_id'];
                $(pro_id).click();

                var qty_id = '#quantity'+value['product_id'];
                $(qty_id).val(value['quantity']);
                var span_qty = '#qty'+value['product_id'];
                $(span_qty).text(value['quantity']);

                var discount_id = '#discount'+value['product_id'];
                $(discount_id).val(value['discount']);

                var span_amount = '#amount'+value['product_id'];
                $(span_amount).text(value['amount']);
            });
            subtotal();
        });

        $('#remove_hold').on('click', function(){
            var cart_no = $('#select-hold-cart').val();
            var url = '{{ url('holdsaledelete') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                    cart_no:cart_no
                    },
                success:function(response){
                    if(response.success){
                        toastr.info(response.message);
                        // clear_cart(1);
                        setTimeout(function(){
                            window.location.reload();
                        }, 900);
                    }
                },
                error:function(error){
                    console.log(error)
                }
            });
        });
        $('#btn-hold').on('click', function(){
            if(pro_i>1){
                var hold_carts = new Array();
                $("#cart_list .div_row").each(function() {
                    var row = $(this);
                    var sr = {};
                    sr.product_id = row.find("a:eq(0)").attr('id').slice(10);
                    sr.quantity = row.find("span:eq(1)").text();
                    sr.unit_price = row.find("input:eq(1)").val();
                    sr.discount = row.find("input:eq(2)").val();
                    sr.amount = row.find("span:eq(2)").text();
                    hold_carts.push(sr);
                });
                var url = '{{ url('holdsaleinsert') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                    hold_cart_arr:hold_carts
                    },
                success:function(response){
                    if(response.success){
                        toastr.success(response.message,"Your cart is saving in hold!");
                        // clear_cart(1);
                        setTimeout(function(){
                            window.location.reload();
                        }, 900);
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });
            }else{
                toastr.error("No product in your cart!");
            }
            
        });
        
        $('#btn-check-out').on('click', function(){
            if(pro_i>1){
                $('#paid').hide();
                $('#debt').show();
                $('#modal-payment').modal('show');
                $('#amount_due').val($('#grand_total').val());
                $('#amount_due_kh').val($('#grand_total').val()*"<?php echo $rate_kh->rate ?>");
                $('#balance').val(0-($('#grand_total').val()));
                $('#balance_kh').val(0-($('#amount_due_kh').val()));
            }else{
                toastr.error("No product in your cart!");
            }
            
        });

        $('#amount_paid, #amount_paid_kh').on('input', function(){
            var amount_due = $('#amount_due').val()-0;
            var amount_paid = $('#amount_paid').val()-0;
            var rate = "<?php echo $rate_kh->rate ?>";
            $('#balance').val(amount_paid-amount_due);
            $('#balance_kh').val($('#balance').val()*rate);
            if((amount_paid) >= (amount_due)){
                $('#amount_paid_kh').attr('readonly','ture');
                $('#amount_paid_kh').val(0);
                $('#paid').show();
                $('#debt').hide();
            }else{
                $('#amount_paid_kh').removeAttr('readonly');
                var condit = ($('#amount_paid_kh').val()-0) + ($('#balance_kh').val()-0);
                if(condit>=0){
                    $('#balance').val(0);
                    $('#paid').show();
                    $('#debt').hide();
                }else{
                    $('#paid').hide();
                    $('#debt').show();
                }
                $('#balance_kh').val(condit);
            }  
        });

        $('#paid, #debt').on('click', function(){
            
            $(".qty_row").filter(function() {
                total_qty += ($(this).text()-0);
            });
            var subtotal = $('#subtotal').val();
            var discount = $('#discount').val();
            var cupon = $('#cupon').val();
            var delivery_fee = $('#delivery_fee').val();
            var tax_vat = $('#tax_vat').val();
            var amount_due = $('#grand_total').val();
            var sale_date = $('#sale_date').val();
            var sale_records = new Array();
            $('.tbody_record_print').empty();
            $('.td_record_print').empty();
            $("#cart_list .div_row").each(function(index) {
                var row = $(this);
                var sr = {};
                sr.product_id = row.find("a:eq(0)").attr('id').slice(10);
                sr.quantity = row.find("span:eq(1)").text();
                sr.unit_price = row.find("input:eq(1)").val();
                sr.discount = row.find("input:eq(2)").val();
                sr.amount = row.find("span:eq(2)").text();
                sale_records.push(sr); 
                $('.tbody_record_print').append(
                    '<tr><td>'+((index-0)+1)+'</td>'+
                        '<td>'+ row.find("a:eq(0)").text() +'</td>'+
                        '<td>'+sr.quantity+'</td>'+
                        '<td>'+sr.unit_price+'</td>'+
                        '<td>'+sr.discount+'</td>'+
                        '<td>'+sr.amount+'</td>'+
                    '</tr>'
                );
            });
            $('.td_record_print').append(
                '<p>'+ subtotal +'</p>'+
                '<p>'+ discount +'</p>'+
                '<p>'+ cupon +'</p>'+
                '<p>'+ delivery_fee +'</p>'+
                '<p>'+ tax_vat +'</p>'+
                '<p>'+ amount_due +'</p>'
            );
            $('.amount_due_inv').text(amount_due);
            var customer = $("#select_customer option:selected").text();
            $('.invoice_date').text('Sale Date: '+sale_date);
            $('.customer').text('Customer: '+customer);
            // // console.log('<?php echo $edit ?>');
            var url = '{{ url('saleinsert') }}';
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    id_update: '<?php echo $edit ?>',
                    sale_date:$('#sale_date').val(),
                    customer_id:$('#select_customer').val(),
                    total_qty:total_qty,
                    amount:$('#subtotal').val(),
                    seller_id:'<?php echo $userId ?>',
                    delivery_fee:$('#delivery_fee').val(),
                    discount:$('#discount').val(),
                    cupon:$('#cupon').val(),
                    tax_vat:$('#tax_vat').val(),
                    net_amount:$('#grand_total').val(),
                    sale_record_arr:sale_records
                },
            success:function(response){
                if(response.success){
                    toastr.success(response.message,"Sale data!");
                    $('#modal-payment').modal('hide');
                    clear_cart(1);
                    if($("#print_invoice").prop('checked') == true){
                        printMe('invoice_print');
                    }
                    if($("#print_delivery").prop('checked') == true){
                        printMe('delivery_print');
                    }
                    if($("#print_receipt").prop('checked') == true){
                        printMe('receipt_print');
                    }
                    if(response.redirect){
                        setTimeout(function(){
                            window.location.href = '../';
                        }, 900);
                    }else{
                        window.location.reload();
                    }
                }
            },
            error:function(error){
                console.log(error)
            }
            });
        });

        $('document').ready(function () {
            var edit_id = '@php echo $edit @endphp';
            if(edit_id>0){
                var edit_list = @php $cart = DB::table('sales')
                                        ->join('sale_records', 'sales.id', '=', 'sale_records.sale_id')
                                        ->select('customer_id','sales.discount as total_discount','tax_vat','delivery_fee','cupon','sale_date','sale_records.*')
                                        ->where('sales.id','=',$edit)->get(); 
                                echo $cart @endphp;

                $('#discount').val(edit_list[0]['total_discount']);
                $('#cupon').val(edit_list[0]['cupon']);
                $('#tax_vat').val(edit_list[0]['tax_vat']);
                $('#delivery_fee').val(edit_list[0]['delivery_fee']);
                $('#sale_date').val(edit_list[0]['sale_date']);
                $('#select_customer').val(edit_list[0]['customer_id']);
                $.each(edit_list, function( index, value ) {
                    var pro_id = '#pro_id_'+value['product_id'];
                    $(pro_id).click();

                    var qty_id = '#quantity'+value['product_id'];
                    $(qty_id).val(value['quantity']);
                    var span_qty = '#qty'+value['product_id'];
                    $(span_qty).text(value['quantity']);

                    var discount_id = '#discount'+value['product_id'];
                    $(discount_id).val(value['discount']);

                    var span_amount = '#amount'+value['product_id'];
                    $(span_amount).text(value['amount']);
                });
            }
            subtotal();
        });
        
    </script>
@stop
