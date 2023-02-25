@extends('voyager::master')
@section('page_title', __('voyager::generic.view').' '.$dataType->getTranslatedAttribute('display_name_singular'))
@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i> {{ __('voyager::generic.viewing') }} {{ ucfirst($dataType->getTranslatedAttribute('display_name_singular')) }} &nbsp;

        @can('edit', $dataTypeContent)
            <a href="{{ route('voyager.'.$dataType->slug.'.edit', $dataTypeContent->getKey()) }}" class="btn btn-info">
                <i class="glyphicon glyphicon-pencil"></i> <span class="hidden-xs hidden-sm">{{ __('voyager::generic.edit') }}</span>
            </a>
        @endcan
        @can('delete', $dataTypeContent)
            @if($isSoftDeleted)
                <a href="{{ route('voyager.'.$dataType->slug.'.restore', $dataTypeContent->getKey()) }}" title="{{ __('voyager::generic.restore') }}" class="btn btn-default restore" data-id="{{ $dataTypeContent->getKey() }}" id="restore-{{ $dataTypeContent->getKey() }}">
                    <i class="voyager-trash"></i> <span class="hidden-xs hidden-sm">{{ __('voyager::generic.restore') }}</span>
                </a>
            @else
                <a href="javascript:;" title="{{ __('voyager::generic.delete') }}" class="btn btn-danger delete" data-id="{{ $dataTypeContent->getKey() }}" id="delete-{{ $dataTypeContent->getKey() }}">
                    <i class="voyager-trash"></i> <span class="hidden-xs hidden-sm">{{ __('voyager::generic.delete') }}</span>
                </a>
            @endif
        @endcan
        @can('browse', $dataTypeContent)
        <a href="{{ route('voyager.'.$dataType->slug.'.index') }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">{{ __('voyager::generic.return_to_list') }}</span>
        </a>
        @endcan
        
        <!-- @php
            $status = $dataTypeContent['deleted_at'];
            if(is_null($status)){
                echo '<button class="btn btn-danger" id="return_stock" value="1"> Return to stock </button>';
            }else{
                echo '<button class="btn btn-danger" id="sold_it" value="0"> Sold it </button>';
            }
        @endphp -->
    </h1>
    @include('voyager::multilingual.language-selector')
@stop
@section('content')
    <div class="page-content read container-fluid">
        <div class="row">
            <div class="col-md-12">
                

                <div class="panel panel-bordered" style="padding-bottom:5px;">

                    @php
                        $customers = DB::table('customers')->select('customer_name','address','contact')
                                    ->where('id',$dataTypeContent['customer_id'])->first();
                    @endphp

                    <div class="col-sm-2">Sale Code: {{ $dataTypeContent['id'] }}</div>
                    <div class="col-sm-3">Customer name: {{ $customers->customer_name }}</div>
                    <div class="col-sm-4">Customer adress: {{ $customers->address }}</div>
                    <div class="col-sm-2">Customer contact: {{ $customers->contact }}</div>
                    <br>
                    <table class="table-striped">
                        <thead style="background-color:skyblue;">
                          <tr>
                            <th class="col-sm-1">No.</th>
                            <th class="col-sm-3">Product name</th>
                            <th class="col-sm-2">Quantity</th>
                            <th class="col-sm-2">Unit price</th>
                            <th class="col-sm-2">Discount</th>
                            <th class="col-sm-2">Amount</th>
                          </tr>
                        </thead>
                        <tbody>
                            <?php
                                $SaleRecords = DB::table('Sale_records')
                                                ->join('Products', 'Sale_records.product_id', '=', 'Products.id')
                                                ->select('Sale_records.*', 'Products.product_name')
                                                ->where('sale_id',$dataTypeContent['id'])
                                                ->get();
                                // echo $SaleRecord;
                                $total_qty = 0;

                                $Sale = DB::table('Sales')
                                            ->join('users', 'Sales.seller_id','=', 'users.id')
                                            ->select('users.name')
                                            ->where('Sales.id',$dataTypeContent['id'])
                                            ->first();
                            ?>
                    
                            @foreach($SaleRecords as $key => $saleData)

                                <tr>
                                    <td class="col-sm-1">{{ $key+1 }}</td>
                                    <td class="col-sm-3">{{ $saleData->product_name }}</td>
                                    <td class="col-sm-1">{{ $saleData->quantity }}</td>
                                    <td class="col-sm-1">{{ $saleData->unit_price }}</td>
                                    <td class="col-sm-1">{{ $saleData->discount }}</td>
                                    <td class="col-sm-1">{{ $saleData->amount }}</td>
                                    
                                </tr>
                                <?php $total_qty += $saleData->quantity ;?>

                            @endforeach
                        </tbody>
                        <thead>
                            <tr>
                                <td colspan="6"> &nbsp;</td> <!-- Blank Row-->
                                <td class="col-sm-2"></td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Sale Date:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['created_at'] }}</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Seller:</td>
                                <td class="col-sm-2">{{ $Sale->name }}</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Total Quantities:</td>
                                <td class="col-sm-2">{{ $total_qty }} pcs</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Delivery Fee:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['delivery_fee'] }}</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Discount(%):</td>
                                <td class="col-sm-2">{{ $dataTypeContent['discount'] }}</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Grand Total:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['amount'] }}</td>
                            </tr>
                            
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Delivery Expense:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['forwarder_fee'] }}</td>
                            </tr>
                            
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Net Amount:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['net_amount'] }}</td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                                <td class="col-sm-2">Balance:</td>
                                <td class="col-sm-2">{{ $dataTypeContent['balance'] }}</td>
                            </tr>
                        </thead>
                    </table>  
                </div>
            </div>
        </div>
    </div>

    {{-- Single delete modal --}}
    <div class="modal modal-danger fade" tabindex="-1" id="delete_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{{ __('voyager::generic.close') }}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"><i class="voyager-trash"></i> {{ __('voyager::generic.delete_question') }} {{ strtolower($dataType->getTranslatedAttribute('display_name_singular')) }}?</h4>
                </div>
                <div class="modal-footer">
                    <form action="{{ route('voyager.'.$dataType->slug.'.index') }}" id="delete_form" method="POST">
                        {{ method_field('DELETE') }}
                        {{ csrf_field() }}
                        <input type="submit" class="btn btn-danger pull-right delete-confirm"
                               value="{{ __('voyager::generic.delete_confirm') }} {{ strtolower($dataType->getTranslatedAttribute('display_name_singular')) }}">
                    </form>
                    <button type="button" class="btn btn-default pull-right" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
@stop
@section('javascript')
    @if ($isModelTranslatable)
        <script>
            $(document).ready(function () {
                $('.side-body').multilingual();
            });
        </script>
    @endif
    <script>
        $(document).ready(function () {
            //alert('Hello');
        })
        // $('#return_stock , #sold_it').on('click',function(){
        //     var url = '{{ url('return_stock') }}';
        //         $.ajax({
        //         url:url,
        //         method:'POST',
        //         data:{
        //                 id:"{{$dataTypeContent['id']}}",
        //                 status:$(this).val()
        //             },
        //         success:function(response){
        //             console.log(response.old_quantity);
        //             toastr.success(response.message);
        //             document.location.href = "{{ route('voyager.'.$dataType->slug.'.index') }}";
                 
        //         },
        //         error:function(error){
        //             console.log(error)
        //         }
        //         });
        // });
        var deleteFormAction;
        $('.delete').on('click', function (e) {
            var form = $('#delete_form')[0];

            if (!deleteFormAction) {
                // Save form action initial value
                deleteFormAction = form.action;
            }

            form.action = deleteFormAction.match(/\/[0-9]+$/)
                ? deleteFormAction.replace(/([0-9]+$)/, $(this).data('id'))
                : deleteFormAction + '/' + $(this).data('id');

            $('#delete_modal').modal('show');
        });

    </script>
@stop

