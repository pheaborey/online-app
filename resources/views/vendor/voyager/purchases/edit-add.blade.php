@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
    $rate_kh = DB::table('currencies')->select('rate','symbol')->where('id','1')->first();
    $rate_visa = DB::table('currencies')->select('rate','symbol')->where('id','3')->first();

    $products = DB::table('Products')->select('id','product_name')->get();
    $suppliers = DB::table('suppliers')->select('id','supplier_name','supplier_address','supplier_contact')->get();
    $supplier_option ='';
    $option ='';
    $po_record = DB::table('Purchase_records')
                        ->select('po_code','product_code','quantity','sale_price','cost','cost_amount','created_at')
                        ->get();
    $purchase = DB::table('Purchases')->select('*')->get();
    $default_row = 5;
    $tr = '';
    if ($edit == "") {//$edit is a general variable of voyarger for check edit or add
        // echo "Add";
        // $po_no = DB::table('Purchases')->select('id')->latest('id')->first()->id +1;
        $po_id = DB::table('Purchases')->select('id')->latest('id')->first();
        if($po_id != NULL){
            $po_no = $po_id->id +1;
        }else{
            $po_no = 0;
        }
    }else{
        // echo "Edit".$edit;
        $url = $_SERVER['REQUEST_URI'];
        $values = parse_url($url);
        $host = explode('/edit',$values['path']);//cut end
        $host2 = explode('purchases',$values['path']);//cut begin
        $edit = substr($host[0],(strlen($host2[0])+10));//select only purchases id
        $purchase = DB::table('Purchases')->select('*')->where('id',$edit)->get();
        $po_record = DB::table('Purchase_records')
                        ->select('po_code','product_code','quantity','sale_price','cost','cost_amount','created_at')
                        ->where('po_code',$edit)->get();
        $default_row = $po_record->count();
        $po_no = $edit;
    }
    foreach ($products as $key=>$item){
        $option .= '<option value="'. $item->id .'">'. $item->product_name . '</option>';
    }
    foreach ($suppliers as $item){
        $supplier_option .= '<option value="'. $item->id .'">'. $item->supplier_name .' - '.$item->supplier_address.' - '.$item->supplier_contact. '</option>';
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
    <button type="button" class="btn btn-success" id="btn_addRow" style="margin-right: 30px">Add Row</button>
    <label for="select_supplier">Supplier</label>
    <select class="selectpicker" id="select_supplier" data-live-search="true">
        <option value="new_supplier">New Supplier</option>
        @php echo $supplier_option @endphp   
    </select>
    {{-- <span style="float: right; padding-top:43px;">Exchange Rate: $1 = <?php echo $rate_kh->rate ." ". $rate_kh->symbol ?></span> --}}
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
                                <div class="col-sm-4">                   
                                    <input type="text" name="supplier_name" class="form-control" placeholder="Supplier Name" id="supplier_name">
                                </div>
                                <div class="col-sm-4">                   
                                    <input type="text" class="form-control" placeholder="Supplier Address" id="supplier_address">
                                </div>
                                <div class="col-sm-4" style="padding-bottom:5px;">                   
                                    <input type="text" class="form-control" placeholder="Supplier Contact" id="supplier_contact">
                                </div>
                                <table class="table-striped" id="sale_table">
                                    <thead style="background-color:skyblue;">
                                    <tr>
                                        <th class="col-sm-1">No.</th>
                                        <th class="col-sm-3">Product_Name</th>
                                        <th class="col-sm-1">Quantity</th>
                                        <th class="col-sm-1">Cost</th>
                                        <th class="col-sm-1">Cost_Amount</th>
                                        <th class="col-sm-1">Sale_Price</th>
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
                                                        '<td> <input type="text" id="cost'.$x.'" class="cost form-control" placeholder="Type Cost"> </td>'.
                                                        '<td> <input type="text" id="cost_amount'.$x.'" class="cost_amount form-control" disabled> </td>'.
                                                        '<td> <input type="text" id="sale_price'.$x.'" class="sale_price form-control" placeholder="Type Sale Price"> </td>'.
                                                    '</tr>';
                                            }
                                            
                                        @endphp
                                        
                                    </tbody>
                                    <thead>
                                        <tr>
                                            <td>&nbsp;</td> <!-- Blank Row-->
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="po_date" class="col-sm-5">PO Date</label>
                                                    <div class="col-sm-7">
                                                    <input type="date" class="form-control" id="po_date" value="<?php echo date('Y-m-d');?>">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="buyer" class="col-sm-5">Buyer</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="buyer" value="{{Auth::user()->name}}" disabled val_id="{{Auth::user()->id}}">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
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
                                            <td colspan="3"></td>
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
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="freight_fee" class="col-sm-5">Freight Fee</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="freight_fee" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
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
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="visa_fee" class="col-sm-5">Visa fee <span>({{ $rate_visa->rate}}%)</span></label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="visa_fee" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="forwarder_fee" class="col-sm-5">Forwarder fee</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="forwarder_fee" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"></td>
                                            <td colspan="3">
                                                <div class="form-group">
                                                    <label for="other_fee" class="col-sm-5">Other fee</label>
                                                    <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="other_fee" value="0">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="3"></td>
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
                <td>Company LOGO</td>
                <td><center><h4>PO Invoice</h4></center></td>
            </tr>
            <tr>
                <td colspan="3">Supplier Name:<span id="sup_name">Supplier name here </span></td>
                <td></td><td></td>
                <td>PO Code: <span id="po_no"><?php echo $po_no ?></span></td>
            </tr>
            <tr>
                <td colspan="3">Tel: <span id="sup_tel">Telephone here</span></td>
                <td></td><td></td>
                <td>PO Date: <span id="p_date">PO Date here</span></td>
            </tr>
            <tr>
                <td colspan="3">Address: <span id="sup_address">Address here</span></td>
                <td></td><td></td>
                <td>Buyer: <span id="p_buyer">Buyer here</span></td>
            </tr>
        </table>
        <table class="table">
            <thead>         
                <tr>
                    <th>No.</th>
                    <th>Product Name</th>
                    <th>QTY</th>
                    <th>Cost</th>
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
                    <td>Total QTY</td>
                    <td><p id="total_qty_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Total Amount</td>
                    <td><p id="total_amount_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Freight Fee</td>
                    <td><p id="freight_fee_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Discount</td>
                    <td><p id="total_discount_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Visa Fee</td>
                    <td><p id="visa_fee_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Amount Due</td>
                    <td><p id="amount_due_inv"></p></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Balance</td>
                    <td><p id="balance_inv"></p></td>
                </tr>
            </tfoot>
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
                                <label for="print_invoice"> Print PO Invoice</label><br>
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

                var purchase = @php echo $purchase @endphp;
                var purchase_arr = purchase.filter( function(purchase){return (purchase.id==id);} );
                $('#po_date').val(purchase_arr[0]['purchase_date']);

                var supplier_id = purchase_arr[0]['supplier_code'];
                var suppliers = @php echo $suppliers @endphp;
                var value = suppliers.filter( function(suppliers){return (suppliers.id==supplier_id);} );
                $('#supplier_name').val(value[0]['supplier_name']);
                $('#supplier_address').val(value[0]['supplier_address']);
                $('#supplier_contact').val(value[0]['supplier_contact']);
                $('#select_supplier').val(supplier_id).selectpicker('refreh').trigger('change');

                var po_record = @php echo $po_record @endphp;
                var product = @php echo $products @endphp;
                var default_row = '@php echo $default_row @endphp';
                var po_code = po_record.filter( function(po_record){return (po_record.po_code==id);} );
                
                for(i=1 ; i <= default_row ; i++){
                    var selected_product = '#row' + i;
                    var cost = '#cost' + i;
                    var sale_price = '#sale_price' + i;
                    var qty = '#qty' + i;
                    var cost_amount = '#cost_amount' + i;
                    var value = po_code[i-1]['product_code'];
                    var name = product.filter( function(product){return (product.id==value);} );
                    // console.log(name[0]['product_name']);
                    // $(selected_product).append('<option selected value="'+value+'">'+name[0]['product_name']+'</option>');
                    $(selected_product).val(value);
                    $(qty).val(po_code[i-1]['quantity']);
                    $(cost).val(po_code[i-1]['cost']);
                    $(sale_price).val(po_code[i-1]['sale_price']);
                    $(cost_amount).val(po_code[i-1]['quantity'] * po_code[i-1]['cost']);
                }

                calc_total();
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
                    var value = $(this).val();
                    if(value == 'create'){
                        $('#product_modal').modal('show');
                    }
                    var parent = $(this).closest('tr');
                    var id = parent.find("td:eq(1) select").val();
                    @php $cost = DB::table('Product_stocks')->select('sale_price','product_code','cost')->get(); @endphp;
                    var newCost = @php echo $cost @endphp;
                    var newPrice = 0;
                    var getCost = newCost.filter( function(newCost){return (newCost.product_code==id);} );
                    if(getCost.length>0){
                        newCost = getCost[0]['cost'];
                        newPrice = getCost[0]['sale_price'];
                    }else{
                        newCost = 0;
                        newPrice = 0;
                    }
                    
                    var qty = parent.find("td:eq(2) input").val(1);
                    var cost = parent.find("td:eq(3) input").val(newCost);
                    var cost_amount = parent.find("td:eq(4) input").val(cost.val()*qty.val());
                    var sale_price = parent.find("td:eq(5) input").val(newPrice);
                    
                    calc_total();
                })
                $('.cost , .qty , .sale_price , #freight_fee , #total_discount , #forwarder_fee, #visa_fee, #other_fee').change(function(){
                    var parent = $(this).closest('tr');
                    var qty = parent.find("td:eq(2) input").val();
                    var cost = parent.find("td:eq(3) input").val();     
                    var cost_amount = parent.find("td:eq(4) input").val(cost*qty);
                    var sale_price = parent.find("td:eq(5) input").val();
                    calc_total();
                })
            }
            function calc_total(){
                var sum_amount = 0;
                var sum_qty = 0;
                $(".cost_amount").each(function(){
                    sum_amount += ($(this).val()-0);
                });
                $(".qty").each(function(){
                    sum_qty +=($(this).val()-0)
                })
                var grand_total = $('#grand_total').val(sum_amount);
                var gross_amount = (grand_total.val()-0)+($('#freight_fee').val()-0) - ($('#total_discount').val()-0);
                var rate_visa = '@php echo $rate_visa->rate @endphp';
                var visa_fee = $('#visa_fee').val(gross_amount * (rate_visa/100));
                $('#total_qty').val(sum_qty);
                $('#net_amount').val((gross_amount-0)+($('#visa_fee').val()-0)+($('#forwarder_fee').val()-0)+($('#other_fee').val()-0));
                document.getElementById("amount_due").value = ((gross_amount-0) + (visa_fee.val()-0));
                document.getElementById("amount_due_kh").value = (gross_amount-0)* <?php echo $rate_kh->rate ?>;
                document.getElementById("amount_paid").value = document.getElementById("amount_due").value;
                document.getElementById("balance").value = document.getElementById("amount_paid").value - document.getElementById("amount_due").value;
                document.getElementById("balance_kh").value = 0;
            }
            $('#select_supplier').on('change',function(){
                var suppliers = @php echo $suppliers @endphp;
                var id = $(this).val();
                if($(this).val() != 'new_supplier'){
                    var value = suppliers.filter( function(suppliers){return (suppliers.id==id);} );
                    $('#supplier_name').val(value[0]['supplier_name']);
                    $('#supplier_address').val(value[0]['supplier_address']);
                    $('#supplier_contact').val(value[0]['supplier_contact']);
                }else{
                    $('#supplier_name').val('');
                    $('#supplier_address').val('');
                    $('#supplier_contact').val('');
                }
            })
            $('#payment').on('click', function(){

                var buyer = $('#buyer').val();
                var po_date = $('#po_date').val();
                var supplier_code = $('#select_supplier').val();
                var supplier_name = $('#supplier_name').val();
                var supplier_address = $('#supplier_address').val();
                var supplier_contact = $('#supplier_contact').val();
                var total_qty = $('#total_qty').val();
                var grand_total = $('#grand_total').val();
                var total_discount = $('#total_discount').val();
                var freight_fee = $('#freight_fee').val();
                var visa_fee = $('#visa_fee').val();
                var amount_due = (grand_total-0)+(freight_fee-0)+(visa_fee-0) - (total_discount-0);
                var check = true;
                var check_cost = true;
                var po_records = new Array();
                $("#sale_tbody tr").each(function () {
                    var row = $(this);
                    var po = {};
                    po.product_code = row.find("td:eq(1) select").val();
                    po.product_name = row.find("td:eq(1) option:selected").text();
                    po.quantity = row.find("td:eq(2) input").val();
                    po.cost = row.find("td:eq(3) input").val();
                    po.sale_price = row.find("td:eq(5) input").val();
                    po.cost_amount = row.find("td:eq(4) input").val();
                    if(po.product_code > 0 && po.cost > 0 && po.quantity > 0){
                        po_records.push(po);
                    }
                    if(po.product_code > 0 && po.cost <=0){
                        check = false;
                        check_cost = false;
                    }
                });
                if(supplier_name =="" && supplier_contact =="" && supplier_address ==""){
                    toastr.error("Please input aleast one of supplier info!");
                    check = false;
                }else{
                    if(supplier_name == ""){
                        $('#supplier_name').val("N/A");
                    }
                    if(supplier_contact == ""){
                        $('#supplier_contact').val("N/A");
                    }
                    if(supplier_address == ""){
                        $('#supplier_address').val("N/A");
                    }
                }
                
                if(total_qty >0 && grand_total>0){
                    if(check == true){
                        $('#payment_modal').modal('show');
                    }
                    if(check_cost == false){
                        toastr.error('Cost must be bigger than 0','Cost Error');
                    }
                    $('#debt').attr('disabled','true');

                    $('#p_buyer').text(buyer);
                    $('#p_date').text(po_date);
                    $('#sup_name').text(supplier_name);
                    $('#sup_address').text(supplier_address);
                    $('#sup_tel').text(supplier_contact);
                    $('#total_qty_inv').text(total_qty);
                    $('#total_amount_inv').text(grand_total);
                    $('#freight_fee_inv').text(freight_fee);
                    $('#total_discount_inv').text(total_discount);
                    $('#visa_fee_inv').text(visa_fee);
                    $('#amount_due_inv').text(amount_due);
                    $('#balance_inv').text(0);

                    // for invoice print
                    $.each(po_records, function( key, value ) {
                        var no = parseInt(key) + 1;
                        $('#tbody_invoice').append('<tr>'+
                            '<td>'+ no +'</td>'+
                            '<td>'+ value['product_name'] +'</td>'+
                            '<td>'+ value['quantity'] +'</td>'+
                            '<td>'+ value['cost'] +'</td>'+
                            '<td>'+ value['cost_amount'] +'</td>'+
                            '</tr>');
                    });
                }else{
                    toastr.error("Make sure your data is correct! \r\nTotal QTY and Grand Total are less then 0");
                }
                
                
            });
            $('#paid , #debt').on('click', function(){
 
                //for Purchases;
                var id_update = id;
                var po_date = $('#po_date').val();
                var supplier_code = $('#select_supplier').val();
                var supplier_name = $('#supplier_name').val();
                var supplier_address = $('#supplier_address').val();
                var supplier_contact = $('#supplier_contact').val();
                var freight_fee = $('#freight_fee').val();
                var total_discount = $('#total_discount').val();
                var total_quantity = $('#total_qty').val();
                var total_amount = $('#grand_total').val();
                var forwarder_fee = $('#forwarder_fee').val();
                var visa_fee = $('#visa_fee').val();
                var other_fee = $('#other_fee').val();
                var net_amount = $('#net_amount').val();
                var created_by = '{{Auth::user()->id}}';
                var balance = $('#balance').val();

                //for PO_records
                var po_records = new Array();
                $("#sale_tbody tr").each(function () {
                    var row = $(this);
                    var po = {};
                    po.product_code = row.find("td:eq(1) select").val();
                    po.quantity = row.find("td:eq(2) input").val();
                    po.cost = row.find("td:eq(3) input").val();
                    po.sale_price = row.find("td:eq(5) input").val();
                    po.cost_amount = row.find("td:eq(4) input").val();
                    if(po.product_code > 0 && po.cost > 0 && po.quantity > 0){
                        po_records.push(po);
                    }
                });
                var current_url = window.location.href;
                var url = '{{ url('poinsert') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        Id_update:id_update,
                        Po_date:po_date,
                        Supplier_code:supplier_code,
                        Supplier_name:supplier_name, 
                        Supplier_address:supplier_address,
                        Supplier_contact:supplier_contact,
                        Freight_fee:freight_fee,
                        Total_discount:total_discount,
                        Total_amount:total_amount,
                        Total_quantity:total_quantity,
                        Forwarder_fee:forwarder_fee,
                        Visa_fee:visa_fee,
                        Other_fee:other_fee,
                        Net_amount:net_amount,
                        Buyer:created_by,
                        Balance:balance,
                        Po_records:po_records,
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
                        toastr.success(response.message,"Purchases");
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
                        var product_code = response.product_code;
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
                            $(row).append('<option value="'+product_code+'">'+product_name+'</option>');
                        });
            
                        $('#sale_tbody tr').each(function(i){
                            if(i>=except_row){   
                                var next_row = '#row'+(i+1);
                                $(next_row).append('<option value="'+product_code+'">'+product_name+'</option>');
                            }   
                        })
                        if(arr_product.length < 1){
                            $('#row1').val(product_code);
                        }
                        if(current_row !=0){
                            $(current_row).val(product_code);
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
            function printMe(element_id){
                document.getElementById(element_id).style.display = "block";
                var printContents = document.getElementById(element_id).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
                document.getElementById(element_id).style.display = "none";
            };
           
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
