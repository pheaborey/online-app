@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
    $userId = Auth::id();
    $rate_visa = DB::table('currencies')->select('rate','symbol')->where('short_name','VCF')->first();
    $rate_tax = DB::table('currencies')->select('rate','symbol')->where('short_name','VAT')->first();

    $hold_cart = DB::table('hold_carts')->where('cart_type','purchase')->select('created_at')->groupBy('created_at')->get();
    $products = DB::table('Products')
                // ->join('product_stocks', 'products.id', '=', 'product_stocks.product_id')
                ->join('products_types', 'products.product_type', '=', 'products_types.id')
                ->select('products.id','product_code','product_name','product_image','product_type')->get();
    $suppliers = DB::table('suppliers')->select('id','supplier_name','address','contact')->get();
    $categories = DB::table('products_types')->select('id','type_name')->get();
    
    $hold_option ='';
    $supplier_option ='';
    $option ='';
    $purchase_record = DB::table('purchase_records')
                        ->select('purchase_id','product_id','quantity','cost','sale_price','cost_amount','created_at')
                        ->get();
    $purchase = DB::table('purchases')->select('*')->get();
    $tr = '';
    if ($edit == "") {//$edit is a general variable of voyarger for check edit or add
        // echo "Add";
        $purchase_id = DB::table('purchases')->select('id')->latest('id')->first();
        if($purchase_id != NULL){
            $purchase_no = $purchase_id->id +1;
        }else{
            $purchase_no = 0;
        }
        $src_url = '../../public/storage/';
    }else{
        // echo "Edit".$edit;
        $url = $_SERVER['REQUEST_URI'];
        $values = parse_url($url);
        $host = explode('/edit',$values['path']);//cut end
        $host2 = explode('purchases',$values['path']);//cut begin
        $edit = substr($host[0],(strlen($host2[0])+10));//select only purchase id
        $purchase = DB::table('purchases')->select('*')->where('id',$edit)->get();
        $purchase_record = DB::table('purchase_records')
                        ->select('purchase_id','product_id','quantity','sale_price','cost','cost_amount','created_at')
                        ->where('purchase_id',$edit)->get();
        $purchase_no = $edit;
        $src_url = '../../../public/storage/';
    }
    $menu = '';
    foreach ($products as $key=>$item){
        $option .= '<option value="'. $item->id .'">'. $item->product_name . '</option>';
        $menu .='<div id="pro_id_'.$item->id.'" class="col-sm-2 btn id_pro" cate_id="'.$item->product_type.'" id_pro="'.$item->id.'" name_pro="'.$item->product_name.'" price_pro = "0">'.
                    '<img src="'.$src_url.''.$item->product_image.'" style="width:100%; height:170px;">'.
                    '<span class="caption">'.
                    '<p style="font-size:11px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;text-align:center">'. $item->product_name . '</p>'.
                    '</span></div>';
    }
    foreach ($suppliers as $item){
        $supplier_option .= '<option value="'. $item->id .'">'. $item->supplier_name .' - '.$item->address.' - '.$item->contact. '</option>';
    }
    foreach ($hold_cart as $key => $value) {
        $hold_option .= '<option value="'. $value->created_at .'"> Cart No.'.$value->created_at. '</option>';
    }
    $option_btn = '<li><button class="btn_cate" cate_id = "all">All Categories</button></li>';
    $product_type = '';
    foreach ($categories as $key=>$item){
        $option_btn .= '<li><button class="btn_cate" cate_id = "'. $item->id .'">'.$item->type_name.'</button></li>';
        $product_type .='<option value="'.$item->id.'">'.$item->type_name.'</option>';
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
        .bg-color{background-color:rgb(81, 96, 230);color:white;border-radius:3px;}
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
                            <input id="search_product" type="text" class="form-control" style="border: 1px solid rgb(81, 96, 230);border-radius:5px;" placeholder="Find the product name or Enter the Barcode">
                        <!-- </div> -->
                    </th>
                    <th>
                        <select name="select_supplier" class="selectpicker" id="select_supplier" data-live-search="true">
                            @php echo $supplier_option @endphp   
                        </select>
                        <button class="btn-xs btn-warning" id="btn-addNewSup"><span class="voyager-plus"> Add Supplier</span></button>
                        <button class="btn-xs btn-warning" id="btn-addNewPro"><span class="voyager-plus"> Add Product</span></button>
                        <button onclick="clear_cart(0);" class="btn-xs btn-danger" id="btn-reload"><span class="voyager-trash"> Clear Cart</span></button>
                    </th>
                </tr>
            </thead>
            <tbody id="myTable">
                <tr>
                    <td width=70%>
                        <span class="menu_scroll" id="menu_item">
                            <?php echo $menu;?>
                        </span>
                    </td>
                    <td id="td_cart" style="border: 1px solid black;">
                        <span class="col-sm-1 bg-color">No.</span>
                        <span class="col-sm-5 bg-color">Product Name</span>
                        <span class="col-sm-2 bg-color">QTY</span>
                        <span class="col-sm-3 bg-color">Total Cost</span>
                        <span class="col-sm-1 bg-color">...</span>
                        <span id="cart_list" class="item_scroll">
                            <!-- data will show here -->
                        </span>
                        <div style="background-color:rgb(81, 96, 230); color:white;border-radius:5px; text-align:center;">
                            <label> <span class="glyphicon glyphicon-plus-sign"></span></label>
                            <span class="btn" id="add_discount">Discount(%)</span>
                            <span class="btn" id="add_visa_fee">VisaCard Fee(%)</span>
                            <span class="btn" id="add_forwarder_fee">Forwarder Fee($)</span>
                            <span class="btn" id="add_tax_vat">Tax VAT(%)</span>
                        </div>
                            
                        <div class="space"></div>
                        <div class="form-group" id="div_add_date">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Date:</label>
                            <div class="col-sm-8">
                                <input type="date" class="form-control" id="purchase_date" value="<?php echo date("Y-m-d");?>">
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
                        
                        <div class="form-group" id="div_add_freight_fee">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Freight Fee ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="freight_fee" value=0>
                            </div>  
                        </div>
                        <div class="form-group" id="div_add_visa_fee" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">VisaCard Fee (<?php echo $rate_visa->rate ?>%):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="visa_fee" value=0>
                            </div>  
                        </div>
                        <div class="form-group" id="div_add_forwarder_fee" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Forwarder Fee ($):</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="forwarder_fee" value=0>
                            </div>  
                        </div>
                        <div class="form-group" id="div_add_tax_vat" style="display:none;">
                            <div style="height:20px;"></div>
                            <label class="col-sm-4 col-form-label">Tax VAT (<?php echo $rate_tax->rate ?>%):</label>
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
                            <button class="btn btn-warning" id="btn-hold"><span class="glyphicon glyphicon-download"> Hold Cart</span></button>
                            <button class="btn btn-warning" id="btn-select_hold"><span class="glyphicon glyphicon-download"> Select Hold Cart</span></button>
                        </div>
                        <div class="col-md-6">
                            <button class="btn btn-success" id="btn-place-order" style="float:right;"><span class="glyphicon glyphicon-check"> Place Order</span></button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')

{{-- Start Modal New supplier --}}
<div class="modal fade modal-supplier" id="modal-supplier">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="voyager-list-add"></i> Add New supplier</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h2>supplier Info</h2>
                    <form class="form-horizontal" action="">
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_supplier_name">supplier name</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_supplier_name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_address">supplier address</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_address">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_contact">supplier contact</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_contact">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="save_supplier">Save</button>
            </div>
        </div>
    </div>
</div>
{{-- End  modal new supplier --}}

{{-- Start Modal New product --}}
<div class="modal fade modal-product" id="modal-product">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="voyager-list-add"></i> Add New product</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h2>product Info</h2>
                    <form class="form-horizontal" action="">
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_product_code">product code</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_product_code">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_product_name">product name</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="new_product_name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="new_product_type">product type</label>
                            <div class="col-sm-8">
                                <select class="form-control selectpicker" id="select_product_type">
                                    <?php echo $product_type; ?>
                                </select>
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
{{-- End  modal new product --}}

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
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="amount_due" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="amount_paid">Amount_Paid: ($_USD)</label>
                            <div class="col-sm-8">          
                            <input type="text" class="form-control" id="amount_paid" value="0">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="balance">Balance: ($_USD)</label>
                            <div class="col-sm-8">          
                            <input type="text" class="form-control" id="balance" readonly>
                            </div>
                        </div>
                        <div align='center'>
                            <input type="checkbox" id="print_receipt" name="print_receipt" value="3">
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

{{-- receipt print --}}
<div id="receipt_print" style="border: black solid 1px; display:none" class="container">
    <div class="container">
        <div class="col-xs-6">
            <h3>{{setting('admin.company_name')}}</h3>
            <p>Address: {{setting('admin.company_address')}}</p>
            <p>Contact: {{setting('admin.company_contact')}}</p>
        </div>
        <div class="col-xs-6" align="right">
            <p class="purchase_no">Receipt No: <?php echo $purchase_no ?> </p>
            <p class="purchase_date"> Date : ..................</p>
            <p class="supplier"> supplier : ..................</p>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Description</th>
                    <th>QTY</th>
                    <th>Cost</th>
                    <th>Price</th>
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
                        <p>Freight Fee($):</p>
                        <p>Visa Fee(<?php echo $rate_visa->rate ?>%):</p>
                        <p>Tax VAT(<?php echo $rate_tax->rate ?>%)</p>
                        <p>Forwarder Fee($):</p>
                        <p>Amount due:</p>
                    </td>
                    <td class="td_record_print">
                    </td>
                    
                </tr>
                <tr>
                    <td colspan="5">Note Everything!</td>
                </tr>
            </tfoot>
        </table>
    </div>
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
        var myCurrency = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
        $('#add_discount, #add_forwarder_fee, #add_visa_fee, #add_tax_vat').on('click',function(){
            var div_id ='div_'+ $(this).attr('id');
            document.getElementById(div_id).style.display = "inline";
            var total = ($('#subtotal').val()-0) + ($('#freight_fee').val()-0);
            var discount = total * ($('#discount').val()/100);
            if(div_id == 'div_add_visa_fee'){
                var rate_visa = @php echo $rate_visa->rate @endphp;
                $('#visa_fee').val(((total-discount) * (rate_visa/100)).toFixed(2));
            }
            if(div_id == 'div_add_tax_vat'){
                var rate_tax = @php echo $rate_tax->rate @endphp;
                $('#tax_vat').val(((total-discount) * (rate_tax/100)).toFixed(2));
            }
            subtotal();
        });

       function clear_cart(force) {
            if (force==0){
                if (confirm('Are you sure ! Clear Cart?')) {
                    pro_i = 1;
                    pro_list = [];
                    $('#cart_list').empty();
                    $('#discount, #forwarder_fee, #freight_fee, #tax_vat, #subtotal, #grand_total').val(0);
                } else {
                    return false;
                }   
            }else{
                pro_i = 1;
                pro_list = [];
                $('#cart_list').empty();
                $('#discount, #forwarder_fee, #freight_fee, #tax_vat, #subtotal, #grand_total').val(0);
            }
            subtotal();
       };
       $('#btn-addNewSup').on('click', function(){
            $('#modal-supplier').modal('show');
       });
       $('#btn-addNewPro').on('click', function(){
            $('#modal-product').modal('show');
       });
       $('#save_product').on('click', function(){
            var product_name = $('#new_product_name').val();
            var product_code = $('#new_product_code').val();
            var product_type = $('#select_product_type').val();
            var product_image = '../../public/storage/no_image.png';
            $('#modal-product').modal('hide');
            var url = '{{ url('createproduct') }}';
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    product_code:product_code,
                    product_name:product_name,
                    product_type:product_type
                },
            success:function(response){
                if(response.success){
                    var product_id = response.product_id;
                    $('#menu_item').append('<div id="pro_id_'+product_id+'" class="col-sm-2 btn id_pro" cate_id="'+product_type+'" id_pro="'+product_id+'" name_pro="'+product_name+'" price_pro = "0">'+
                    '<img src="'+product_image+'" style="width:100%;height:170px;">'+
                    '<span class="caption">'+
                    '<p style="font-size:11px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;text-align:center">'+product_name+'</p>'+
                    '</span></div>');
                    $('#modal-product').modal('hide');
                    toastr.success(response.message,"Create New Product");
                    $('#new_product_name').val('');
                    $('#new_product_code').val('');
                    $('#select_product_type').val(1);
                }
            },
            error:function(error){
                console.log(error)
            }
            });
        });
       $('#save_supplier').on('click', function(){
            var supplier_name = $('#new_supplier_name').val();
            var supplier_address = $('#new_address').val();
            var supplier_contact = $('#new_contact').val();
            var url = '{{ url('createsupplier') }}';
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    supplier_name:supplier_name,
                    supplier_address:supplier_address,
                    supplier_contact:supplier_contact
                },
            success:function(response){
                if(response.success){
                    var supplier_id = response.supplier_id;
                    $('#select_supplier').append('<option value="'+supplier_id+'">'+supplier_name+' - '+supplier_address+' - '+supplier_contact+'</option>');
                    $('select[name=select_supplier]').val(supplier_id);
                    $('.selectpicker').selectpicker('refresh');
                    $('#modal-supplier').modal('hide');
                    toastr.success(response.message,"Create New supplier");
                    $('#new_supplier_name').val('');
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
                                '<a id="product_id'+id+'" style="text-decoration: none; white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" data-toggle="collapse" href="#collapse'+id+'" class="col-sm-5 pro_row">'+pro_name+'</a>'+   
                                '<span class="col-sm-2 qty_row" id="qty'+id+'">1</span>'+
                                '<span class="col-sm-3 amount_row" id="amount'+id+'">'+0+'</span>'+
                                '<button onclick="remove_item('+id+')" id="remove'+id+'" class="glyphicon glyphicon-remove-sign"></button>'+
                                '</div>'+
                                '<div id="collapse'+id+'" class="panel-collapse collapse">'+
                                '<div class="input-group">'+
                                '<span class="input-group-addon">QTY</span>'+
                                '<input id="quantity'+id+'" type="number" class="form-control qty" value="1" name="quantity">'+
                                '<span class="input-group-addon">Cost</span>'+
                                '<input id="cost'+id+'" type="number" class="form-control cost" value="0" name="cost">'+
                                '<span class="input-group-addon" style="display:none">Sale price</span>'+
                                '<input id="sale_price'+id+'" type="number" class="form-control price" placeholder="Blank is OK" style="display:none">'+
                                '</div></div></div>');
                pro_list.push(id);
                pro_i +=1;
                
            }
            function checkID(result) {
                return result == id;
            }
            $('.qty, .cost').on('input',function(){
                var id_len = 0;
                if(this.id.length>=8){
                    id_len = 8;
                }else{
                    id_len = 4;
                }
                
                var get_id = (this.id).slice(id_len);
                var cost_id = '#cost'+get_id;
                var cost = $(cost_id).val();
                // console.log(get_id);
                // var dis_id = '#discount'+get_id;
                
                var total_price = 0;
                var quantity_id = '#quantity'+get_id;
                var quantity = $(quantity_id).val()-0;
                // var discount = ($(dis_id).val()/100) * (price * quantity);
                var qty_id = '#qty'+get_id;
                $(qty_id).text((quantity-0).toFixed(0));
                
                var total_cost = (cost * quantity);
                var amount_id = '#amount'+get_id;
                $(amount_id).text(total_cost.toFixed(2));
                subtotal();
            });

            subtotal();

        });
    $('#amount_paid').on('input', function(){
        var amount_due = $('#amount_due').val()-0;
        var amount_paid = $('#amount_paid').val()-0;
        if((amount_paid) >= (amount_due)){
            $('#paid').show();
            $('#debt').hide();
        }else{
            $('#paid').hide();
            $('#debt').show();
        }
        $('#balance').val(amount_paid-amount_due);
    });
        $('#search_product').on('input', function(){
            var search = $(this).val().toLowerCase();
            $("#menu_item div").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(search) > -1)
            });
        });
        
        $('#discount , #forwarder_fee, #tax_vat, #freight_fee, #visa_fee').on('input', function(){
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
            // var tax_vat = @php echo $rate_tax->rate; @endphp;
            $(".amount_row").filter(function() {
                total_amount += ($(this).text()-0);
            });
            $('#subtotal').val(total_amount.toFixed(2));
            var discount = ($('#discount').val() * total_amount) / 100;
            var visa_fee = $('#visa_fee').val() - 0;
            var freight_fee = $('#freight_fee').val() - 0;
            var tax_vat = $('#tax_vat').val() - 0;
            var forwarder_fee = $('#forwarder_fee').val() - 0;
            
            $('#grand_total').val((total_amount - discount + visa_fee + freight_fee + tax_vat + forwarder_fee).toFixed(2));

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
            var cart_list = @php $cart = DB::table('hold_carts')->select('product_id','unit_price','cost','quantity','amount','created_at')->get(); echo $cart @endphp;
            var new_cart_list = cart_list.filter(function(cart_list){ return (cart_list.created_at==cart_select);});
            
            $.each(new_cart_list, function( index, value ) {
                var pro_id = '#pro_id_'+value['product_id'];
                $(pro_id).click();

                var qty_id = '#quantity'+value['product_id'];
                $(qty_id).val(value['quantity']);
                var span_qty = '#qty'+value['product_id'];
                $(span_qty).text(value['quantity']);

                var cost_id = '#cost'+value['product_id'];
                $(cost_id).val(value['cost']);

                var span_amount = '#amount'+value['product_id'];
                $(span_amount).text(value['amount']);
            });
            subtotal();
        });

        $('#remove_hold').on('click', function(){
            var cart_no = $('#select-hold-cart').val();
            var url = '{{ url('holdpurchasedelete') }}';
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
                    sr.cost = row.find("input:eq(2)").val();
                    sr.amount = row.find("span:eq(2)").text();
                    hold_carts.push(sr);
                });
                var url = '{{ url('holdpurchaseinsert') }}';
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
        
        $('#btn-place-order').on('click', function(){
            if(pro_i>1){
                $('#paid').hide();
                $('#debt').show();
                $('#modal-payment').modal('show');
                $('#amount_due').val($('#grand_total').val());
                $('#balance').val(0-($('#grand_total').val()));
            }else{
                toastr.error("No product in your cart!");
            }
            
        });

        $('#paid, #debt').on('click', function(){
            
            $(".qty_row").filter(function() {
                total_qty += ($(this).text()-0);
            });
            var subtotal = $('#subtotal').val();
            var discount = $('#discount').val();
            var forwarder_fee = $('#forwarder_fee').val();
            var freight_fee = $('#freight_fee').val();
            var visa_fee = $('#visa_fee').val();
            var tax_vat = $('#tax_vat').val();
            var amount_due = $('#grand_total').val();
            var purchase_date = $('#purchase_date').val();
            var purchase_records = new Array();
            $('.tbody_record_print').empty();
            $('.td_record_print').empty();
            $("#cart_list .div_row").each(function(index) {
                var row = $(this);
                var sr = {};
                sr.product_id = row.find("a:eq(0)").attr('id').slice(10);
                sr.quantity = row.find("span:eq(1)").text();
                sr.sale_price = row.find("input:eq(2)").val();
                sr.cost = row.find("input:eq(1)").val();
                sr.amount = row.find("span:eq(2)").text();
                purchase_records.push(sr); 
                $('.tbody_record_print').append(
                    '<tr><td>'+((index-0)+1)+'</td>'+
                        '<td>'+ row.find("a:eq(0)").text() +'</td>'+
                        '<td>'+sr.quantity+'</td>'+
                        '<td>'+sr.unit_price+'</td>'+
                        '<td>'+sr.cost+'</td>'+
                        '<td>'+sr.amount+'</td>'+
                    '</tr>'
                );
            });
            $('.td_record_print').append(
                '<p>'+ subtotal +'</p>'+
                '<p>'+ discount +'</p>'+
                '<p>'+ freight_fee +'</p>'+
                '<p>'+ visa_fee +'</p>'+
                '<p>'+ tax_vat +'</p>'+
                '<p>'+ forwarder_fee +'</p>'+ 
                '<p>'+ amount_due +'</p>'
            );
            $('.amount_due_inv').text(amount_due);
            var supplier = $("#select_supplier option:selected").text();
            $('.purchase_date').text('Purchase Date: '+purchase_date);
            $('.supplier').text('supplier: '+supplier);
            // // console.log('<?php echo $edit ?>');
            var url = '{{ url('purchaseinsert') }}';
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    id_update: '<?php echo $edit ?>',
                    purchase_date:$('#purchase_date').val(),
                    supplier_id:$('#select_supplier').val(),
                    total_qty:total_qty,
                    amount:$('#subtotal').val(),
                    purchaser:'<?php echo $userId ?>',
                    freight_fee:$('#freight_fee').val(),
                    discount:$('#discount').val(),
                    forwarder_fee:$('#forwarder_fee').val(),
                    visa_fee:$('#visa_fee').val(),
                    tax_vat:$('#tax_vat').val(),
                    net_amount:$('#grand_total').val(),
                    balance:$('#balance').val(),
                    purchase_record_arr:purchase_records
                },
            success:function(response){
                if(response.success){
                    toastr.success(response.message,"Purchase data!");
                    $('#modal-payment').modal('hide');
                    clear_cart(1);
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
                var edit_list = @php $cart = DB::table('purchases')
                                        ->join('purchase_records', 'purchases.id', '=', 'purchase_records.purchase_id')
                                        ->select('supplier_id','purchases.discount as total_discount','tax_vat','freight_fee','purchase_date','purchase_records.*')
                                        ->where('purchases.id','=',$edit)->get(); 
                                echo $cart @endphp;

                $('#discount').val(edit_list[0]['total_discount']);
                // $('#cupon').val(edit_list[0]['cupon']);
                $('#tax_vat').val(edit_list[0]['tax_vat']);
                $('#freight_fee').val(edit_list[0]['freight_fee']);
                $('#purchase_date').val(edit_list[0]['purchase_date']);
                $('#select_supplier').val(edit_list[0]['supplier_id']);
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
                console.log(edit_id);
            }
            subtotal();
        });
        
    </script>
@stop
