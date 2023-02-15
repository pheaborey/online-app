@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
    $rate_kh = DB::table('currencies')->select('rate','symbol')->where('id','1')->first();

    $hold_sale = DB::table('hold_sales')->select('*')->get();
    $products = DB::table('Products')->select('id','product_name')->get();
    $customers = DB::table('customers')->select('id','customer_name','address','contact')->get();
    
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
    foreach ($products as $key=>$item){
        $option .= '<option value="'. $item->id .'">'. $item->product_name . '</option>';
    }
    foreach ($customers as $item){
        $customer_option .= '<option value="'. $item->id .'">'. $item->customer_name .' - '.$item->address.' - '.$item->contact. '</option>';
    }
    foreach ($hold_sale as $key => $value) {
        $hold_option .= '<option value="'. $value->id .'">'.$value->customer_name.' - Hold '.$value->id. '</option>';
    }
@endphp

@extends('voyager::master')

@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
@stop

@section('page_title', __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular') }}  
    </h1>
    <button type="button" class="btn btn-success" id="btn_addRow" style="margin-right: 20px">Add Row</button>
    <label for="select_customer">Customer</label>
    <select class="selectpicker" id="select_customer" data-live-search="true">
        <option value="new_customer">New Customer</option>
        @php echo $customer_option @endphp   
    </select>
    <span id="span_hold">
        <select class="selectpicker" id="select_hold" data-live-search="true">
            <option value="0">Select Hold</option>
            @php echo $hold_option @endphp
        </select>
        <button class="btn-xs btn-danger" id="btn-delete-hold"><span class="voyager-trash"> Delete Hold</span></button>
    </span>
    <span id="span_btn_hold" style="display: none">
        <button class="btn-xs btn-warning" id="btn-hold"><span class="voyager-download"> Hold Sale</span></button>
    </span>
    
    <span style="float: right; padding-top:43px;">Rate: $1 = <?php echo $rate_kh->rate ." ". $rate_kh->symbol ?></span>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    <div class="page-content edit-add container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered">
                    <!-- form start -->
                    <form role="form"
                            class="form-edit-add"
                            action="{{ $edit ? route('voyager.'.$dataType->slug.'.update', $dataTypeContent->getKey()) : route('voyager.'.$dataType->slug.'.store') }}"
                            method="POST" enctype="multipart/form-data">
                        <!-- PUT Method if we are editing -->
                        @if($edit)
                            {{ method_field("PUT") }}
                        @endif

                        <!-- CSRF TOKEN -->
                        {{ csrf_field() }}
                        
                        <div class="panel-body">
                            
                            <form action="" method="GET" name="form">
                                <div class="hidden" id="current_sale"></div> 
                                <div class="col-sm-4">                   
                                    <input type="text" name="customer_name" class="form-control" placeholder="Customer Name" id="customer_name">
                                </div>
                                <div class="col-sm-4">                   
                                    <input type="text" class="form-control" placeholder="Customer Address" id="customer_address">
                                </div>
                                <div class="col-sm-4" style="padding-bottom:5px;">                   
                                    <input type="text" class="form-control" placeholder="Customer Contact" id="customer_contact">
                                </div>
                                <table class="table-striped" id="sale_table">
                                    <thead style="background-color:skyblue;">
                                    <tr>
                                        <th class="col-sm-1">No.</th>
                                        <th class="col-sm-3">Product_Name</th>
                                        <th class="col-sm-1">Quantity</th>
                                        <th class="col-sm-1">Unit_Price</th>
                                        <th class="col-sm-1">Amount</th>
                                        <th class="col-sm-1">Discount</th>
                                        <th class="col-sm-1">Total_Amount</th>
                                    </tr>
                                    </thead>
                                    <tbody id="sale_tbody">
                                        @php //query get data from table product for select
                                            
                                            for ($x = 1; $x <= $default_row ; $x++) {
                                                echo $tr = '<tr>'.
                                                        '<td> <input type="text" name="no" class="form-control" disabled value="'.$x.'"></td>'.
                                                        '<td>'.
                                                            '<select id="row'.$x.'" class="product_name form-control selectpicker" name="product_name" data-live-search="true">'.
                                                                '<option value="0">Select Product</option>'.
                                                                '<option value="create">Create New</option>'.
                                                                $option.
                                                            '</select>'.
                                                        '</td>'.
                                                        '<td> <input type="text" id="qty'.$x.'" class="qty form-control" placeholder="Type QTY"> </td>'.
                                                        '<td> <input type="text" id="price'.$x.'" class="price form-control" placeholder="Type Price"> </td>'.
                                                        '<td> <input type="text" id="amount'.$x.'" class="amount form-control" disabled> </td>'.
                                                        '<td> <input type="text" id="discount'.$x.'" class="discount form-control" placeholder="Type Discount"> </td>'.
                                                        '<td> <input type="text" id="total_amount'.$x.'" class="total_amount form-control" disabled> </td>'.
                                                    '</tr>';
                                            }
                                            
                                        @endphp
                                        
                                    </tbody>
                                    <thead>
                                        <tr>
                                            <td>&nbsp;</td> <!-- Blank Row-->
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="sale_date" class="col-sm-5">Sale Date</label>
                                                    <div class="col-sm-7">
                                                    <input type="date" class="form-control" id="sale_date" value="<?php echo date('Y-m-d');?>">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="seller" class="col-sm-5">Seller</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="seller" value="{{Auth::user()->name}}" disabled val_id="{{Auth::user()->id}}">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="total_qty" class="col-sm-5">Total Quantities</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="total_qty" disabled>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="delivery_fee" class="col-sm-5">Delivery Fee</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="delivery_fee" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="total_discount" class="col-sm-5">Discount</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="total_discount" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="grand_total" class="col-sm-5">Grand Total</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="grand_total" disabled>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="delivery_expense" class="col-sm-5">Delivery Expense</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="delivery_expense" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="net_amount" class="col-sm-5">Net_Amount</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="net_amount" disabled>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </thead>
                                </table>  
                            </form>

                        </div><!-- panel-body -->

                        <div class="panel-footer">
                            {{-- @section('submit-buttons')
                                <button type="submit" class="btn btn-primary save">{{ __('voyager::generic.save') }}</button>
                            @stop
                            @yield('submit-buttons') --}}
                            <input type="button" class="payment btn btn-primary" id="payment" value="Payment">
                            
                        </div>
                    </form>
                    
                    <iframe id="form_target" name="form_target" style="display:none"></iframe>
                    <form id="my_form" action="{{ route('voyager.upload') }}" target="form_target" method="post"
                            enctype="multipart/form-data" style="width:0;height:0;overflow:hidden">
                        <input name="image" id="upload_file" type="file"
                                 onchange="$('#my_form').submit();this.value='';">
                        <input type="hidden" name="type_slug" id="type_slug" value="{{ $dataType->slug }}">
                        {{ csrf_field() }}
                        
                    </form>
                    
                </div>
            </div>
        </div>
    </div>
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
        var params = {};
        var $file;

        function deleteHandler(tag, isMulti) {
          return function() {
            $file = $(this).siblings(tag);

            params = {
                slug:   '{{ $dataType->slug }}',
                filename:  $file.data('file-name'),
                id:     $file.data('id'),
                field:  $file.parent().data('field-name'),
                multi: isMulti,
                _token: '{{ csrf_token() }}'
            }

            $('.confirm_delete_name').text(params.filename);
            $('#confirm_delete_modal').modal('show');
          };
        }

        $('document').ready(function () {
            var hold_option = '@php echo $hold_option @endphp';
            if(hold_option != ''){
                document.getElementById('span_hold').style.display = "inline";
            }else{
                document.getElementById('span_hold').style.display = "none";
            }

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": true,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };
                        
            var id = '@php echo $edit @endphp';
            if(id!=""){
                document.getElementById('span_hold').style.display = "none";
                var sale = @php echo $sale @endphp;
                var sale_arr = sale.filter( function(sale){return (sale.id==id);} );
                $('#sale_date').val(sale[0]['sale_date']);

                var customer_id = sale[0]['customer_id'];
                var customers = @php echo $customers @endphp;
                var value = customers.filter( function(customers){return (customers.id==customer_id);} );
                $('#customer_name').val(value[0]['customer_name']);
                $('#customer_address').val(value[0]['address']);
                $('#customer_contact').val(value[0]['contact']);
                $('#select_customer').val(customer_id).selectpicker('refreh').trigger('change');

                var sale_record = @php echo $sale_record @endphp;
                var product = @php echo $products @endphp;
                var default_row = '@php echo $default_row @endphp';
                var sale_code = sale_record.filter( function(sale_record){return (sale_record.sale_id==id);} );
                
                for(i=1 ; i <= default_row ; i++){
                    var selected_product = '#row' + i;
                    var price = '#price' + i;
                    var discount = '#discount' + i;
                    var qty = '#qty' + i;
                    var amount = '#amount' + i;
                    var total_amount = '#total_amount' + i;
                    var value = sale_code[i-1]['product_id'];
                    var name = product.filter( function(product){return (product.id==value);} );
                    $(selected_product).val(value);
                    $(qty).val(sale_code[i-1]['quantity']);
                    $(price).val(sale_code[i-1]['unit_price']);
                    $(discount).val(sale_code[i-1]['discount']);
                    $(amount).val(sale_code[i-1]['quantity'] * sale_code[i-1]['unit_price']);
                    $(total_amount).val(sale_code[i-1]['amount']);
                }

                calc_total();
                $('#delivery_fee').val(sale[0]['delivery_fee']);
                $('#delivery_expense').val(sale[0]['forwarder_fee']);
            }
            $('.product_name').selectpicker();
            var i = '@php echo $default_row @endphp' - 0;
            $('#btn_addRow').click(function(){
                $('#sale_table').find('tbody').append('@php echo $tr @endphp'); 
                $('#sale_tbody tr:last input[name=no]').val(i+1);
                i+=1;
                $('.product_name').selectpicker('refresh');
                change();
            })
            change();
            function change(){
                $('.product_name').change(function(){
                    var sale_records = new Array();
                    $("#sale_tbody tr").each(function () {
                        var row = $(this);
                        var sd = {};
                        sd.product_id = row.find("td:eq(1) select").val();
                        if(sd.product_id > 0){
                            sale_records.push(sd);
                        }
                    });
                    if(sale_records.length > 0){
                        document.getElementById('span_btn_hold').style.display = "inline";
                    }else{
                        document.getElementById('span_btn_hold').style.display = "none";
                    }

                    var value = $(this).val();
                    var qty = '';
                    var price = 0;
                    var amount = 0;
                    var discount = 0;
                    var total_amount = 0;
                    if(value == 'create'){
                        $('#product_modal').modal('show');
                    }else{
                        if(value == '0'){
                            qty = '';
                        }else{
                            qty = 1;
                        }
                        
                    }
                    var parent = $(this).closest('tr');
                    var id = parent.find("td:eq(1) select").val();
                    @php $sale_price = DB::table('Product_stocks')->select('sale_price','product_id')->get(); @endphp;
                    var newPrice = @php echo $sale_price @endphp;
                    var getPrice = newPrice.filter( function(newPrice){return (newPrice.product_id==id);} );
                    if(getPrice.length>0){
                        newPrice = getPrice[0]['sale_price'];
                    }else{
                        newPrice = 0;
                    }
                    
                    parent.find("td:eq(2) input").val(qty);
                    price = parent.find("td:eq(3) input").val(newPrice);
                    amount = parent.find("td:eq(4) input").val(price.val()*qty);
                    discount = parent.find("td:eq(5) input").val(0);
                    total_amount = parent.find("td:eq(6) input").val(amount.val()-discount.val());
                    
                    calc_total();
                })
                $('.price , .qty , .discount , #delivery_fee , #total_discount , #delivery_expense').change(function(){
                    var parent = $(this).closest('tr');
                    var qty = parent.find("td:eq(2) input").val();
                    var price = parent.find("td:eq(3) input").val();     
                    var amount = parent.find("td:eq(4) input").val(price*qty);
                    var discount = parent.find("td:eq(5) input").val();
                    var total_amount = parent.find("td:eq(6) input").val(amount.val()-discount);
                    calc_total();
                })
            }
            function calc_total(){
                var sum_amount = 0;
                var sum_qty = 0;
                $(".total_amount").each(function(){
                    sum_amount += ($(this).val()-0);
                });
                $(".qty").each(function(){
                    sum_qty +=($(this).val()-0)
                })
                var grand_total = $('#grand_total').val(sum_amount+($('#delivery_fee').val()-0)-($('#total_discount').val()-0));
                $('#total_qty').val(sum_qty);
                $('#net_amount').val($('#grand_total').val()-$('#delivery_expense').val());
                document.getElementById("amount_due").value = grand_total.val();
                document.getElementById("amount_due_kh").value = grand_total.val()* <?php echo $rate_kh->rate ?>;
                document.getElementById("amount_paid").value = grand_total.val();
                document.getElementById("balance").value = document.getElementById("amount_paid").value - document.getElementById("amount_due").value;
                document.getElementById("balance_kh").value = 0;
            }
            $('#select_hold').on('change',function(){
                var hold_id = $(this).val();
                var product = @php echo $products @endphp;

                var hold_sales = @php echo $hold_sale @endphp;
                
                var hold_sale = hold_sales.filter( function(hold_sales){return (hold_sales.id==hold_id);} );
                if(hold_sale != ''){
                    $('#select_customer').val(hold_sale[0]['customer_code']).selectpicker('refreh').trigger('change');
                    $('#customer_name').val(hold_sale[0]['customer_name']);
                    $('#customer_address').val(hold_sale[0]['customer_address']);
                    $('#customer_contact').val(hold_sale[0]['customer_contact']);
                    $('#total_discount').val(hold_sale[0]['total_discount']);
                    $('#delivery_fee').val(hold_sale[0]['delivery_fee']);
                    $('#delivery_expense').val(hold_sale[0]['delivery_expense']);
                }else{
                    $('#select_customer').val('new_customer').selectpicker('refreh').trigger('change');
                    $('#total_discount').val(0);
                    $('#delivery_fee').val(0);
                    $('#delivery_expense').val(0);
                }

                var hold_records = @php echo DB::table('hold_sale_records')->select('*')->get(); @endphp;
                var hold_record = hold_records.filter( function(hold_records){return (hold_records.sale_code==hold_id);} );
                var default_row = 0;
                var product_option = '@php echo $option @endphp';
                $("#sale_tbody tr").each(function (i) {
                    default_row = i+1;
                })
                var hold_row = hold_record.length;
                if(hold_row > default_row){
                    for(i=1 ; i<= hold_row-default_row ; i++){
                        $('#sale_table').find('tbody').append('<tr>'+
                            '<td> <input type="text" name="no" class="form-control" disabled value="'+parseInt(default_row+i)+'"></td>'+
                            '<td>'+
                                '<select id="row'+parseInt(default_row+i)+'" class="product_name form-control selectpicker" name="product_name" data-live-search="true">'+
                                    '<option value="0">Select Product</option>'+
                                    '<option value="create">Create New</option>'+
                                    product_option +
                                '</select>'+
                            '</td>'+
                            '<td> <input type="text" id="qty'+parseInt(default_row+i)+'" class="qty form-control" placeholder="Type QTY"> </td>'+
                            '<td> <input type="text" id="price'+parseInt(default_row+i)+'" class="price form-control" placeholder="Type Price"> </td>'+
                            '<td> <input type="text" id="amount'+parseInt(default_row+i)+'" class="amount form-control" disabled> </td>'+
                            '<td> <input type="text" id="discount'+parseInt(default_row+i)+'" class="discount form-control" placeholder="Type Discount"> </td>'+
                            '<td> <input type="text" id="total_amount'+parseInt(default_row+i)+'" class="total_amount form-control" disabled> </td>'+
                        '</tr>'); 
                    }
                    $('.product_name').selectpicker('refresh'); 
                }else if(hold_row < default_row){
                    for(i=default_row ; i> hold_row ; i--){
                        var selected_product = '#row' + i;
                        var price = '#price' + i;
                        var discount = '#discount' + i;
                        var qty = '#qty' + i;
                        var amount = '#amount' + i;
                        var total_amount = '#total_amount' + i;
                        $(selected_product).val(0).selectpicker('refresh').trigger('change');
                        $(qty).val(0);
                        $(price).val(0);
                        $(discount).val(0);
                        $(amount).val(0);
                        $(total_amount).val(0);
                    }
                }
                for(i=1 ; i <= hold_row ; i++){
                    var selected_product = '#row' + i;
                    var price = '#price' + i;
                    var discount = '#discount' + i;
                    var qty = '#qty' + i;
                    var amount = '#amount' + i;
                    var total_amount = '#total_amount' + i;
                    var value = hold_record[i-1]['product_id'];
                    var name = product.filter( function(product){return (product.id==value);} );
                    $(selected_product).val(value).selectpicker('refresh').trigger('change');
                    $(qty).val(hold_record[i-1]['quantity']);
                    $(price).val(hold_record[i-1]['unit_price']);
                    $(discount).val(hold_record[i-1]['discount']);
                    $(amount).val(hold_record[i-1]['quantity'] * hold_record[i-1]['unit_price']);
                    $(total_amount).val($(amount).val()-$(discount).val());
                }

                calc_total();
            })
            $('#btn-delete-hold').on('click',function(){
                var url = '{{ url('deleteholdsale') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        delete_id:$('#select_hold').val()
                    },
                success:function(response){
                    if(response.success){
                        toastr.success(response.message,"Hold Sales");
                        location.reload();
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });
            })
            $('#btn-hold').on('click',function(){
                //for Sales;
                var sale_date = $('#sale_date').val();
                var customer_select = $('#select_customer').val();
                var customer_name = $('#customer_name').val();
                var address = $('#customer_address').val();
                var contact = $('#customer_contact').val();
                var delivery_fee = $('#delivery_fee').val();
                var total_discount = $('#total_discount').val();
                var forwarder_fee = $('#delivery_expense').val();
                var created_by = '{{Auth::user()->id}}';

                //for Sale_records
                var sale_records = new Array();
                $("#sale_tbody tr").each(function () {
                    var row = $(this);
                    var sd = {};
                    sd.product_id = row.find("td:eq(1) select").val();
                    sd.quantity = row.find("td:eq(2) input").val();
                    sd.price = row.find("td:eq(3) input").val();
                    sd.discount = row.find("td:eq(5) input").val();
                    sd.total_amount = row.find("td:eq(6) input").val();
                    if(sd.product_id > 0 && sd.price > 0 && sd.quantity > 0){
                        sale_records.push(sd);
                    }
                });
                var url = '{{ url('holdsale') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        Sale_date:sale_date,
                        Customer_select:customer_select,
                        Customer_name:customer_name, 
                        Customer_address:address,
                        Customer_contact:contact,
                        Delivery_fee:delivery_fee,
                        Total_discount:total_discount,
                        Total_amount:total_amount,
                        Forwarder_fee:forwarder_fee,
                        Seller:created_by,
                        Sale_records:sale_records
                    },
                success:function(response){
                    if(response.success){
                        toastr.success(response.message,"Hold Sales");
                        location.reload();
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });
            })
            $('#select_customer').on('change',function(){
                var customers = @php echo $customers @endphp;
                var id = $(this).val();
                if($(this).val() != 'new_customer'){
                    var value = customers.filter( function(customers){return (customers.id==id);} );
                    $('#customer_name').val(value[0]['customer_name']);
                    $('#customer_address').val(value[0]['address']);
                    $('#customer_contact').val(value[0]['contact']);
                }else{
                    $('#customer_name').val('');
                    $('#customer_address').val('');
                    $('#customer_contact').val('');
                }
            })
            $('#payment').on('click', function(){

                var seller = $('#seller').val();
                var sale_date = $('#sale_date').val();
                var customer_code = $('#select_customer').val();
                var customer_name = $('#customer_name').val();
                var address = $('#customer_address').val();
                var contact = $('#customer_contact').val();
                var total_qty = $('#total_qty').val();
                var grand_total = $('#grand_total').val();
                var delivery_fee = $('#delivery_fee').val();
                var total_discount = $('#total_discount').val();
                var amount_due = grand_total;

                var check = true;
                var sale_records = new Array();
                $("#sale_tbody tr").each(function () {
                    var row = $(this);
                    var sd = {};
                    sd.product_id = row.find("td:eq(1) select").val();
                    sd.product_name = row.find("td:eq(1) option:selected").text();
                    sd.quantity = row.find("td:eq(2) input").val();
                    sd.price = row.find("td:eq(3) input").val();
                    sd.discount = row.find("td:eq(5) input").val();
                    sd.total_amount = row.find("td:eq(6) input").val();
                    if(sd.product_id > 0 && sd.price > 0 && sd.quantity > 0){
                        sale_records.push(sd);
                    }
                    if(sd.product_id > 0 && sd.price <=0){
                        check = false;
                    }
                });
                if(customer_name == ""){
                    $('#customer_name').val("N/A");
                }
                if(address != "" && contact != "" ){
                    if(total_qty >0 && grand_total>0){
                        if(check == true){
                            $('#payment_modal').modal('show');
                        }else{
                            toastr.error('Unit Price must be bigger than 0','Unit Price Error');
                        }
                        $('#debt').attr('disabled','true');

                        $('.s_seller').text(seller);
                        $('.s_date').text(sale_date);
                        $('.cus_name').text(customer_name);
                        $('.cus_address').text(address);
                        $('.cus_tel').text(contact);
                        $('.total_qty_inv').text(total_qty);
                        $('.total_amount_inv').text(grand_total);
                        $('.delivery_fee_inv').text(delivery_fee);
                        $('.total_discount_inv').text(total_discount);
                        $('.amount_due_inv').text(amount_due);
                        $('.balance_inv').text(0);

                        // for invoice print
                        $.each(sale_records, function( key, value ) {
                            var no = parseInt(key) + 1;
                            $('#tbody_invoice').append('<tr>'+
                                '<td>'+ no +'</td>'+
                                '<td>'+ value['product_name'] +'</td>'+
                                '<td>'+ value['quantity'] +'</td>'+
                                '<td>'+ value['price'] +'</td>'+
                                '<td>'+ value['discount'] +'</td>'+
                                '<td>'+ value['total_amount'] +'</td>'+
                                '</tr>');
                        });
                    }else{
                        toastr.error("Make sure your data is correct! \r\nTotal QTY and Grand Total are less then 0");
                    }
                }else{
                    toastr.error("Please Fill Customer Address and Customer Contact!");
                }
                
                
            });
            $('#paid , #debt').on('click', function(){
 
                //for Sales;
                var id_update = id;
                var sale_date = $('#sale_date').val();
                var customer_select = $('#select_customer').val();
                var customer_name = $('#customer_name').val();
                var address = $('#customer_address').val();
                var contact = $('#customer_contact').val();
                var delivery_fee = $('#delivery_fee').val();
                var total_discount = $('#total_discount').val();
                var total_amount = $('#grand_total').val();
                var forwarder_fee = $('#delivery_expense').val();
                var net_amount = $('#net_amount').val();
                var created_by = '{{Auth::user()->id}}';
                var balance = $('#balance').val();

                //for Sale_records
                var sale_records = new Array();
                $("#sale_tbody tr").each(function () {
                    var row = $(this);
                    var sd = {};
                    sd.product_id = row.find("td:eq(1) select").val();
                    sd.quantity = row.find("td:eq(2) input").val();
                    sd.price = row.find("td:eq(3) input").val();
                    sd.discount = row.find("td:eq(5) input").val();
                    sd.total_amount = row.find("td:eq(6) input").val();
                    if(sd.product_id > 0 && sd.price > 0 && sd.quantity > 0){
                        sale_records.push(sd);
                    }
                });
                var current_url = window.location.href;
                var url = '{{ url('saleinsert') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        Id_update:id_update,
                        Sale_date:sale_date,
                        Customer_select:customer_select,
                        Customer_name:customer_name, 
                        Address:address,
                        Contact:contact,
                        Delivery_fee:delivery_fee,
                        Total_discount:total_discount,
                        Total_amount:total_amount,
                        Forwarder_fee:forwarder_fee,
                        Net_amount:net_amount,
                        Seller:created_by,
                        Balance:balance,
                        Sale_records:sale_records,
                        Current_url:current_url
                    },
                success:function(response){
                    if(response.success){
                        $('#payment_modal').modal('hide');

                        //for invoice
                        $('#balance_inv').text(balance);
                        if($("#print_invoice").prop('checked') == true){
                            printMe('invoice_print');
                        }
                        if($("#print_delivery").prop('checked') == true){
                            printMe('delivery_print');
                        }
                        toastr.success(response.message,"Sales");
                        window.location.href = response.redirect;//Refresh to back page
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });
            });
            $('#save_product').on('click', function(){
                var url = '{{ url('createproduct') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        Product_name:$('#new_product_name').val(),
                        Product_type:1
                    },
                success:function(response){
                    if(response.success){
                        var product_id = response.product_id;
                        var product_name = $('#new_product_name').val();
                        var option = '@php echo "<option value=\"0\">Select Product</option><option value=\"create\">Create New</option>".$option @endphp';
                        var arr_product = new Array;
                        
                        $("#sale_tbody tr").each(function(){
                            var row = $(this);
                            var sp = {};
                            sp.value = row.find("td:eq(1) select").val();;
                            sp.text = row.find("td:eq(1) option:selected").text();
                            if(sp.value > 0){
                                arr_product.push(sp);
                            }
                        })
                        // $(".product_name select").empty();
                        var current_row =0;
                        var except_row = 0;
                        $.each(arr_product, function(key,value ) {
                            var i = parseInt(key)+1;
                            var row = '#row'+i;
                            current_row = '#row'+(i+1);
                            except_row = i;             
                            $(row).val(value['value']);
                            $(row).append('<option value="'+product_id+'">'+product_name+'</option>');
                        });
            
                        $('#sale_tbody tr').each(function(i){
                            if(i>=except_row){   
                                var next_row = '#row'+(i+1);
                                $(next_row).append('<option value="'+product_id+'">'+product_name+'</option>');
                            }   
                        })
                        if(arr_product.length < 1){
                            $('#row1').val(product_id);
                        }
                        if(current_row !=0){
                            $(current_row).val(product_id);
                        }
                        $('.product_name').selectpicker('refresh');
                        $('#product_modal').modal('hide');
                        toastr.success(response.message,"Create New Product");
                        $('#new_product_name').val('');
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });
            });
           
            var rate = <?php echo $rate_kh->rate ?>;
            $('#amount_paid , #amount_paid_kh').change(function(){
                var amount_due = $('#amount_due').val() -0;
                var amount_due_kh = 0;
                var paid = $('#amount_paid').val() - 0;
                if(paid >= amount_due){
                    $('#amount_paid_kh').attr('disabled','true');
                }else{
                    $('#amount_paid_kh').removeAttr('disabled');
                }
                var paid_kh = $('#amount_paid_kh').val();
                var total_paid = (((paid_kh-0)/(rate-0)) + (paid-0));
                amount_due_kh = (amount_due - paid)*rate;
                $('#balance').val((total_paid - 0) - (amount_due - 0)); 
                $('#balance_kh').val(paid_kh - amount_due_kh);
                var balance = $('#balance').val()-0;
                if((balance-0) >= 0){
                    $('#debt').attr('disabled','true');
                    $('#paid').removeAttr('disabled');
                }else{
                    $('#debt').removeAttr('disabled');
                    $('#paid').attr('disabled','true');
                }
            });
            $('.toggleswitch').bootstrapToggle();

            //Init datepicker for date fields if data-datepicker attribute defined
            //or if browser does not handle date inputs
            $('.form-group input[type=date]').each(function (idx, elt) {
                if (elt.hasAttribute('data-datepicker')) {
                    elt.type = 'text';
                    $(elt).datetimepicker($(elt).data('datepicker'));
                } else if (elt.type != 'date') {
                    elt.type = 'text';
                    $(elt).datetimepicker({
                        format: 'L',
                        extraFormats: [ 'YYYY-MM-DD' ]
                    }).datetimepicker($(elt).data('datepicker'));
                }
            });

            @if ($isModelTranslatable)
                $('.side-body').multilingual({"editing": true});
            @endif

            $('.side-body input[data-slug-origin]').each(function(i, el) {
                $(el).slugify();
            });

            $('.form-group').on('click', '.remove-multi-image', deleteHandler('img', true));
            $('.form-group').on('click', '.remove-single-image', deleteHandler('img', false));
            $('.form-group').on('click', '.remove-multi-file', deleteHandler('a', true));
            $('.form-group').on('click', '.remove-single-file', deleteHandler('a', false));

            $('#confirm_delete').on('click', function(){
                $.post('{{ route('voyager.'.$dataType->slug.'.media.remove') }}', params, function (response) {
                    if ( response
                        && response.data
                        && response.data.status
                        && response.data.status == 200 ) {

                        toastr.success(response.data.message);
                        $file.parent().fadeOut(300, function() { $(this).remove(); })
                    } else {
                        toastr.error("Error removing file.");
                    }
                });

                $('#confirm_delete_modal').modal('hide');
            });
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
@stop
