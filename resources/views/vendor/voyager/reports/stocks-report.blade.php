@extends('voyager::master')
@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
@stop
@section('page_header')
    
    <h1 class="page-title">
        <i class="voyager-list"></i>
       Stocks Report
    </h1>
    <select id="select_type" class="selectpicker">
        <option value="all">All</option>
        <option value="by_type">By Product Type</option>
        <option value="by_product">By Product</option>
    </select>
    <span id="span_product" style="display: none">
        <select id="product" class="selectpicker" data-live-search="true">
            <option value="all_product">All Products</option>
            @php
                $products_option = DB::table('products')->select('id','product_name')->get();
                foreach ($products_option as $key => $value) {
                    echo '<option value="'.$value->id.'">'.$value->id.'-'.$value->product_name.'</option>';
                }
            @endphp
        </select>
    </span>
    <span id="span_product_type" style="display: none">
        <select id="product_type" class="selectpicker" data-live-search="true">
            <option value="all_type">All Product Types</option>
            @php
                $types_option = DB::table('products_types')->select('id','type_name')->get();
                foreach ($types_option as $key => $value) {
                    echo '<option value="'.$value->id.'">'.$value->id.'-'.$value->type_name.'</option>';
                }
            @endphp
        </select>
    </span>
    <button id="btn_export" class="btn btn-success">Export to Excel</button>
    <button id="btn_export_pdf" class="btn btn-success">Export to PDF</button>
    @include('voyager::multilingual.language-selector')
@stop
@section('content')
    <div class="page-content edit-add container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <table id="dataTable" class="table">
                            <thead>
                                <tr>
                                    <th>Product_Code</th>
                                    <th>Product_Name</th>
                                    <th>Quantity</th>
                                    <th>Cost</th>
                                    <th>Price</th>
                                    <th data-tableexport-display='none'>Action</th>
                                </tr>
                            </thead>
                            <tbody id="stock_data">

                            </tbody>
                        {{-- </table> --}}
                    </div><!-- panel-body -->

                    <div class="panel-footer">
                            <tr>
                                <th>Total Quantities :<span id="sum_qty"></span></th>
                                <th>Total Cost :<span id="sum_cost"></span></th>
                                <th>Total Price :<span id="sum_price"></span></th>
                                <th>Total Profit :<span id="sum_profit"></span></th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
@stop
@section('css')
@stop
@section('javascript')
    <script>
    $(document).ready(function() {
        
        // Create our number formatter.
        var formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
        });
        var condition = 'all';
        var condition2 = 'all_product';
        get_stock_report(condition,condition2);
        $('#select_type').on('change',function(){
            condition = $('#select_type').val();
            if(condition == 'by_product'){
                document.getElementById('span_product').style.display = "inline";
                document.getElementById('span_product_type').style.display = "none";
                condition2 = 'all_product';
            }else if(condition == 'by_type'){
                document.getElementById('span_product').style.display = "none";
                document.getElementById('span_product_type').style.display = "inline";
                condition2 = 'all_type';
            }else if(condition == 'all'){
                document.getElementById('span_product').style.display = "none";
                document.getElementById('span_product_type').style.display = "none";
            }
            get_stock_report(condition,condition2);
        })
        $('#product_type , #product').on('change',function(){
            condition2 = $(this).val();
            get_stock_report(condition,condition2);
        })
        function get_stock_report(report_type,report_detail) {
            var url = '{{ url('get_stock_report') }}';
            // console.log(url);
            $.ajax({
            url:url,
            method:'POST',
            data:{
                    report_type:report_type,
                    report_detail:report_detail
                },
            success:function(response){
                // console.log(response.stocks);
                if(response.stocks.length>0){
                    var tr ='';
                    var sum_qty = 0,sum_cost=0,sum_price=0,sum_profit=0;
                    response.stocks.forEach(stock_data => {
                        tr +="<tr>"+
                                "<td>"+stock_data['product_code']+"</td>"+
                                "<td>"+stock_data['product_name']+"</td>"+
                                "<td>"+stock_data['total_qty']+"</td>"+
                                "<td>"+formatter.format(stock_data['cost'])+"</td>"+
                                "<td>"+formatter.format(stock_data['sale_price'])+"</td>"+
                                "<td data-tableexport-display='none'><a href='{{url('admin/product-stocks')}}/"+stock_data['id']+"' target='_blank' class='btn-xs btn-info'> <span class='voyager-eye'></span> View</a></td>"+
                                "</tr>";
                        sum_qty += (stock_data['total_qty']-0);
                        sum_cost += ((stock_data['cost']-0)*(stock_data['total_qty']-0));
                        sum_price += ((stock_data['sale_price']-0)*(stock_data['total_qty']-0));
                    });
                    $('#stock_data').empty().append(tr);
                    // $('#dataTable').DataTable();
                    $('#sum_qty').text(sum_qty);
                    $('#sum_cost').text(formatter.format(sum_cost));
                    $('#sum_price').text(formatter.format(sum_price));
                    sum_profit = sum_price - sum_cost;
                    $('#sum_profit').text(formatter.format(sum_profit));
                }else{
                    $('#stock_data').empty().append('<tr><td colspan="7"><center style="color:red">No Data</center></td></tr>');
                    $('#sum_qty').text(0);
                    $('#sum_cost').text(formatter.format(0));
                    $('#sum_price').text(formatter.format(0));
                    $('#sum_profit').text(formatter.format(0));
                }
            },
            error:function(error){
                console.log(error)
            }
            });
        }
        
        var file_name = 'stock_report-'+ new Date().toISOString();
        $('#btn_export').on('click',function(){
            $('#dataTable').tableExport({fileName: file_name,type:'excel',
                        mso:{
                                fileFormat:'xlsx',
                                worksheetName: ['Table 1','Table 2', 'Table 3']
                            }
                        });
        })
        $('#btn_export_pdf').on('click',function(){
            $('#dataTable').tableExport({fileName: file_name,type:'pdf',
                           pdfmake:{enabled:true,
                                    docDefinition:{pageOrientation:'landscape'}
                                }
                          });
        })
    } );
    </script>
@stop